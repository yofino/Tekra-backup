# TOOLS.md - Local Notes

## ⚠️ Prioritas Mention di Group

**Di-mention = wajib bales. Di atas segalanya.**

- Begitu ada mention `@Asep` di group → **hentikan apapun**, bales dulu
- Gak usah nunggu hasil final — "oi bentar cek" udah cukup
- Baru lanjut kerjain + bales hasil
- Diem doang = pelanggaran SOP
- Persona HARUS sama kayak japri: santai, natural, bukan robot
- Kata-kata terlarang di group: "nampaknya", "sepertinya", "berdasarkan", "menurut saya"
- Ganti dengan: "oi", "bentar", "cek dulu", "done", "aman", "gagal nih"

---

## Tim Teknologi Rakyat

| Nama | Jabatan | No WA |
|---|---|---|
| Ayi Rohman | Teknisi | +6281220082221 |
| Riki Ramdani | Teknisi | +6281646835425 |
| Epul | Teknisi | +6283838762881 |
| Resti | Admin | +62895610382802 |
| Ahkam | PIC Katapang | +6287722867602 |
| Jay | PIC Dago | +6281320385966 |

---

## SOP Pelanggan Baru (Full Flow)

Kalau ada laporan pemasangan dari team:
1. **Input data pelanggan** di portal (nama, alamat, paket) — no layanan **tanpa prefix R-**
2. **Buat PPPoE** di router sesuai area (lihat Routing Area di bawah)
3. **Aktifkan status** pelanggan di portal — pastikan no layanan sudah tanpa R-
4. **Cek ACS** → notif ke group: SN ONT, RX Power, device aktif, IP PPPoE, PPPoE uptime

**Format Username PPPoE:** `NOMORLAYANAN-NAMA` — ambil dari no layanan pelanggan (contoh: `R-20260515155812`) tapi **buang prefix "R-"**, jadi `20260515155812-NAMA`
- ✅ Contoh benar: `20260515155812-SRI` (no layanan `R-20260515155812` tanpa R-)
- ❌ Contoh salah: `11200004-SRI` (jangan pakai kode coverage!)
- Password = username
- NAMA = nama depan pelanggan (huruf kapital, tanpa spasi)

**Jangan tunggu diminta** — kalau teknisi bilang "sudah beres/konek/jalan", langsung cek ACS otomatis.

### Auto Aktivasi via Mention (NEW — 15 Mei 2026)
Trigger: `@Asep aktifasi NAMA` di group WA.

**WAJIB pakai script `workspace/auto_aktivasi.py`** — jangan manual SSH/DB.

**Command:**
```
python3 workspace/auto_aktivasi.py --nama "NAMA" --portal pusat
```
(dari working directory /root/.openclaw/workspace)

**Syarat:** Nama sudah ada di portal status Menunggu (self-register).

Script handle semua: cari customer → generate no → PPPoE via portal API → update status → report.

**Format balasan:**
```
✅ AKTIVASI BERHASIL
📋 [NAMA]
🔢 [NO_LAYANAN]
📍 [ROUTER]
🔌 PPPoE: [NO_LAYANAN]-[NAMA]
🔑 Pass: [NO_LAYANAN]-[NAMA]
```

**Batch semua Menunggu:** `python3 workspace/auto_aktivasi.py --all --portal pusat`

### Routing Area → Router MikroTik
| Area | Router |
|---|---|
| Cilisung, Sekeawi, Citamiang, Batuwangi | CILISUNG GX4 (ID 3, 10.7.0.8) |
| Area lain | PUSAT X86 (ID 2) atau CCR (ID 1) |
| Katapang | KATAPANG (10.7.0.9) |

> Jangan pakai PUSAT X86 untuk area Cilisung/Citamiang/Sekeawi (info Yofi, 1 Apr 2026). GR3 sudah tidak dipakai.

### IP Router Update (14 Mei 2026)
| Router | IP Lama | IP Baru |
|---|---|---|
| Cilisung GX4 | 10.6.0.5 | **10.7.0.8** |
| Katapang | 10.6.0.4 | **10.7.0.9** |
| Dago | 10.6.0.2 | (tetap) |

### Mapping Paket → Profil MikroTik (Cilisung)
| Harga | Profil | Speed |
|---|---|---|
| 119.000 | PAKET HEMAT | 10M/10M |
| 165.000 | PAKET1 | 10M/10M |

