#!/usr/bin/env python3
"""
Tekra ISP - Automated Backup Script
Backup: MikroTik configs, pfSense configs, Portal databases, OLT configs, OpenClaw workspace
Destination: GitHub repo + Telegram notification
Schedule: daily 02:00 via crontab
"""

import os
import subprocess
import datetime
import requests
import paramiko
import telnetlib
import json
import shutil
import gzip
import glob
from pathlib import Path

# ─────────────────────────────────────────────
# CONFIG
# ─────────────────────────────────────────────
BASE_DIR = Path("/opt/tekra-backup")
DATA_DIR = BASE_DIR / "data"
LOG_FILE = BASE_DIR / "backup.log"

# Load from config file
cfg_path = BASE_DIR / "config.json"
with open(cfg_path) as f:
    CFG = json.load(f)

TELEGRAM_TOKEN = CFG["telegram_token"]
TELEGRAM_CHAT_ID = CFG["telegram_chat_id"]
GIT_REPO = "git@github.com:yofino/Tekra-backup.git"

TODAY = datetime.date.today().isoformat()

MIKROTIK_DEVICES = [
    {"name": "CCR1-Hotspot", "ip": "10.10.10.1",    "port": 18, "user": "asep", "pass": "asep$888"},
    {"name": "PUSAT-X86",    "ip": "172.80.10.100",  "port": 18, "user": "asep", "pass": "asep$888"},
    {"name": "CILISUNG-GX4", "ip": "10.7.0.8",      "port": 18, "user": "asep", "pass": "asep$888"},
    {"name": "KATAPANG",     "ip": "10.7.0.9",      "port": 18, "user": "asep", "pass": "asep$888"},
]

PFSENSE_DEVICES = [
    {"name": "pfSense-Pusat", "url": "https://192.168.123.1",    "user": "admin", "pass": "k34Nu335577", "verify": False},
    {"name": "pfSense-Dago",  "url": "https://115.178.49.186:1042", "user": "admin", "pass": "k34Nu335577", "verify": False},
]

PORTALS = [
    {"name": "portal-pusat",   "host": "103.129.148.97", "db": "portal",  "user": "portal",  "pass": "portal",  "ssh_user": "keanuvps", "ssh_key": "/root/.openclaw/media/inbound/nocita---0ae44bb1-6a7b-441a-9f4a-17c556dbe83f.cer", "ssh_pass": "k34Nu335577"},
    {"name": "portal-dago",    "host": "103.129.148.97", "db": "utara",   "user": "utara",   "pass": "utara",   "ssh_user": "keanuvps", "ssh_key": "/root/.openclaw/media/inbound/nocita---0ae44bb1-6a7b-441a-9f4a-17c556dbe83f.cer", "ssh_pass": "k34Nu335577"},
    {"name": "portal-katapang","host": "103.129.148.97", "db": "selatan", "user": "selatan", "pass": "selatan", "ssh_user": "keanuvps", "ssh_key": "/root/.openclaw/media/inbound/nocita---0ae44bb1-6a7b-441a-9f4a-17c556dbe83f.cer", "ssh_pass": "k34Nu335577"},
]

AGENT_WORKSPACES = [
    {"name": "Anatasya", "host": "10.10.10.31", "ssh_user": "agent-ryan", "ssh_pass": "zeushera", "workspace": "/home/agent-ryan/.openclaw/workspace"},
    {"name": "Zara",     "host": "10.10.10.30", "ssh_user": "agent-bos",  "ssh_pass": "zeushera", "workspace": "/home/agent-bos/.openclaw/workspace"},
    {"name": "Siti",     "host": "103.129.148.97", "ssh_user": "keanuvps", "ssh_key": "/root/.openclaw/media/inbound/nocita---0ae44bb1-6a7b-441a-9f4a-17c556dbe83f.cer", "ssh_pass": "k34Nu335577", "workspace": "/opt/openclaw/data/workspace", "sudo": True},
]

# ─────────────────────────────────────────────
# HELPERS
# ─────────────────────────────────────────────
results = []

def log(msg):
    ts = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    line = f"[{ts}] {msg}"
    print(line)
    with open(LOG_FILE, "a") as f:
        f.write(line + "\n")

