#!/usr/bin/env python3
"""
TekraNet Auto Activation v5.0 — Multi Portal
Flow: Generate clean no → PPPoE via portal API → Aktivasi → Report
Modes:
  --nama <NAME>           : aktivasi satu pelanggan
  --raw "<TEXT>"          : parse nama dari teks
  --all --portal <PORTAL> : proses SEMUA pelanggan Menunggu di portal
Portals: pusat | dago | katapang
"""

import requests, re, sys, argparse, os
from datetime import datetime
import urllib3; urllib3.disable_warnings()

AUTH = {"email": "asep@tekra.id", "password": "12345"}

# ============= PORTAL CONFIG =============
PORTALS = {
    "pusat": {
        "url": "https://portal.tekra.id",
        "label": "PUSAT",
        "default_router": 2,        # PUSAT X86
        "router_name": "PUSAT X86",
        "coverage_map": {           # coverage ID → (router_id, router_name, area_name)
            "14": (3, "CILISUNG GX4", "Cilisung"),
            "16": (3, "CILISUNG GX4", "Sekeawi"),
            "23": (3, "CILISUNG GX4", "Citamiang"),
        },
        "email_domain": "tekra.id",
        "create_by": "1051",
    },
    "dago": {
        "url": "https://north.my.id",
        "label": "DAGO",
        "default_router": 1,        # UTARA
        "router_name": "DAGO UTARA",
        "coverage_map": {},          # semua ke default_router
        "email_domain": "tekra.id",
        "create_by": "1051",
    },
    "katapang": {
        "url": "https://southnet.my.id",
        "label": "KATAPANG",
        "default_router": 1,        # Master
        "router_name": "KATAPANG",
        "coverage_map": {},          # semua ke default_router
        "email_domain": "tekra.id",
        "create_by": "1051",
    },
}

PROFILES = {
    '119000':'PAKET HEMAT','150000':'PAKET1','165000':'PAKET3',
    '159000':'PAKET MANTAP','199000':'PAKET PUAS','200000':'PAKET2',
    '275000':'PAKET PUAS','300000':'PAKET3',
}

PROCESSED_DIR = "/tmp/auto_aktivasi"

def log(msg): print(f"  {msg}", file=sys.stderr)

def parse_name(text):
    m = re.search(r'(?:aktifasi|aktivasi|aktipasi)\s+([A-Za-z0-9\s]+)', text, re.I)
    return m.group(1).strip() if m else None

def generate_no():
    n = datetime.now()
    return f"{n.year%100:02d}{n.month:02d}{n.day:02d}{n.hour:02d}{n.minute:02d}{n.second:02d}"

def processed_file(portal_key):
    os.makedirs(PROCESSED_DIR, exist_ok=True)
    return f"{PROCESSED_DIR}/{portal_key}_processed.txt"

def load_processed(portal_key):
    pf = processed_file(portal_key)
    if not os.path.exists(pf): return set()
    with open(pf) as f: return set(line.strip() for line in f)

def mark_processed(portal_key, cid):
    with open(processed_file(portal_key), 'a') as f: f.write(f"{cid}\n")

def get_router(cfg, coverage):
    """Determine router ID and name from coverage ID."""
    cov_str = str(coverage)
    if cov_str in cfg["coverage_map"]:
        rid, rname, area = cfg["coverage_map"][cov_str]
        return rid, rname, area
    return cfg["default_router"], cfg["router_name"], cfg["label"]

def scan_menunggu(cfg):
    """Return list of {name, id} for all Menunggu customers."""
    s = requests.Session()
    r = s.post(f"{cfg['url']}/auth", data=AUTH, verify=False, timeout=15)
    if r.status_code != 200:
        log(f"Login gagal: {cfg['label']}")
        return []

    r = s.post(f"{cfg['url']}/customer/getfiltercoverage/", data={'search': ''}, verify=False, timeout=10)
    results = []
    for row in r.json().get('data', []):
        if len(row) > 7 and 'Menunggu' in str(row[7]):
            results.append({'id': row[0], 'name': row[2]})
    return results