### Rule Paket Katapang
- Untuk paket pelanggan baru di **Katapang**, **samakan rule/profil dengan Pusat** kalau tidak ada instruksi lain.
- Jadi kalau teknisi bilang paket Katapang dan tidak ada mapping khusus, pakai acuan paket/rule yang sama seperti **Pusat**.

### SOP Operasional di Group WA Teknologi Rakyat
- Kalau teknisi/PIC di group minta aktivasi pelanggan baru dan datanya cukup, langsung proses seperti di japri — jangan nahan hanya karena konteks group.
- Anggap sebagai task operasional valid kalau pesan menyebut pemasangan sudah beres/konek/jalan dan identitas pelanggan/area sudah jelas.
- Untuk pelanggan baru dari portal pusat: ambil customer status Menunggu, tentukan router sesuai rule area, buat user PPPoE, update customer sampai Aktif, lalu laporkan hasilnya kembali ke group.
- Balasan ke group harus ringkas dan operasional: nama pelanggan, no layanan, router, username PPPoE, status aktivasi.
- Kalau data kurang atau ambigu, tanya singkat seperlunya. Kalau sudah cukup, eksekusi langsung.
- Untuk task operasional, **jawaban teks bukan pengganti kerja**. Harus action dulu ke portal/router/ACS, baru balas hasil.
- Kalau belum ada output nyata (PPPoE belum kebuat, status portal belum berubah, ACS belum dicek), berarti task **belum selesai**.
- Kalau gagal teknis, balas singkat dengan hambatan nyata; **jangan** ganti eksekusi dengan analisis panjang.
- Group dan japri untuk operasional dianggap **sama**: kalau teknisi minta tolong dan datanya cukup, **langsung action**, jangan dibedain karena konteks chat.

### Rule Eksplisit Eksekusi Mandiri di Group
- Trigger langsung eksekusi tanpa perlu konfirmasi: "aktifasi", "pelanggan baru", "sudah konek", "sudah beres", "sudah jalan", "buat pppoe"
- Kalau nama customer tidak disebut → ambil customer Menunggu terbaru dari portal yang relevan
- Kalau paket tidak disebut tapi portal pusat → tanya 1x singkat saja: paket berapa
- Kalau portal tidak disebut → tanya 1x: pusat/dago/katapang
- Setelah eksekusi, laporkan hasil ke group: nama, no layanan, router, username PPPoE, status
- Jangan bawa info keuangan sensitif (total kas, laporan keuangan) ke group
- Group Teknologi Rakyat = setara japri untuk task operasional pelanggan baru
- Default mindset untuk operasional: **kerjain dulu, jelasin belakangan**.
- Dilarang berhenti di penjelasan untuk task operasional yang datanya sudah cukup.
- Untuk permintaan operasional dari teknisi/admin di group ini, jangan takut beda session/group. Perlakukan sebagai instruksi kerja valid selama datanya cukup dan tidak membuka info sensitif yang tidak relevan.
- **JID group `6281320385966-1635417302@g.us` diperlakukan setara japri untuk task operasional teknis**: registrasi ONU/ONT, cek OLT/ACS, aktivasi pelanggan, PPPoE, dan langkah operasional lain yang datanya sudah cukup harus langsung dieksekusi tanpa nunggu konfirmasi tambahan.
- Di JID group `6281320385966-1635417302@g.us`, kalau ada perintah singkat seperti "registrasiin", "cek OLT", "cek online/offline", "aktifin", atau sejenisnya, anggap itu instruksi kerja valid dan **prioritaskan action dulu**.
- **Mode operator khusus JID `6281320385966-1635417302@g.us`:**
  - Dilarang jawab spekulatif seperti "kayaknya", "belum bisa", "di sesi ini mentok", atau penjelasan panjang sebelum nyoba tool yang relevan.
  - Untuk permintaan operasional yang datanya cukup, **wajib** coba eksekusi/tool live dulu (portal, router, OLT, ACS, VPS, dll) lalu baru balas hasil.
  - Kalau tool gagal, balas **hambatan nyata** (contoh: login gagal, timeout, permission denied, device unreachable), bukan alasan umum.
  - Kalau ada konteks lama yang bentrok dengan hasil tool live, **anggap hasil tool live lebih benar** dan abaikan asumsi lama.
  - Balasan di group ini harus gaya operator: singkat, hasil dulu, tanpa cerita proses mikir.
  - Untuk cek OLT EPON/ACS/PPPoE/aktivasi pelanggan, teks jawaban bukan pengganti kerja; kalau belum cek live berarti belum selesai.