def ok(name):
    results.append(f"✅ {name}")
    log(f"OK: {name}")

def fail(name, err):
    results.append(f"❌ {name}: {str(err)[:80]}")
    log(f"FAIL: {name} — {err}")

def send_telegram(text, file_path=None):
    try:
        if file_path and os.path.exists(file_path):
            with open(file_path, "rb") as f:
                requests.post(
                    f"https://api.telegram.org/bot{TELEGRAM_TOKEN}/sendDocument",
                    data={"chat_id": TELEGRAM_CHAT_ID, "caption": text[:1024]},
                    files={"document": f},
                    timeout=30
                )
        else:
            requests.post(
                f"https://api.telegram.org/bot{TELEGRAM_TOKEN}/sendMessage",
                json={"chat_id": TELEGRAM_CHAT_ID, "text": text},
                timeout=15
            )
    except Exception as e:
        log(f"Telegram send failed: {e}")

# ─────────────────────────────────────────────
# BACKUP FUNCTIONS
# ─────────────────────────────────────────────

def backup_mikrotik():
    out_dir = DATA_DIR / "mikrotik"
    out_dir.mkdir(parents=True, exist_ok=True)
    for dev in MIKROTIK_DEVICES:
        name = dev["name"]
        try:
            ssh = paramiko.SSHClient()
            ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
            ssh.connect(dev["ip"], port=dev["port"], username=dev["user"],
                        password=dev["pass"], timeout=15, look_for_keys=False)
            _, stdout, _ = ssh.exec_command("/export terse", timeout=30)
            config = stdout.read().decode(errors="replace")
            ssh.close()
            if len(config) < 100:
                raise Exception(f"Output terlalu pendek ({len(config)} chars)")
            out_file = out_dir / f"{name}.rsc"
            out_file.write_text(config)
            ok(f"MikroTik {name}")
        except Exception as e:
            fail(f"MikroTik {name}", e)


def backup_pfsense():
    import re
    out_dir = DATA_DIR / "pfsense"
    out_dir.mkdir(parents=True, exist_ok=True)
    for dev in PFSENSE_DEVICES:
        name = dev["name"]
        try:
            s = requests.Session()
            s.verify = dev["verify"]
            r = s.get(dev["url"] + "/", timeout=20)
            tok = re.search(r'name=[\'"]__csrf_magic[\'"] value="([^"]+)"', r.text)
            if not tok:
                raise Exception("CSRF token not found")
            s.post(dev["url"] + "/", data={
                "__csrf_magic": tok.group(1),
                "usernamefld": dev["user"],
                "passwordfld": dev["pass"],
                "login": "Sign In"
            }, headers={"Referer": dev["url"] + "/"}, timeout=20)
            # Download config backup
            r2 = s.get(dev["url"] + "/diag_backup.php", timeout=20)
            tok2 = re.search(r'name=[\'"]__csrf_magic[\'"] value="([^"]+)"', r2.text)
            r3 = s.post(dev["url"] + "/diag_backup.php", data={
                "__csrf_magic": tok2.group(1) if tok2 else "",
                "backuparea": "",
                "donotbackuprrd": "on",
                "nopackages": "on",
                "download": "Download configuration as XML"
            }, headers={"Referer": dev["url"] + "/diag_backup.php"}, timeout=30)
            if r3.text.strip().startswith("<?xml") or "<pfsense" in r3.text[:500]:
                out_file = out_dir / f"{name}.xml"
                out_file.write_text(r3.text)
                ok(f"pfSense {name}")
            else:
                raise Exception(f"Response bukan XML config ({r3.status_code}, {len(r3.text)} chars)")
        except Exception as e:
            fail(f"pfSense {name}", e)