def activate(nama_or_no, cfg, session=None):
    s = session or requests.Session()
    own_session = session is None
    today = datetime.now().strftime("%Y-%m-%d")
    due_day = str(datetime.now().day)
    PORTAL = cfg["url"]

    if own_session:
        r = s.post(f"{PORTAL}/auth", data=AUTH, verify=False, timeout=15)
        if r.status_code != 200: return {"success": False, "error": "Login gagal"}
        log("Login OK")

    # 1. Find Menunggu customer
    r = s.post(f"{PORTAL}/customer/getfiltercoverage/", data={'search': nama_or_no}, verify=False, timeout=10)
    cust = None
    for row in r.json().get('data', []):
        if (nama_or_no.upper() in row[2].upper() or nama_or_no.replace('R-','') in row[3]) and 'Menunggu' in str(row[7]):
            cust = {'id': row[0], 'name': row[2]}; break
    if not cust: return {"success": False, "error": f"'{nama_or_no}' tidak ditemukan / bukan Menunggu"}
    log(f"Found: {cust['name']} (ID={cust['id']})")

    # 2. Get detail
    r = s.post(f"{PORTAL}/customer/getdata", data={'draw':'1','start':'0','length':'5','search[value]': cust['name']}, verify=False, timeout=10)
    detail = next((row for row in r.json().get('data',[]) if row['name'] == cust['name']), None)
    if not detail: return {"success": False, "error": "Gagal ambil detail"}

    coverage = str(detail.get('coverage','1'))
    amount_raw = str(detail.get('amount','165000'))
    # Clean: ambil digit aja, handle "159,000" / "159000.00" / "159.000"
    # Split by . terakhir untuk hilangkan desimal, lalu ambil digit
    amount = re.sub(r'[^\d]', '', amount_raw.split('.')[0])
    if not amount: amount = '165000'
    cid = detail.get('id')
    rid, router_name, area_name = get_router(cfg, coverage)
    profile = PROFILES.get(amount, 'PAKET HEMAT')
    if amount not in PROFILES:
        log(f"WARNING: amount '{amount_raw}' (cleaned={amount}) tidak ada di PROFILES, fallback PAKET HEMAT")
    clean_no = generate_no()
    nama_depan = cust['name'].strip().upper().split()[0]
    username = f"{clean_no}-{nama_depan}"
    log(f"Gen: {clean_no} | {cfg['label']} | {area_name} → {router_name} | {profile} | {username}")

    # 3. Create PPPoE on MikroTik via portal
    pppoe_synced = False
    try:
        r = s.post(f"{PORTAL}/mikrotik/createuser",
                   data={'router':str(rid),'mode':'PPPOE','username':username,
                         'password':username,'profile':profile,'customer_id':str(cid)},
                   verify=False, timeout=30)
        if 'success' in r.text and 'error' not in r.text.lower():
            pppoe_synced = True; log("PPPoE synced to MikroTik ✅")
        else: log(f"PPPoE: {r.text[:120]}")
    except Exception as e: log(f"PPPoE error: {e}")

    # 4. Get edit form (CSRF)
    r = s.get(f"{PORTAL}/customer/edit/{cid}", verify=False, timeout=10)
    hiddens = dict(re.findall(r'<input[^>]*type="hidden"[^>]*name="([^"]+)"[^>]*value="([^"]*)"', r.text))

    # 5. Update customer
    email_domain = cfg.get("email_domain", "tekra.id")
    form = {
        **hiddens,
        'id': str(cid), 'customer_id': str(cid),
        'name': cust['name'], 'no_services': clean_no,
        'no_wa': detail.get('phone','6281234567890'),
        'email': detail.get('email', f"{cust['name'].lower().replace(' ','')}@{email_domain}"),
        'phonecode': str(detail.get('phonecode','62')),
        'no_ktp': detail.get('no_id_card','1234567890123456'),
        'address': detail.get('address',''),
        'coverage': coverage,
        'status': 'Aktif', 'ganti_koneksi': '1',
        'mode_user': 'PPPOE', 'router': str(rid),
        'user_mikrotik': username, 'profile': profile, 'user_profile': profile,
        'register_date': today, 'mediaconnection': today,
        'due_date': due_day,
        'type_payment': '0', 'ppn': '0', 'auto_isolir': '1', 'send_bill': '0',
        'month_due_date': '0', 'dynamic_due_date': '0', 'codeunique': '0',
        'type_id': detail.get('id_card','KTP'), 'connection': '0', 'create_by': cfg.get('create_by','1051'),
    }
    r = s.post(f"{PORTAL}/customer/edit/{cid}", data=form, verify=False, timeout=10, allow_redirects=True)

    # 6. Verify
    r = s.post(f"{PORTAL}/customer/getdata", data={'draw':'1','start':'0','length':'5','search[value]': cust['name']}, verify=False, timeout=10)
    final = next((row for row in r.json().get('data',[]) if row['name'] == cust['name']), {})
    ok = final.get('status') == 'Aktif' and 'R-' not in final.get('no_services','R-')
    log(f"Status: {final.get('status')} | No: {final.get('no_services')} | {'✅' if ok else 'REVIEW'}")

    return {
        "success": ok, "nama": cust['name'], "no_services": clean_no,
        "pppoe_username": username, "pppoe_password": username,
        "pppoe_synced": pppoe_synced, "profile": profile,
        "router": router_name, "area": area_name, "portal": cfg["label"],
    }