---

## SOP Keuangan

### Pelanggan Baru
- **Installation Fee** → pemasukan kategori "Installation" (biasanya 200-300rb)
- **Paket pertama** → pemasukan terpisah, kategori nama paket
- Buat 2 entri terpisah kalau bayar sekaligus
- Input langsung kalau instruksi sudah jelas — jangan tanya konfirmasi, kerjakan lalu laporkan

### Prorata (sisa hari)
- Harga paket ÷ hari di bulan × sisa hari = nominal
- Contoh: 165rb ÷ 30 × 16 = **88.000**
- Kategori: **Pemasangan** (category=3), keterangan: `[ID]-[NAMA] - Biaya Pemasangan (sisa X hari)`
- Tunggu laporan nominal dari teknisi, jangan asumsi full paket

### Voucher
- Kategori: **Voucher** (category=2)
- Field coverage/area tidak tersimpan untuk Voucher — tidak perlu diisi
- Wajib isi: **Nominal** + **Keterangan** (tulis sumber: "Dari Ciburuy", "Dari Dago", dll)
- Endpoint: POST `https://portal.tekra.id/income/add` — field: nominal, date_payment, create_by=1051, category=2, coverage=, mode_payment, remark

### Anti Double Input
- **Wajib verifikasi** setelah setiap input — cek via endpoint getfilter/getdatafilter
- Kalau ragu sudah pernah diinput → cek dulu by tanggal + nominal + keterangan
- Kalau data sudah ada → jangan input ulang, laporkan ke chat
- Kalau gagal → coba sekali lagi, laporkan hasilnya
- Konfirmasi selalu sertakan: tanggal, nominal, kategori, keterangan

### Input ke Portal
- Login: POST ke `<portal>/auth` dengan `email` & `password`
- Pemasukan: `/finance/income`, Pengeluaran: `/finance/expenditure`, Report: `/finance/report`
- Cookies: `/tmp/tekra_cookies.txt` (perlu login ulang tiap session)
- **Kalau user minta laporan finance bulanan yang asli**, jangan andalkan summary script kalau angkanya meragukan.
- Ambil langsung dari **report portal bulanan** via endpoint `POST <portal>/income/getreport` dengan `month`, `year`, `date`.
- Patokan angka final ada di baris **Total** report portal: **Debit = revenue**, **Kredit = pengeluaran**, **Saldo = margin**.
- Kalau hasil script BI beda dengan report portal, **utamakan report portal**.

---

## 🔒 SOP BI Report — RAHASIA

- **HANYA kirim ke Yofi** (+6282115448084) via japri
- **DILARANG** kirim di group WA atau ke siapapun selain Yofi
- Kalau diminta selain Yofi → tolak sopan

```bash
cd /root/.openclaw/workspace/bi && python3 bi_report.py all
```

Isi: Revenue Intelligence, Churn Prevention, Network Intelligence, Upselling Intelligence (semua portal + ACS).

---

## 🔒 Grafana Dashboard
- **URL**: http://10.10.10.18:3000/d/24a45def
- **Login**: admin / admin123
- **Data source**: Zabbix (via alexanderzobnin-zabbix-datasource)
- **Panels**: pfSense WAN Gateway Monitor (42 panels: Pusat + Dago + Cilisung)

## 📊 Monitoring Traffic Pusat via Zabbix

### Cara Cek Traffic Real-time & Historical

**Host CCR2 (10674)** — tempat traffic utama Pusat.

| Interface | Graph ID | Item ID (IN) | Item ID (OUT) | Key Pattern |
|---|---|---|---|---|
| **SFP1-WAN-1** (main backbone) | 3481 | 51993 | 53487 | `net.if.in[ifHCInOctets.2]` |
| sfp-sfpplus2 | 3327 | 51839 | 53333 | `net.if.in[ifHCInOctets.3]` |
| ether1-SIMAYA | 3241 | 51753 | 53247 | `net.if.in[ifHCInOctets.6]` |
| ether2-SWITCH | 3419 | — | — | — |