def backup_databases():
    out_dir = DATA_DIR / "databases"
    out_dir.mkdir(parents=True, exist_ok=True)
    for portal in PORTALS:
        name = portal["name"]
        try:
            ssh = paramiko.SSHClient()
            ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
            # Try key first, fallback to password
            try:
                ssh.connect(portal["host"], username=portal["ssh_user"],
                            key_filename=portal["ssh_key"], timeout=20)
            except Exception:
                ssh.connect(portal["host"], username=portal["ssh_user"],
                            password=portal["ssh_pass"], timeout=20)
            cmd = f"mysqldump -h127.0.0.1 -u{portal['user']} -p{portal['pass']} {portal['db']} 2>/dev/null"
            _, stdout, stderr = ssh.exec_command(cmd, timeout=120)
            dump = stdout.read()
            err = stderr.read().decode(errors='replace')
            ssh.close()
            if len(dump) < 500:
                raise Exception(f"Dump terlalu kecil ({len(dump)} bytes). Err: {err[:100]}")
            out_file = out_dir / f"{name}-{TODAY}.sql.gz"
            with gzip.open(out_file, "wb") as gz:
                gz.write(dump)
            ok(f"Database {name} ({len(dump)//1024}KB)")
            # Kirim ke Telegram
            send_telegram(f"📦 Backup DB {name} {TODAY}", str(out_file))
        except Exception as e:
            fail(f"Database {name}", e)


def backup_olt_epon():
    out_dir = DATA_DIR / "olt"
    out_dir.mkdir(parents=True, exist_ok=True)
    try:
        tn = telnetlib.Telnet("10.10.10.203", 23, timeout=15)
        tn.read_until(b"login:", timeout=10)
        tn.write(b"root\n")
        tn.read_until(b"Password:", timeout=5)
        tn.write(b"admin\n")
        tn.read_until(b"#", timeout=10)
        tn.write(b"show running-config\n")
        import time; time.sleep(5)
        config = tn.read_very_eager().decode(errors="replace")
        tn.write(b"exit\n")
        tn.close()
        out_file = out_dir / f"OLT-EPON-{TODAY}.txt"
        out_file.write_text(config)
        ok("OLT EPON")
    except Exception as e:
        fail("OLT EPON", e)


def backup_workspace():
    out_dir = DATA_DIR / "workspace"
    out_dir.mkdir(parents=True, exist_ok=True)
    try:
        src = "/root/.openclaw/workspace"
        archive = out_dir / f"workspace-{TODAY}.tar.gz"
        subprocess.run(
            ["tar", "czf", str(archive), "--exclude=*.pyc", "--exclude=__pycache__",
             "--exclude=finance/*.db", "-C", "/root/.openclaw", "workspace"],
            check=True, timeout=60
        )
        ok(f"OpenClaw workspace ({archive.stat().st_size//1024}KB)")
    except Exception as e:
        fail("OpenClaw workspace", e)


def backup_workspace_remote():
    out_dir = DATA_DIR / "workspace-agents"
    out_dir.mkdir(parents=True, exist_ok=True)
    for agent in AGENT_WORKSPACES:
        name = agent["name"]
        try:
            ssh = paramiko.SSHClient()
            ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
            # Try key, fallback to password
            try:
                connect_args = {"hostname": agent["host"], "username": agent["ssh_user"], "timeout": 20}
                if "ssh_key" in agent and os.path.exists(agent["ssh_key"]):
                    connect_args["key_filename"] = agent["ssh_key"]
                else:
                    connect_args["password"] = agent["ssh_pass"]
                ssh.connect(**connect_args)
            except Exception:
                ssh.connect(agent["host"], username=agent["ssh_user"],
                            password=agent["ssh_pass"], timeout=20)
            # Archive workspace remotely and download
            archive_name = f"workspace-{name}-{TODAY}.tar.gz"
            remote_tmp = f"/tmp/{archive_name}"
            ws_path = agent["workspace"]
            sudo_prefix = "sudo " if agent.get("sudo") else ""
            # Verify workspace exists before tar
            stdin, stdout, stderr = ssh.exec_command(f"{sudo_prefix}test -d {ws_path} && echo EXISTS || echo MISSING", timeout=10)
            check = stdout.read().decode().strip()
            if check != "EXISTS":
                raise Exception(f"Workspace path not found: {ws_path}")
            cmd = f"{sudo_prefix}tar czf {remote_tmp} --exclude='*.pyc' --exclude='__pycache__' -C $(dirname {ws_path}) $(basename {ws_path}) 2>/dev/null && {sudo_prefix}chown {agent['ssh_user']}:{agent['ssh_user']} {remote_tmp}"
            ssh.exec_command(cmd, timeout=60)
            import time; time.sleep(2)
            sftp = ssh.open_sftp()
            local_file = out_dir / archive_name
            sftp.get(remote_tmp, str(local_file))
            sftp.remove(remote_tmp)
            sftp.close()
            ssh.close()
            size_kb = local_file.stat().st_size // 1024
            ok(f"Workspace {name} ({size_kb}KB)")
        except Exception as e:
            fail(f"Workspace {name}", e)