def report(r):
    if not r.get('success'): return f"❌ AKTIVASI GAGAL — {r.get('error','')}"
    sync = "✅" if r.get('pppoe_synced') else "⚠️ Perlu sync manual"
    return (f"🤖 AUTO AKTIVASI [{r.get('portal','?')}]\n"
            f"📋 {r['nama']}\n"
            f"📍 {r.get('area','?')} → {r.get('router','?')}\n"
            f"🔢 {r['no_services']}\n"
            f"🔌 PPPoE: {r['pppoe_username']} {sync}\n"
            f"🔑 Pass: {r['pppoe_password']}")

def process_all(portal_key):
    """Scan and activate all Menunggu customers in a portal. Returns list of reports."""
    cfg = PORTALS[portal_key]
    processed = load_processed(portal_key)
    waiting = scan_menunggu(cfg)

    if not waiting:
        log(f"[{cfg['label']}] Tidak ada pelanggan Menunggu")
        return []

    log(f"[{cfg['label']}] Ditemukan {len(waiting)} pelanggan Menunggu")

    new_custs = [c for c in waiting if str(c['id']) not in processed]
    if not new_custs:
        log(f"[{cfg['label']}] Semua {len(waiting)} sudah diproses sebelumnya")
        return []

    log(f"[{cfg['label']}] Memproses {len(new_custs)} pelanggan baru...")

    s = requests.Session()
    r = s.post(f"{cfg['url']}/auth", data=AUTH, verify=False, timeout=15)
    if r.status_code != 200:
        log(f"[{cfg['label']}] Login gagal")
        return []
    log(f"[{cfg['label']}] Login OK (shared)")

    reports = []
    for c in new_custs:
        log(f"\n--- {c['name']} (ID={c['id']}) ---")
        result = activate(c['name'], cfg, session=s)
        mark_processed(portal_key, str(c['id']))
        reports.append(report(result))

    return reports

def process_all_portals():
    """Check all portals, return combined report lines."""
    all_results = []
    total_new = 0
    for key in ["pusat", "dago", "katapang"]:
        results = process_all(key)
        if results:
            all_results.extend(results)
            total_new += len(results)
    
    now = datetime.now().strftime("%H:%M")
    if all_results:
        # Ada aktivasi — tampilkan semua report
        out = []
        for r in all_results:
            out.append(r)
        return out
    else:
        # Gak ada — kasih status singkat
        return [f"👀 Cek {now} — blm ada self-register baru (pusat/dago/katapang)"]

if __name__ == "__main__":
    p = argparse.ArgumentParser()
    p.add_argument("--nama")
    p.add_argument("--raw")
    p.add_argument("--all", action="store_true")
    p.add_argument("--all-portals", action="store_true")
    p.add_argument("--portal", default="pusat", choices=["pusat","dago","katapang"])
    a = p.parse_args()

    if a.all_portals:
        results = process_all_portals()
        for r in results:
            print(r)
            print()
    elif a.all:
        cfg = PORTALS[a.portal]
        results = process_all(a.portal)
        if results:
            for r in results:
                print(r)
                print()
        else:
            log("Done — tidak ada aktivasi baru")
    elif a.nama or a.raw:
        cfg = PORTALS[a.portal]
        nama = a.nama or parse_name(a.raw)
        if not nama: print("Usage: --nama <NAMA>"); sys.exit(1)
        print(report(activate(nama, cfg)))
    else:
        print("Usage: --nama <NAMA> | --raw <TEXT> | --all --portal <PORTAL> | --all-portals")
        sys.exit(1)