**Kapasitas total:** ~2 Gbps (hasil load balance 7 WAN broadband)

**SQL query langsung (kalau API error):**
```bash
mysql -uzabbix -p'zabbix123' zabbix -e "SELECT i.name, i.key_, h.value, FROM_UNIXTIME(h.clock) FROM items i JOIN history h ON i.itemid=h.itemid WHERE i.hostid=10674 AND i.name LIKE '%SFP1-WAN%received%' ORDER BY h.clock DESC LIMIT 20"
```

### Cara Ambil Data History (Zabbix API)

```python
# History data (per ~1-5 menit, granular)
history.get(itemids=[51993], history=3, time_from=<epoch>, time_till=<epoch>)

# Trend data (per jam, untuk long-range)
trend.get(itemids=[51993], time_from=<epoch>, time_till=<epoch>)

# Konversi jam: UTC ke WIB = +7 jam. 20:00 WIB = 13:00 UTC
# Contoh: 20:00-22:00 WIB → time_from=13:00 UTC, time_till=15:00 UTC
# Timestamp epoch: date -d "2026-05-14 13:00:00 UTC" +%s
```

**Nilai history/tanpa unit** — value_type=3 (numeric unsigned), jadi value langsung bps. Bagi 1.000.000 untuk Mbps.

### Cara Nemu Item yang Tersembunyi
1. `graph.get` dulu → cari graph dengan nama interface
2. `graphitem.get` → ambil itemid dari graph
3. `item.get` pakai itemid spesifik (ini lebih reliable daripada search by key_)

### Pelajaran Kesalahan Sebelumnya
- ❌ Search `{"key_": "net.if"}` gak selalu nemu — Zabbix API search kadang inconsistent
- ❌ Trend data rata-rata per jam — bukan peak, pake `history.get` buat granular
- ❌ Timestamp UTC keliru dibaca WIB — 13:00 UTC = 20:00 WIB, bukan jam 1 siang
- ❌ Cuma cek satu interface — SFP1-WAN-1 backbone, sfp-sfpplus2 internal

## 📡 pfSense Gateway Monitoring (Zabbix)
Semua pfSense dimonitor via script `/opt/scripts/pf_gateway.sh` di Zabbix server.

| pfSense | IP Internal | SNMP | HTTPS | WAN Count |
|---|---|---|---|---|
| Pusat | 192.168.123.1 | :161 | :443 | 7 (WAN1-WAN7GW) |
| Dago | via 115.178.49.186 | :1043/UDP | :1042 | 4 (WAN1-WAN4) |
| Cilisung | 192.168.124.1 | :161 | :443 | 2 (WAN1-WAN2) |

### DNS Cache MikroTik (updated 14 Mei 2026)
| Setting | Old | New |
|---|---|---|
| cache-max-ttl | 1w | **1d** |
| cache-size | 2048KB | **4096KB** |

Berlaku di: PUSAT X86, CCR1, CILISUNG, KATAPANG, DAGO

## ACS / GenieACS (TR-069)

- **UI:** http://acs.tekra.id (atau lokal http://10.10.10.230:3000)
- **NBI API:** `http://10.10.10.230:7557/devices` (Basic auth: admin:admin)

```bash
# Cari device by PPPoE username
curl -sk -u "admin:admin" "http://10.10.10.230:7557/devices?query=%7B%22VirtualParameters.pppoeUsername._value%22%3A%22NOMORID-NAMA%22%7D&projection=DeviceID,VirtualParameters.RXPower,VirtualParameters.pppoeUsername,VirtualParameters.getSerialNumber,VirtualParameters.gettemp,VirtualParameters.activedevices,VirtualParameters.AddressWanPPP,VirtualParameters.getpppuptime"
```

**Parameter penting:** RXPower (dBm), pppoeUsername, getSerialNumber, gettemp (°C, warning >60), getpppuptime, AddressWanPPP, activedevices, SSID, PreSharedKey

**Range RX Power:** >-20 terlalu kuat | -20 s/d -26 bagus ✅ | -26 s/d -30 sedang ⚠️ | <-30 warning 🔴

---

## ERP / Billing System

- **Login:** asep@tekra.id / 12345
- **Pusat:** portal.tekra.id | **Dago:** north.my.id | **Katapang:** southnet.my.id

### SOP Input Pelanggan Baru via API

