#!/usr/bin/env python3
"""
OLT ONU Monitor - Count ONU online/offline per PON via Telnet
Push to Zabbix | Save offline ONU details + portal match to JSON
Cron: tiap 5 menit (with lock to prevent overlap)
"""

import telnetlib, time, socket, json, re, os, sys, requests
from datetime import datetime
import urllib3; urllib3.disable_warnings()

ZABBIX_SERVER, ZABBIX_PORT = "127.0.0.1", 10051
DATA_FILE = "/opt/tekra-backup/data/olt_onu_offline.json"
LOCK_FILE = "/tmp/olt_onu_monitor.lock"
PORTAL_AUTH = {"email":"asep@tekra.id","password":"12345"}

OLTS = [
    {"name":"OLT-EPON-PUSAT","host":"10.10.10.203","user":"root","pass":"admin","zabbix":"OLT-EPON-PUSAT-SNMP","max":64,"pons":4,"type":"epon"},
    {"name":"OLT-GPON-PUSAT","host":"10.10.10.204","user":"root","pass":"k34Nu335577","zabbix":"OLT-GPON-PUSAT-SNMP","max":128,"pons":8,"type":"gpon"},
]

def zbx(host, key, value):
    try:
        data = {"request":"sender data","data":[{"host":host,"key":key,"value":str(value)}]}
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        sock.settimeout(5); sock.connect((ZABBIX_SERVER, ZABBIX_PORT))
        sock.send(b"ZBXD\x01" + len(json.dumps(data)).to_bytes(8, 'little') + json.dumps(data).encode())
        sock.close()
    except: pass

def portal_search(name):
    try:
        s = requests.Session()
        s.post("https://portal.tekra.id/auth", data=PORTAL_AUTH, verify=False, timeout=10)
        r = s.get(f"https://portal.tekra.id/customer/getdata?draw=1&start=0&length=5&search={name}", verify=False, timeout=10)
        return r.json().get("data", [])
    except:
        return []

def scan_epon_pon(host, pon):
    tn = telnetlib.Telnet(host, 23, timeout=20)
    tn.read_until(b"username:", timeout=15)
    tn.write(b"root\r\n"); tn.read_until(b"assword:", timeout=10)
    tn.write(b"admin\r\n"); time.sleep(1.5); tn.read_very_eager()
    tn.write(b"enable\r\n"); time.sleep(1); tn.read_very_eager()
    sock = tn.get_socket()
    sock.send(b"configure\r\n"); time.sleep(1); tn.read_very_eager()
    sock.send(bytes(f"interface epon {pon}\r\n","utf-8")); time.sleep(1); tn.read_very_eager()
    sock.send(b"show onu-info all\r\n"); time.sleep(10)
    output = tn.read_very_eager().decode(errors='replace')
    tn.close()
    
    online, offline = 0, 0
    offline_list = []
    for line in output.split('\n'):
        parts = line.split()
        if len(parts) >= 6 and '/' in parts[0] and ':' in parts[1]:
            status = parts[2].lower()
            reg_time = f"{parts[5]} {parts[6]}" if len(parts) > 6 else ""
            name = parts[7] if len(parts) > 7 else ""
            if status == 'online': online += 1
            elif status in ('offline', 'poweroff'):
                offline += 1
                offline_list.append({"pon_onu":parts[0],"mac":parts[1],"name":name,"last_online":reg_time,"pon":pon})
    return online, offline, offline_list