def backup_zabbix_config():
    """Export Zabbix host config to JSON for disaster recovery"""
    out_dir = DATA_DIR / "zabbix"
    out_dir.mkdir(parents=True, exist_ok=True)
    try:
        import json, datetime
        r = requests.post("http://10.10.10.18/zabbix/api_jsonrpc.php", json={
            "jsonrpc":"2.0","method":"user.login",
            "params":{"username":"Admin","password":"zabbix"},"id":1
        }, timeout=10)
        auth = r.json()["result"]
        r = requests.post("http://10.10.10.18/zabbix/api_jsonrpc.php", json={
            "jsonrpc":"2.0","method":"host.get",
            "params":{"output":["hostid","host","name","status"],
                     "selectInterfaces":["ip","type","port"]},
            "auth":auth,"id":2
        }, timeout=10)
        hosts = r.json()["result"]
        export = {"exported_at": datetime.datetime.now().isoformat(), "hosts": [
            {"host":h["host"],"name":h["name"],"hostid":h["hostid"],
             "status":"enabled" if h["status"]=="0" else "disabled",
             "interfaces":h.get("interfaces",[])} for h in hosts
        ]}
        out_file = out_dir / f"zabbix-config-{TODAY}.json"
        out_file.write_text(json.dumps(export, indent=2))
        ok(f"Zabbix config ({len(hosts)} hosts)")
    except Exception as e:
        fail("Zabbix config", e)


def cleanup_old_backups(keep_days=7):
    """Hapus backup database > 7 hari"""
    cutoff = datetime.date.today() - datetime.timedelta(days=keep_days)
    for f in glob.glob(str(DATA_DIR / "databases" / "*.sql.gz")):
        try:
            date_str = Path(f).stem.replace(".sql", "").split("-")[-3:]
            file_date = datetime.date(*map(int, date_str))
            if file_date < cutoff:
                os.remove(f)
                log(f"Cleaned up old backup: {f}")
        except Exception:
            pass


def git_commit_push():
    try:
        env = os.environ.copy()
        env["GIT_SSH_COMMAND"] = "ssh -i /root/.ssh/tekra_backup_key -o StrictHostKeyChecking=no"
        subprocess.run(["git", "config", "user.email", "asep@tekra.id"], cwd=BASE_DIR, check=True)
        subprocess.run(["git", "config", "user.name", "Asep Backup"], cwd=BASE_DIR, check=True)
        subprocess.run(["git", "add", "-A"], cwd=BASE_DIR, check=True)
        status = subprocess.run(["git", "status", "--porcelain"], cwd=BASE_DIR, capture_output=True, text=True)
        if not status.stdout.strip():
            log("Git: tidak ada perubahan, skip commit")
            return
        subprocess.run(["git", "commit", "-m", f"backup: {TODAY}"], cwd=BASE_DIR, check=True)
        subprocess.run(["git", "push", "-u", "origin", "main"], cwd=BASE_DIR, check=True, env=env)
        ok("Git push ke GitHub")
    except Exception as e:
        fail("Git push", e)


# ─────────────────────────────────────────────
# MAIN
# ─────────────────────────────────────────────
if __name__ == "__main__":
    log("=" * 50)
    log(f"TEKRA BACKUP START — {TODAY}")
    log("=" * 50)

    DATA_DIR.mkdir(parents=True, exist_ok=True)

    backup_mikrotik()
    backup_databases()
    backup_workspace()
    backup_workspace_remote()
    cleanup_old_backups()
    git_commit_push()

    # Summary ke Telegram
    total = len(results)
    success = sum(1 for r in results if r.startswith("✅"))
    failed = total - success
    summary = f"""🗄️ *Tekra Backup — {TODAY}*

{chr(10).join(results)}

Total: {success}/{total} berhasil{"" if failed == 0 else f" | {failed} gagal"}"""
    send_telegram(summary)

    log("BACKUP DONE")
    log("=" * 50)