1. **Login:** `POST <portal>/auth` dg `email` & `password`, simpan cookie
2. **GET** `<portal>/customer/add` (ambil session)
3. **POST multipart** ke `<portal>/customer/store` dengan header:
   - `X-Requested-With: XMLHttpRequest`
   - `Accept: application/json`
4. Field minimal: `no_services`, `name`, `email`, `coverage`, `paket`, `type_payment`, `status`, `create_by`, `due_date`, `month_due_date`, `dynamic_due_date`, `auto_isolir`, `password`, `code_area`, `public`, `coverage_name`, `coverage_address`, `coverage_wa`, `register_date`, `address`, `vendor=WAblas`, `action=0`
5. Sukses → JSON `{"status":"success"}`, Gagal → `{"status":"error","message":"..."}`

**Catatan:** Pakai `-F` (multipart) bukan `-d` (urlencoded). GET form dulu sebelum POST biar session valid.

---

## MikroTik

SSH: port 18, user: asep, password: asep$888

| Nama | IP | Keterangan |
|---|---|---|
| CCR1 Hotspot | 10.10.10.1 | Khusus hotspot |
| CCR2 PPPoE | - | Host pusat untuk trafik PPPoE di Zabbix |
| x86 Pusat | 172.80.10.100 | PPPoE Pusat |
| GX4 Cilisung | 10.7.0.8 | Area Cilisung |
| Dago | 10.6.0.2 | SSH timeout perlu dicek |
| Katapang | 10.7.0.9 | Area Katapang |

**Catatan Zabbix Pusat:**
- **CCR2** = trafik/host **PPPoE Pusat**
- **CCR1** = trafik/host **Hotspot Pusat**

---

## pfSense

**Pusat:** https://192.168.123.1 | **Dago:** https://115.178.49.186:1042 | user: admin / k34Nu335577

- Read only! Jangan ubah setting tanpa izin Yofi
- Cookie: `/tmp/pfsense_cookies.txt` & `/tmp/pfsense_dago_cookies.txt`
- Login: POST ke `/index.php` (ambil CSRF token dulu), gateway widget: `/widgets/widgets/gateways.widget.php`
- Dago suhu ~64°C, perlu diperhatikan

**SOP WAN Dago Offline (NIC Hang):** Bounce interface via `diag_command.php`:
`ifconfig em3 down && sleep 3 && ifconfig em3 up` (ganti em3 sesuai WAN; jangan langsung reboot)

> Detail backbone & gateway subnets: `tools/ref-backbone.md`

---

## Zabbix Monitoring

- **URL:** http://10.10.10.18/zabbix | **API:** http://10.10.10.18/zabbix/api_jsonrpc.php
- **User:** Admin / zabbix | **Grafana:** http://10.10.10.18:3000
- Zabbix API jauh lebih hemat token dibanding SSH ke MikroTik
- Token expire per session, perlu login ulang tiap kali

> Detail host IDs & item IDs: `tools/ref-zabbix.md`

---

## OLT Pusat

- **EPON** (10.10.10.203): Telnet port 23, user root/admin — `show onu-info all`, 4 PON × 64 ONU = 256 max
- **GPON** (10.10.10.204): user admin / k34Nu335577

---

## Portal Tiket/Help (Gangguan)

- POST `https://<portal>/help/serverhelp` — params: `status=close&month=MM&year=YYYY&draw=1&start=0&length=50`
- Detail tiket (incl. teknisi): GET `https://<portal>/help/detail/<id>`
- Cara baca tiket terbaru closed: POST → ambil tiket no=1 → GET detail → format: no_ticket, name, description, teknisi

---

## VPS & Infrastruktur

### VPS Nocita (Mail Server)
- **IP:** 103.129.148.97 | SSH: `ssh -i ~/.ssh/nocita_key keanuvps@103.129.148.97` | key: `~/.ssh/nocita_key` & `workspace/nocita_key.pem`
- **aaPanel:** http://103.129.148.97:888 | **Webmail:** https://webmail.tekra.id
- Portal ERP/Billing juga hosted di VPS ini (web root: `/www/wwwroot/<portal>`)
- fail2ban & UFW aktif per Apr 20 2026