def scan_gpon_pon(host, pon):
    tn = telnetlib.Telnet(host, 23, timeout=20)
    tn.read_until(b"username:", timeout=15)
    tn.write(b"root\r\n"); tn.read_until(b"assword:", timeout=10)
    tn.write(b"k34Nu335577\r\n"); time.sleep(1.5); tn.read_very_eager()
    tn.write(b"enable\r\n"); time.sleep(1); tn.read_very_eager()
    sock = tn.get_socket()
    sock.send(b"configure\r\n"); time.sleep(1); tn.read_very_eager()
    sock.send(bytes(f"interface gpon {pon}\r\n","utf-8")); time.sleep(1); tn.read_very_eager()
    sock.send(b"show ont-info 0\r\n"); time.sleep(1.5)
    if 'ONU ID' not in tn.read_very_eager().decode(errors='replace'):
        tn.close(); return 0, 0, []
    
    online, offline = 0, 0
    offline_list = []
    for onu_id in range(0, 128):
        sock.send(bytes(f"show ont-info {onu_id}\r\n","utf-8"))
        time.sleep(0.5)
        data = tn.read_very_eager().decode(errors='replace')
        if 'Run State' in data:
            name_m = re.search(r'ONU Name\s+:\s+(.+)', data)
            last_up = re.search(r'Last up Time\s+:\s+(.+)', data)
            last_down = re.search(r'Last down Time\s+:\s+(.+)', data)
            onu_name = name_m.group(1).strip() if name_m else f"ONT{pon:02d}/{onu_id:03d}"
            last_time = last_up.group(1).strip() if last_up else (last_down.group(1).strip() if last_down else "unknown")
            if 'Online' in data: online += 1
            elif 'Offline' in data:
                offline += 1
                offline_list.append({"pon_onu":f"{pon}/{onu_id}","mac":"GPON-ONU","name":onu_name,"last_online":last_time,"pon":pon})
        elif 'ONU ID' not in data and onu_id > 3: break
    tn.close()
    return online, offline, offline_list

# ─── MAIN ───
if __name__ == "__main__":
    # Lock
    if os.path.exists(LOCK_FILE):
        age = time.time() - os.path.getmtime(LOCK_FILE)
        if age < 900:
            print(f"Locked ({age:.0f}s). Exit."); sys.exit(0)
    with open(LOCK_FILE, 'w') as f: f.write(str(os.getpid()))
    
    try:
        os.makedirs(os.path.dirname(DATA_FILE), exist_ok=True)
        all_offline = {}
        
        for olt in OLTS:
            print(f"\n[{olt['name']}]")
            scanner = scan_epon_pon if olt['type'] == 'epon' else scan_gpon_pon
            olt_offline = []
            
            for pon in range(1, olt['pons']+1):
                try:
                    online, offline, offline_list = scanner(olt['host'], pon)
                    total = online + offline
                    pct = round(total / olt['max'] * 100, 1)
                    print(f"  PON{pon}: Online={online}  Offline={offline}  Total={total}  ({pct}%)")
                    
                    zbx(olt['zabbix'], f"olt.onu.online.pon{pon}", online)
                    zbx(olt['zabbix'], f"olt.onu.offline.pon{pon}", offline)
                    zbx(olt['zabbix'], f"olt.onu.total.pon{pon}", total)
                    zbx(olt['zabbix'], f"olt.onu.capacity.pct.pon{pon}", pct)
                    
                    if offline_list:
                        for o in offline_list:
                            matches = portal_search(o['name'])
                            pinfo = ""
                            for c in matches:
                                if o['name'].upper() in c.get('name','').upper() or c.get('name','').upper() in o['name'].upper():
                                    pinfo = f"ID={c['id']} {c['name']} Status={c['status']}"; break
                            if not pinfo and matches:
                                c = matches[0]; pinfo = f"ID={c['id']} {c['name']} Status={c['status']}"
                            o['portal'] = pinfo
                            print(f"    ⚠️ {o['pon_onu']} | {o['mac']} | {o['name']} | Last: {o['last_online']} | Portal: {pinfo or 'NOT FOUND'}")
                        olt_offline.extend(offline_list)
                except Exception as e:
                    print(f"  PON{pon}: ERROR - {e}")
            
            all_offline[olt['name']] = {"updated": datetime.now().strftime("%Y-%m-%d %H:%M:%S"), "offline_onu": olt_offline}
        
        with open(DATA_FILE, 'w') as f:
            json.dump(all_offline, f, indent=2)
        print(f"\nSaved to {DATA_FILE}")
    finally:
        if os.path.exists(LOCK_FILE):
            os.remove(LOCK_FILE)