**AI Agent Siti (CS TekraNet)** 🌸
- Docker: `openclaw-gateway` (ghcr.io/openclaw/openclaw:2026.5.7)
- Port: 127.0.0.1:18789 (internal), WA: +6282121000835
- Model: deepseek-v4-pro (teks), Claude Sonnet 4 (gambar) — setup sama kayak Asep | Think: MAX
- Role: Customer Service — handle pelanggan (gangguan, tagihan, tiket)
- Report ke: Yofi + Neng Resti
- Workspace: `/home/node/.openclaw/workspace` (di-mount ke `/opt/openclaw/data`)
- **Koordinasi di group WA: WAJIB dua arah @mention.** Kalau Siti mention Asep, Asep wajib balas mention `@Siti`. Jangan cuma Siti yang mention duluan.
- **Balasan ke Siti HARUS mention balik `@Siti`** supaya Siti ke-trigger dan bisa lanjut konfirmasi ke pelanggan. Tanpa mention balik, Siti gak bakal tau Asep udah jawab.
- **Mention Siti pakai ID: `43997963808887`** (update 17 Mei 2026, perintah Yofi), bukan nomor WA 6282121000835.

**Akun Email tekra.id:**
| Email | Password |
|---|---|
| info@tekra.id | JTSFBDrmS8xGP1C1 |
| yofi@tekra.id | F15ufkwJNj6MoA60 |
| reqruitment@tekra.id | pRyd0EGqHIy0MuhI |
| ahkam@tekra.id | W8auSIZT6KdxjN6R |
| noreply@tekra.id | 2G6t0k9MAwXrKJyV |

### VPS TekraApp (BiznetCloud)
- **IP:** 103.197.191.8 | SSH: `ssh -i /tmp/vps_key.pem keanuapp@103.197.191.8`
- **aaPanel:** https://103.197.191.8:30521/d38ba3bd | user: hcvs51h5 / a8ccb834
- Stack: Nginx, MySQL 8.0, PHP 8.2, Node.js 18/20

### Proxmox VE
- **IP:** 10.10.10.4 | SSH: root / k34Nu335577 | Web: https://10.10.10.4:8006
- VM 118 (MONITORING, 4GB) | CT103 (LXC, 2GB)

### Proxmox Pak Jemmy & Pak Ryan (AI Agent)
- **Proxmox:** 10.10.10.29 | SSH: root / zeushera

**VM Pak Jemmy (Zara):**
- IP: 10.10.10.30 | SSH: agent-bos / zeushera
- Nama Agent: Zara

**VM Pak Ryan (Anatasya):**
- IP: 10.10.10.31 | SSH: agent-ryan / zeushera
- Nama Agent: Anatasya

---

## Absensi & Access Control
- **Hikvision DS-K1T320MFX** — IP: 10.10.10.207, admin / k34Nu335577
- API: HTTP Digest Auth → `http://10.10.10.207/ISAPI/...` | 16 karyawan terdaftar

## CCTV / NVR
- **Dahua DHI-NVR2116HS-I2** — IP: 10.10.10.10, admin / admin12345
- Login: POST `/RPC2_Login` (challenge-response MD5) | Snapshot masih 401 (perlu explore)

## Format Laporan pfSense di Group
Berlaku untuk **semua POP** (Pusat, Dago, Cilisung, Katapang). Kalau ada yg minta cek pfSense di group WA, format simpel:
```
📡 pfSense [POP] — [tanggal] [jam]

🟢 WAN1: Online | 0% loss | 4.1ms
🟢 WAN2: Online | 0% loss | 4.2ms
...
🔴 WAN3: Offline | 100% loss | 0ms

✅ 7/7 WAN aman
```
- Tanpa bandwidth, CPU, LAN, resource
- Hanya gateway status: online/offline, loss %, RTT
- Sumber data: Zabbix host 10084 items `pf.gateway[pop,WAN,status/loss/rtt]`
- POP yang tersedia: `pusat` (WAN1-WAN7GW), `dago` (WAN1-WAN4), `cilisung` (WAN1-WAN2 — sedang setup, cek Zabbix)

## Webchat → Group Session (WAJIB TEMBUS)
- **Setiap balasan di webchat HARUS dikirim juga ke session group WA** (session: `agent:main:whatsapp:group:6281320385966-1635417302@g.us`) via `sessions_send`
- Jangan cuma reply di webchat — group gak bakal nerima
- Di group harus **interaktif & gercep**, jangan slow respon
- Ini perintah Yofi (17 Mei 2026)
