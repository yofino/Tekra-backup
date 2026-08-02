# aug/03/2026 02:00:03 by RouterOS 6.49.13
# software id = DUUD-LHXS
#
# model = CCR1009-7G-1C-1S+
# serial number = E3200EA54D44
/interface ovpn-client add comment=tunnel-31730 connect-to=id-26.tunnel.web.id mac-address=FE:33:1F:62:88:CB name=tunnel-31730 password=tekra888 user=pusat-ccr1
/interface bridge add name="BRIDGE VLAN" vlan-filtering=yes
/interface bridge add name=FORM-CILISUNG
/interface bridge add name=MASTER
/interface ethernet set [ find default-name=combo1 ] name=SFP-COMBO
/interface ethernet set [ find default-name=ether1 ] name=ether1-SIMAYA
/interface ethernet set [ find default-name=ether2 ] auto-negotiation=no
/interface ethernet set [ find default-name=ether3 ] advertise=10M-full,100M-full,1000M-full,2500M-full
/interface ethernet set [ find default-name=ether4 ] name=ether4-TO-X86
/interface ethernet set [ find default-name=ether5 ] advertise=10M-full,100M-full,1000M-full,2500M-full name=ether5-pfsense
/interface ethernet set [ find default-name=sfp-sfpplus1 ] auto-negotiation=no name=sfp-HYPER speed=1Gbps
/interface pptp-client add connect-to=103.49.238.254 name=pptp-out1 password=tekra user=tekra
/interface vlan add interface=sfp-HYPER name=TO-CILISUNG vlan-id=202
/interface vlan add interface=ether3 name=VLAN-HOTSPOT-EPON vlan-id=144
/interface vlan add interface=ether7 name=VLAN-HOTSPOT-GPON vlan-id=145
/interface ethernet switch set 0 name=switch1
/interface wireless security-profiles set [ find default=yes ] supplicant-identity=MikroTik
/ip dhcp-server option add code=43 name=geineacs value=0x0116687474703A2F2F31302E31302E31302E3233303A37353437
/ip hotspot profile add dns-name=tekra.hotspot hotspot-address=10.10.10.1 html-directory=Tekra_Pay login-by=http-chap,http-pap,mac-cookie name=hsprof1
/ip hotspot user profile add name=KONTRAKAN rate-limit=4M/4M shared-users=2 transparent-proxy=yes
/ip hotspot user profile add name="paket 2rts" rate-limit=2M/2M shared-users=4 transparent-proxy=yes
/ip hotspot user profile add name=pipin rate-limit=1M/1M shared-users=2 transparent-proxy=yes
/ip hotspot user profile add name=TRIAL rate-limit=30M/30M shared-users=50
/ip hotspot user profile add name=ADIBIL rate-limit=50M/50M
/ip pool add name=hs-pool-27 ranges=10.5.50.50-10.5.50.254
/ip pool add name="HOTSPOT NEW" ranges=172.120.1.10-172.120.1.100
/ip pool add name=hs-pool-7 ranges=172.20.1.50-172.20.1.254
/ip pool add name=paket1 ranges=10.1.0.0/22
/ip pool add name=paket2 ranges=10.2.0.0/22
/ip pool add name=paket3 ranges=10.3.0.0/22
/ip pool add name=paket4 ranges=10.4.0.0/22
/ip pool add name=paket5 ranges=10.5.0.0/22
/ip pool add name=hs-pool-30 ranges=10.20.30.2-10.20.30.254
/ip pool add name="HOTSPOT TRIAL" ranges=10.6.0.0/22
/ip pool add name=dhcp_pool17 ranges=10.101.0.2-10.101.7.254
/ip pool add name=testong ranges=192.168.45.30-192.168.45.254
/ip pool add name=dhcp_pool19 ranges=192.168.78.2-192.168.78.254
/ip pool add name=dhcp_pool20 ranges=192.168.89.2-192.168.89.254
/ip pool add name=TUNNEL-CLIENTS ranges=10.7.0.2-10.7.0.20
/ip dhcp-server add address-pool=hs-pool-30 disabled=no lease-time=1h name=dhcp3
/ip dhcp-server add address-pool=dhcp_pool17 disabled=no name=dhcp4
/ip dhcp-server add address-pool=dhcp_pool19 disabled=no interface=ether5-pfsense name=dhcp2
/ip dhcp-server add address-pool=dhcp_pool20 disabled=no interface=ether2 name=dhcp5
/ip hotspot add address-pool=hs-pool-30 disabled=no name=hs-vlan1
/ip pool add name=Testing next-pool=testong ranges=192.168.44.20-192.168.44.254
/ip pool add name=Hotspot next-pool=Testing ranges=10.10.10.233-10.10.10.254
/ip dhcp-server add address-pool=Hotspot disabled=no interface=MASTER lease-time=1h name=dhcp1
/ip hotspot add address-pool=Hotspot addresses-per-mac=unlimited disabled=no interface=MASTER name=hs-MASTER profile=hsprof1
/ip hotspot user profile add address-pool=Hotspot name=Paket2jam on-login=":put (\",remc,1500,12h,2000,,Disable,\"); {:local date [ /system clock get date ];:local year [ :pick \$date 7 11 ];:local month [ :pick \$date 0 3 ];:local comment [ /ip hotspot user get [/ip hotspot user find where name=\"\$user\"] comment]; :local ucode [:pic \$comment 0 2]; :if (\$ucode = \"vc\" or \$ucode = \"up\" or \$comment = \"\") do={ /sys sch add name=\"\$user\" disable=no start-date=\$date interval=\"12h\"; :delay 2s; :local exp [ /sys sch get [ /sys sch find where name=\"\$user\" ] next-run]; :local getxp [len \$exp]; :if (\$getxp = 15) do={ :local d [:pic \$exp 0 6]; :local t [:pic \$exp 7 16]; :local s (\"/\"); :local exp (\"\$d\$s\$year \$t\"); /ip hotspot user set comment=\$exp [find where name=\"\$user\"];}; :if (\$getxp = 8) do={ /ip hotspot user set comment=\"\$date \$exp\" [find where name=\"\$user\"];}; :if (\$getxp > 15) do={ /ip hotspot user set comment=\$exp [find where name=\"\$user\"];}; /sys sch remove [find where name=\"\$user\"]; :local mac \$\"mac-address\"; :local time [/system clock get time ]; /system script add name=\"\$date-|-\$time-|-\$user-|-1500-|-\$address-|-\$mac-|-12h-|-Paket2jam-|-\$comment\" owner=\"\$month\$year\" source=\$date comment=mikhmon}}" parent-queue=none rate-limit=4M/4M session-timeout=2h transparent-proxy=yes
/ip hotspot user profile add address-pool=Hotspot name=Paket6jam on-login=":put (\",remc,2500,6h,3500,,Disable,\"); {:local date [ /system clock get date ];:local year [ :pick \$date 7 11 ];:local month [ :pick \$date 0 3 ];:local comment [ /ip hotspot user get [/ip hotspot user find where name=\"\$user\"] comment]; :local ucode [:pic \$comment 0 2]; :if (\$ucode = \"vc\" or \$ucode = \"up\" or \$comment = \"\") do={ /sys sch add name=\"\$user\" disable=no start-date=\$date interval=\"6h\"; :delay 2s; :local exp [ /sys sch get [ /sys sch find where name=\"\$user\" ] next-run]; :local getxp [len \$exp]; :if (\$getxp = 15) do={ :local d [:pic \$exp 0 6]; :local t [:pic \$exp 7 16]; :local s (\"/\"); :local exp (\"\$d\$s\$year \$t\"); /ip hotspot user set comment=\$exp [find where name=\"\$user\"];}; :if (\$getxp = 8) do={ /ip hotspot user set comment=\"\$date \$exp\" [find where name=\"\$user\"];}; :if (\$getxp > 15) do={ /ip hotspot user set comment=\$exp [find where name=\"\$user\"];}; /sys sch remove [find where name=\"\$user\"]; :local mac \$\"mac-address\"; :local time [/system clock get time ]; /system script add name=\"\$date-|-\$time-|-\$user-|-2500-|-\$address-|-\$mac-|-6h-|-Paket6jam-|-\$comment\" owner=\"\$month\$year\" source=\$date comment=mikhmon}}" parent-queue=none rate-limit=4M/4M session-timeout=6h transparent-proxy=yes
/ip hotspot user profile add address-pool=Hotspot name=gold on-login=":put (\",remc,4000,1h,5000,,Disable,\"); {:local date [ /system clock get date ];:local year [ :pick \$date 7 11 ];:local month [ :pick \$date 0 3 ];:local comment [ /ip hotspot user get [/ip hotspot user find where name=\"\$user\"] comment]; :local ucode [:pic \$comment 0 2]; :if (\$ucode = \"vc\" or \$ucode = \"up\" or \$comment = \"\") do={ /sys sch add name=\"\$user\" disable=no start-date=\$date interval=\"1h\"; :delay 2s; :local exp [ /sys sch get [ /sys sch find where name=\"\$user\" ] next-run]; :local getxp [len \$exp]; :if (\$getxp = 15) do={ :local d [:pic \$exp 0 6]; :local t [:pic \$exp 7 16]; :local s (\"/\"); :local exp (\"\$d\$s\$year \$t\"); /ip hotspot user set comment=\$exp [find where name=\"\$user\"];}; :if (\$getxp = 8) do={ /ip hotspot user set comment=\"\$date \$exp\" [find where name=\"\$user\"];}; :if (\$getxp > 15) do={ /ip hotspot user set comment=\$exp [find where name=\"\$user\"];}; /sys sch remove [find where name=\"\$user\"]; :local mac \$\"mac-address\"; :local time [/system clock get time ]; /system script add name=\"\$date-|-\$time-|-\$user-|-4000-|-\$address-|-\$mac-|-1h-|-gold-|-\$comment\" owner=\"\$month\$year\" source=\$date comment=mikhmon}}" parent-queue=none rate-limit=20M/20M transparent-proxy=yes
/ip hotspot user profile add address-pool=Hotspot name=lebaran rate-limit=8M/8M shared-users=50 transparent-proxy=yes
/ip hotspot user profile add address-pool=Hotspot name=Paket12jam on-login=":put (\",remc,5000,12h,6000,,Disable,\"); {:local date [ /system clock get date ];:local year [ :pick \$date 7 11 ];:local month [ :pick \$date 0 3 ];:local comment [ /ip hotspot user get [/ip hotspot user find where name=\"\$user\"] comment]; :local ucode [:pic \$comment 0 2]; :if (\$ucode = \"vc\" or \$ucode = \"up\" or \$comment = \"\") do={ /sys sch add name=\"\$user\" disable=no start-date=\$date interval=\"12h\"; :delay 2s; :local exp [ /sys sch get [ /sys sch find where name=\"\$user\" ] next-run]; :local getxp [len \$exp]; :if (\$getxp = 15) do={ :local d [:pic \$exp 0 6]; :local t [:pic \$exp 7 16]; :local s (\"/\"); :local exp (\"\$d\$s\$year \$t\"); /ip hotspot user set comment=\$exp [find where name=\"\$user\"];}; :if (\$getxp = 8) do={ /ip hotspot user set comment=\"\$date \$exp\" [find where name=\"\$user\"];}; :if (\$getxp > 15) do={ /ip hotspot user set comment=\$exp [find where name=\"\$user\"];}; /sys sch remove [find where name=\"\$user\"]; :local mac \$\"mac-address\"; :local time [/system clock get time ]; /system script add name=\"\$date-|-\$time-|-\$user-|-5000-|-\$address-|-\$mac-|-12h-|-Paket12jam-|-\$comment\" owner=\"\$month\$year\" source=\$date comment=mikhmon}}" parent-queue=none rate-limit=2M/2M session-timeout=12h transparent-proxy=yes
/ip hotspot user profile add address-pool=Hotspot name=istanajaya rate-limit=4M/4M shared-users=4 transparent-proxy=yes
/ip hotspot user profile add address-pool=Hotspot name=GRATIS rate-limit=20M/20M shared-users=30 transparent-proxy=yes
/ip hotspot user profile add address-pool=Hotspot name=bulanan on-login=":put (\",remc,55000,30d,60000,,Disable,\"); {:local date [ /system clock get date ];:local year [ :pick \$date 7 11 ];:local month [ :pick \$date 0 3 ];:local comment [ /ip hotspot user get [/ip hotspot user find where name=\"\$user\"] comment]; :local ucode [:pic \$comment 0 2]; :if (\$ucode = \"vc\" or \$ucode = \"up\" or \$comment = \"\") do={ /sys sch add name=\"\$user\" disable=no start-date=\$date interval=\"30d\"; :delay 2s; :local exp [ /sys sch get [ /sys sch find where name=\"\$user\" ] next-run]; :local getxp [len \$exp]; :if (\$getxp = 15) do={ :local d [:pic \$exp 0 6]; :local t [:pic \$exp 7 16]; :local s (\"/\"); :local exp (\"\$d\$s\$year \$t\"); /ip hotspot user set comment=\$exp [find where name=\"\$user\"];}; :if (\$getxp = 8) do={ /ip hotspot user set comment=\"\$date \$exp\" [find where name=\"\$user\"];}; :if (\$getxp > 15) do={ /ip hotspot user set comment=\$exp [find where name=\"\$user\"];}; /sys sch remove [find where name=\"\$user\"]; :local mac \$\"mac-address\"; :local time [/system clock get time ]; /system script add name=\"\$date-|-\$time-|-\$user-|-55000-|-\$address-|-\$mac-|-30d-|-bulanan-|-\$comment\" owner=\"\$month\$year\" source=\$date comment=mikhmon}}" parent-queue=none rate-limit=4M/4M transparent-proxy=yes
/ip hotspot user profile add address-pool=Hotspot name=BULANAN on-login=":put (\",remc,1500,12h,2000,,Disable,\"); {:local date [ /system clock get date ];:local year [ :pick \$date 7 11 ];:local month [ :pick \$date 0 3 ];:local comment [ /ip hotspot user get [/ip hotspot user find where name=\"\$user\"] comment]; :local ucode [:pic \$comment 0 2]; :if (\$ucode = \"vc\" or \$ucode = \"up\" or \$comment = \"\") do={ /sys sch add name=\"\$user\" disable=no start-date=\$date interval=\"12h\"; :delay 2s; :local exp [ /sys sch get [ /sys sch find where name=\"\$user\" ] next-run]; :local getxp [len \$exp]; :if (\$getxp = 15) do={ :local d [:pic \$exp 0 6]; :local t [:pic \$exp 7 16]; :local s (\"/\"); :local exp (\"\$d\$s\$year \$t\"); /ip hotspot user set comment=\$exp [find where name=\"\$user\"];}; :if (\$getxp = 8) do={ /ip hotspot user set comment=\"\$date \$exp\" [find where name=\"\$user\"];}; :if (\$getxp > 15) do={ /ip hotspot user set comment=\$exp [find where name=\"\$user\"];}; /sys sch remove [find where name=\"\$user\"]; :local mac \$\"mac-address\"; :local time [/system clock get time ]; /system script add name=\"\$date-|-\$time-|-\$user-|-1500-|-\$address-|-\$mac-|-12h-|-Paket2jam-|-\$comment\" owner=\"\$month\$year\" source=\$date comment=mikhmon}}" parent-queue=none rate-limit=4M/4M session-timeout=1m transparent-proxy=yes
/ip hotspot user profile add address-pool=Hotspot name=Paket-1-jam on-login=":put (\",remc,500,12h,1000,,Disable,\"); {:local date [ /system clock get date ];:local year [ :pick \$date 7 11 ];:local month [ :pick \$date 0 3 ];:local comment [ /ip hotspot user get [/ip hotspot user find where name=\"\$user\"] comment]; :local ucode [:pic \$comment 0 2]; :if (\$ucode = \"vc\" or \$ucode = \"up\" or \$comment = \"\") do={ /sys sch add name=\"\$user\" disable=no start-date=\$date interval=\"12h\"; :delay 2s; :local exp [ /sys sch get [ /sys sch find where name=\"\$user\" ] next-run]; :local getxp [len \$exp]; :if (\$getxp = 15) do={ :local d [:pic \$exp 0 6]; :local t [:pic \$exp 7 16]; :local s (\"/\"); :local exp (\"\$d\$s\$year \$t\"); /ip hotspot user set comment=\$exp [find where name=\"\$user\"];}; :if (\$getxp = 8) do={ /ip hotspot user set comment=\"\$date \$exp\" [find where name=\"\$user\"];}; :if (\$getxp > 15) do={ /ip hotspot user set comment=\$exp [find where name=\"\$user\"];}; /sys sch remove [find where name=\"\$user\"]; :local mac \$\"mac-address\"; :local time [/system clock get time ]; /system script add name=\"\$date-|-\$time-|-\$user-|-500-|-\$address-|-\$mac-|-12h-|-Paket-1-jam-|-\$comment\" owner=\"\$month\$year\" source=\$date comment=mikhmon}}" parent-queue=none rate-limit=4M/4M session-timeout=1h transparent-proxy=yes
/ip hotspot user profile add address-pool=Hotspot name=LERI rate-limit=4M/4M shared-users=4 transparent-proxy=yes
/ip hotspot user profile add address-pool=Hotspot name=V-2000 on-login=":put (\",remc,2000,2h,2000,,Disable,\"); {:local comment [ /ip hotspot user get [/ip hotspot user find where name=\"\$user\"] comment]; :local ucode [:pic \$comment 0 2]; :if (\$ucode = \"vc\" or \$ucode = \"up\" or \$comment = \"\") do={ :local date [ /system clock get date ];:local year [ :pick \$date 7 11 ];:local month [ :pick \$date 0 3 ]; /sys sch add name=\"\$user\" disable=no start-date=\$date interval=\"2h\"; :delay 5s; :local exp [ /sys sch get [ /sys sch find where name=\"\$user\" ] next-run]; :local getxp [len \$exp]; :if (\$getxp = 15) do={ :local d [:pic \$exp 0 6]; :local t [:pic \$exp 7 16]; :local s (\"/\"); :local exp (\"\$d\$s\$year \$t\"); /ip hotspot user set comment=\"\$exp\" [find where name=\"\$user\"];}; :if (\$getxp = 8) do={ /ip hotspot user set comment=\"\$date \$exp\" [find where name=\"\$user\"];}; :if (\$getxp > 15) do={ /ip hotspot user set comment=\"\$exp\" [find where name=\"\$user\"];};:delay 5s; /sys sch remove [find where name=\"\$user\"]; :local mac \$\"mac-address\"; :local time [/system clock get time ]; /system script add name=\"\$date-|-\$time-|-\$user-|-2000-|-\$address-|-\$mac-|-2h-|-V-2000-|-\$comment\" owner=\"\$month\$year\" source=\"\$date\" comment=\"mikhmon\"}}" parent-queue=none rate-limit=4M/4M session-timeout=2h transparent-proxy=yes
/ip hotspot user profile add address-pool=Hotspot name=V-3500 on-login=":put (\",remc,3500,6h,3500,,Disable,\"); {:local comment [ /ip hotspot user get [/ip hotspot user find where name=\"\$user\"] comment]; :local ucode [:pic \$comment 0 2]; :if (\$ucode = \"vc\" or \$ucode = \"up\" or \$comment = \"\") do={ :local date [ /system clock get date ];:local year [ :pick \$date 7 11 ];:local month [ :pick \$date 0 3 ]; /sys sch add name=\"\$user\" disable=no start-date=\$date interval=\"6h\"; :delay 5s; :local exp [ /sys sch get [ /sys sch find where name=\"\$user\" ] next-run]; :local getxp [len \$exp]; :if (\$getxp = 15) do={ :local d [:pic \$exp 0 6]; :local t [:pic \$exp 7 16]; :local s (\"/\"); :local exp (\"\$d\$s\$year \$t\"); /ip hotspot user set comment=\"\$exp\" [find where name=\"\$user\"];}; :if (\$getxp = 8) do={ /ip hotspot user set comment=\"\$date \$exp\" [find where name=\"\$user\"];}; :if (\$getxp > 15) do={ /ip hotspot user set comment=\"\$exp\" [find where name=\"\$user\"];};:delay 5s; /sys sch remove [find where name=\"\$user\"]; :local mac \$\"mac-address\"; :local time [/system clock get time ]; /system script add name=\"\$date-|-\$time-|-\$user-|-3500-|-\$address-|-\$mac-|-6h-|-V-3500-|-\$comment\" owner=\"\$month\$year\" source=\"\$date\" comment=\"mikhmon\"}}" parent-queue=none rate-limit=4M/4M session-timeout=6h transparent-proxy=yes
/ip hotspot user profile add address-pool=Hotspot name=V-6000 on-login=":put (\",remc,6000,12h,6000,,Disable,\"); {:local comment [ /ip hotspot user get [/ip hotspot user find where name=\"\$user\"] comment]; :local ucode [:pic \$comment 0 2]; :if (\$ucode = \"vc\" or \$ucode = \"up\" or \$comment = \"\") do={ :local date [ /system clock get date ];:local year [ :pick \$date 7 11 ];:local month [ :pick \$date 0 3 ]; /sys sch add name=\"\$user\" disable=no start-date=\$date interval=\"12h\"; :delay 5s; :local exp [ /sys sch get [ /sys sch find where name=\"\$user\" ] next-run]; :local getxp [len \$exp]; :if (\$getxp = 15) do={ :local d [:pic \$exp 0 6]; :local t [:pic \$exp 7 16]; :local s (\"/\"); :local exp (\"\$d\$s\$year \$t\"); /ip hotspot user set comment=\"\$exp\" [find where name=\"\$user\"];}; :if (\$getxp = 8) do={ /ip hotspot user set comment=\"\$date \$exp\" [find where name=\"\$user\"];}; :if (\$getxp > 15) do={ /ip hotspot user set comment=\"\$exp\" [find where name=\"\$user\"];};:delay 5s; /sys sch remove [find where name=\"\$user\"]; :local mac \$\"mac-address\"; :local time [/system clock get time ]; /system script add name=\"\$date-|-\$time-|-\$user-|-6000-|-\$address-|-\$mac-|-12h-|-V-6000-|-\$comment\" owner=\"\$month\$year\" source=\"\$date\" comment=\"mikhmon\"}}" parent-queue=none rate-limit=4M/4M session-timeout=12h transparent-proxy=yes
/ip hotspot user profile add address-pool=Hotspot name=V-55k on-login=":put (\",remc,55000,30d,55000,,Disable,\"); {:local comment [ /ip hotspot user get [/ip hotspot user find where name=\"\$user\"] comment]; :local ucode [:pic \$comment 0 2]; :if (\$ucode = \"vc\" or \$ucode = \"up\" or \$comment = \"\") do={ :local date [ /system clock get date ];:local year [ :pick \$date 7 11 ];:local month [ :pick \$date 0 3 ]; /sys sch add name=\"\$user\" disable=no start-date=\$date interval=\"30d\"; :delay 5s; :local exp [ /sys sch get [ /sys sch find where name=\"\$user\" ] next-run]; :local getxp [len \$exp]; :if (\$getxp = 15) do={ :local d [:pic \$exp 0 6]; :local t [:pic \$exp 7 16]; :local s (\"/\"); :local exp (\"\$d\$s\$year \$t\"); /ip hotspot user set comment=\"\$exp\" [find where name=\"\$user\"];}; :if (\$getxp = 8) do={ /ip hotspot user set comment=\"\$date \$exp\" [find where name=\"\$user\"];}; :if (\$getxp > 15) do={ /ip hotspot user set comment=\"\$exp\" [find where name=\"\$user\"];};:delay 5s; /sys sch remove [find where name=\"\$user\"]; :local mac \$\"mac-address\"; :local time [/system clock get time ]; /system script add name=\"\$date-|-\$time-|-\$user-|-55000-|-\$address-|-\$mac-|-30d-|-V-55k-|-\$comment\" owner=\"\$month\$year\" source=\"\$date\" comment=\"mikhmon\"}}" parent-queue=none rate-limit=4M/4M session-timeout=4w2d transparent-proxy=yes
/ip hotspot user profile add address-pool=Hotspot name=V-100k on-login=":put (\",remc,100000,30d,100000,,Disable,\"); {:local comment [ /ip hotspot user get [/ip hotspot user find where name=\"\$user\"] comment]; :local ucode [:pic \$comment 0 2]; :if (\$ucode = \"vc\" or \$ucode = \"up\" or \$comment = \"\") do={ :local date [ /system clock get date ];:local year [ :pick \$date 7 11 ];:local month [ :pick \$date 0 3 ]; /sys sch add name=\"\$user\" disable=no start-date=\$date interval=\"30d\"; :delay 5s; :local exp [ /sys sch get [ /sys sch find where name=\"\$user\" ] next-run]; :local getxp [len \$exp]; :if (\$getxp = 15) do={ :local d [:pic \$exp 0 6]; :local t [:pic \$exp 7 16]; :local s (\"/\"); :local exp (\"\$d\$s\$year \$t\"); /ip hotspot user set comment=\"\$exp\" [find where name=\"\$user\"];}; :if (\$getxp = 8) do={ /ip hotspot user set comment=\"\$date \$exp\" [find where name=\"\$user\"];}; :if (\$getxp > 15) do={ /ip hotspot user set comment=\"\$exp\" [find where name=\"\$user\"];};:delay 5s; /sys sch remove [find where name=\"\$user\"]; :local mac \$\"mac-address\"; :local time [/system clock get time ]; /system script add name=\"\$date-|-\$time-|-\$user-|-100000-|-\$address-|-\$mac-|-30d-|-V-100k-|-\$comment\" owner=\"\$month\$year\" source=\"\$date\" comment=\"mikhmon\"}}" parent-queue=none rate-limit=4M/4M session-timeout=4w2d shared-users=2 transparent-proxy=yes
/port set 0 baud-rate=115200 name=serial0
/ppp profile add local-address=11.1.0.1 name=PAKET1 remote-address=paket1
/ppp profile add local-address=11.2.0.1 name=PAKET2 remote-address=paket2
/ppp profile add local-address=11.3.0.1 name=PAKET3 remote-address=paket3
/ppp profile add local-address=11.4.0.1 name=PAKET4 remote-address=paket4
/ppp profile add local-address=11.5.0.1 name=PAKET5 remote-address=paket5
/ppp profile add local-address=11.6.0.1 name=PAKET6 remote-address="HOTSPOT TRIAL"
/ppp profile add local-address=10.7.0.1 name=TUNNEL-PROFILE remote-address=TUNNEL-CLIENTS use-encryption=yes
/ppp profile add change-tcp-mss=yes comment="single-session tunnel profile" local-address=10.6.0.1 name=TUNNEL-SINGLE only-one=yes remote-address=10.6.0.0
/ppp profile set *FFFFFFFE local-address=Hotspot remote-address=Hotspot
/queue simple add max-limit=13M/13M name="PA ADANG CIGURIANG" target=10.10.10.158/32
/queue simple add max-limit=5M/5M name="BU RT 05" target=10.10.10.164/32
/queue type add kind=sfq name=SFQ
/queue type add kind=pcq name=2Mvideo pcq-classifier=dst-address,dst-port pcq-rate=2M
/queue type add kind=pcq name="pcq-up 8m" pcq-classifier=src-address pcq-rate=8M
/queue type add kind=pcq name="pcq-down 8m" pcq-classifier=dst-address pcq-rate=8M
/queue type add kind=pcq name="pcq-up 13m" pcq-classifier=src-address pcq-rate=13M
/queue type add kind=pcq name="pcq-up 20m" pcq-classifier=src-address pcq-rate=20M
/queue type add kind=pcq name="pcq-up 30m" pcq-classifier=src-address pcq-rate=30M
/queue type add kind=pcq name="pcq-down 13m" pcq-classifier=dst-address pcq-rate=13M
/queue type add kind=pcq name="pcq-down 20m" pcq-classifier=dst-address pcq-rate=20M
/queue type add kind=pcq name="pcq-down 30m" pcq-classifier=dst-address pcq-rate=30M
/queue type add kind=pcq name="pcq-down 1G" pcq-classifier=dst-address pcq-rate=1G
/queue type add kind=pcq name="pcq-up 1G" pcq-classifier=src-address pcq-rate=1G
/queue type add kind=pcq name="pcq-down 100m" pcq-classifier=dst-address pcq-rate=100M
/queue type add kind=pcq name="pcq-up 100m" pcq-classifier=src-address pcq-rate=100M
/ip hotspot user profile add name=ENDA queue-type=SFQ rate-limit=4M/4M shared-users=3 transparent-proxy=yes
/ip hotspot user profile add name="1BULAN 1ORANG" queue-type=SFQ rate-limit=5M/5M session-timeout=4w2d transparent-proxy=yes
/ip hotspot user profile add name=BINTANG queue-type=SFQ rate-limit=4M/4M shared-users=7 transparent-proxy=yes
/ip hotspot user profile add name="EDI JAELANI" queue-type=SFQ rate-limit=2M/2M shared-users=4 transparent-proxy=yes
/queue tree add disabled=yes name=video4m packet-mark=video parent=global queue=2Mvideo
/routing bgp instance set default disabled=yes
/snmp community set [ find default=yes ] write-access=yes
/snmp community add addresses=::/0 name=readsmy
/user group set full policy=local,telnet,ssh,ftp,reboot,read,write,policy,test,winbox,password,web,sniff,sensitive,api,romon,dude,tikapp
/user group add name=mikhmon policy=read,write,sensitive,api,!local,!telnet,!ssh,!ftp,!reboot,!policy,!test,!winbox,!password,!web,!sniff,!romon,!dude,!tikapp
/user group add name=prometheus policy=read,test,winbox,api,!local,!telnet,!ssh,!ftp,!reboot,!write,!policy,!password,!web,!sniff,!sensitive,!romon,!dude,!tikapp
/interface bridge port add bridge=MASTER interface=VLAN-HOTSPOT-EPON
/interface bridge port add bridge=MASTER interface=ether6 multicast-router=disabled
/interface bridge port add bridge=MASTER interface=VLAN-HOTSPOT-GPON
/interface bridge port add bridge=FORM-CILISUNG interface=sfp-HYPER
/interface bridge port add bridge=FORM-CILISUNG interface=SFP-COMBO
/ip neighbor discovery-settings set discover-interface-list=!dynamic
/interface bridge vlan add bridge="BRIDGE VLAN" tagged=sfp-HYPER untagged=ether7 vlan-ids=103
/interface detect-internet set detect-interface-list=all
/interface l2tp-server server set enabled=yes
/interface ovpn-server server set certificate=Server enabled=yes mode=ethernet port=1000
/interface pppoe-server server add disabled=no interface=MASTER service-name="Server PPoE"
/interface pppoe-server server add disabled=no service-name=PPPOE-OLT
/interface pppoe-server server add disabled=no service-name=service1
/interface pptp-server server set enabled=yes
/ip address add address=10.10.10.1/24 interface=MASTER network=10.10.10.0
/ip address add address=192.168.123.12/24 interface=ether5-pfsense network=192.168.123.0
/ip address add address=192.168.44.1/24 interface=MASTER network=192.168.44.0
/ip address add address=10.1.1.1/24 interface=MASTER network=10.1.1.0
/ip address add address=115.178.49.186/30 comment=SIMAYA interface=ether1-SIMAYA network=115.178.49.184
/ip address add address=172.80.10.1/24 interface=ether4-TO-X86 network=172.80.10.0
/ip address add address=10.101.0.1/21 network=10.101.0.0
/ip address add address=192.168.78.1/24 disabled=yes interface=ether5-pfsense network=192.168.78.0
/ip address add address=172.90.10.1/24 interface=TO-CILISUNG network=172.90.10.0
/ip cloud set update-time=no
/ip dhcp-server lease add address=10.10.10.140 mac-address=04:95:E6:34:6C:B0
/ip dhcp-server network add address=10.1.1.0/24 gateway=10.10.10.1
/ip dhcp-server network add address=10.5.50.0/24 comment="hotspot network" dns-server=10.10.10.1 gateway=10.5.50.1
/ip dhcp-server network add address=10.10.10.0/24 comment="hotspot network" dns-server=10.10.10.1 gateway=10.10.10.1
/ip dhcp-server network add address=10.20.30.0/24 comment="hotspot network" gateway=10.20.30.1
/ip dhcp-server network add address=10.101.0.0/21 comment=acs dhcp-option=geineacs dns-server=10.101.0.1 gateway=10.101.0.1
/ip dhcp-server network add address=172.20.1.0/24 comment="hotspot network" gateway=172.20.1.1
/ip dhcp-server network add address=192.168.44.0/24 dns-server=10.10.10.1 gateway=192.168.44.1
/ip dhcp-server network add address=192.168.78.0/24 gateway=192.168.78.1
/ip dhcp-server network add address=192.168.89.0/24 gateway=192.168.89.1
/ip dns set allow-remote-requests=yes cache-max-ttl=1d cache-size=4096KiB servers=8.8.8.8,8.8.4.4
/ip firewall address-list add address=10.10.10.0/24 list=HOTSPOT
/ip firewall address-list add address=0.0.0.0/8 list=private-lokal
/ip firewall address-list add address=10.0.0.0/8 list=private-lokal
/ip firewall address-list add address=100.64.0.0/10 list=private-lokal
/ip firewall address-list add address=127.0.0.0/8 list=private-lokal
/ip firewall address-list add address=169.254.0.0/16 list=private-lokal
/ip firewall address-list add address=172.16.0.0/12 list=private-lokal
/ip firewall address-list add address=192.0.0.0/24 list=private-lokal
/ip firewall address-list add address=192.0.2.0/24 list=private-lokal
/ip firewall address-list add address=192.168.0.0/16 list=private-lokal
/ip firewall address-list add address=198.18.0.0/15 list=private-lokal
/ip firewall address-list add address=198.51.100.0/24 list=private-lokal
/ip firewall address-list add address=203.0.113.0/24 list=private-lokal
/ip firewall address-list add address=224.0.0.0/3 list=private-lokal
/ip firewall address-list add address=10.10.10.197 list=GAENG
/ip firewall address-list add address=10.10.10.202-10.10.10.254 list=VOUCHER
/ip firewall address-list add address=192.168.33.3-192.168.33.254 list=PPPOE
/ip firewall address-list add address=10.10.10.2-10.10.10.100 list="ALL 10.10"
/ip firewall address-list add address=192.168.44.100-192.168.44.254 list=VOUCHER2
/ip firewall address-list add address=10.3.3.255 list=YOFINO
/ip firewall address-list add address=192.168.33.0/24 list=private-lokal
/ip firewall address-list add address=reddit.com list=Reddit
/ip firewall address-list add address=10.1.1.0/24 list=private-lokal
/ip firewall address-list add address=192.168.254.253 list=client
/ip firewall address-list add address=10.1.0.0/22 list=private-lokal
/ip firewall address-list add address=10.2.0.0/22 list=private-lokal
/ip firewall address-list add address=10.3.0.0/22 list=private-lokal
/ip firewall address-list add address=10.4.0.0/22 list=private-lokal
/ip firewall address-list add address=yougetsignal.com list=speedtest
/ip firewall address-list add address=xmyip.com list=speedtest
/ip firewall address-list add address=www.yougetsignal.com list=speedtest
/ip firewall address-list add address=expressvpn.com list=speedtest
/ip firewall address-list add address=www.expressvpn.com list=speedtest
/ip firewall address-list add address=whatismyip.net list=speedtest
/ip firewall address-list add address=speedtestcustom.com comment=whatismyip.net list=speedtest
/ip firewall address-list add address=income.speedtestcustom.com comment=speedtestcustom.com list=speedtest
/ip firewall address-list add address=iplocation.net comment=income.speedtestcustom.com list=speedtest
/ip firewall address-list add address=www.iplocation.net comment=iplocation.net list=speedtest
/ip firewall address-list add address=www.astrill.com comment=www.iplocation.net list=speedtest
/ip firewall address-list add address=www.privateinternetaccess.com comment=www.astrill.com list=speedtest
/ip firewall address-list add address=mxtoolbox.com comment=www.privateinternetaccess.com list=speedtest
/ip firewall address-list add address=ifconfig.co comment=mxtoolbox.com list=speedtest
/ip firewall address-list add address=whatismyip.org comment=ifconfig.co list=speedtest
/ip firewall address-list add address=www.goldenfrog.com comment=whatismyip.org list=speedtest
/ip firewall address-list add address=www.mxtoolbox.com comment=www.goldenfrog.com list=speedtest
/ip firewall address-list add address=www.ultratools.com comment=www.mxtoolbox.com list=speedtest
/ip firewall address-list add address=www.ip-adress.eu comment=www.ultratools.com list=speedtest
/ip firewall address-list add address=iplogger.org list=speedtest
/ip firewall address-list add address=www.vermiip.es list=speedtest
/ip firewall address-list add address=www.purevpn.com list=speedtest
/ip firewall address-list add address=www.whatismybrowser.com list=speedtest
/ip firewall address-list add address=zenmate.com list=speedtest
/ip firewall address-list add address=www.ipchicken.com list=speedtest
/ip firewall address-list add address=bittrex.com list=speedtest
/ip firewall address-list add address=whatismyip.li list=speedtest
/ip firewall address-list add address=www.ipburger.com list=speedtest
/ip firewall address-list add address=cbn.net.id list=speedtest
/ip firewall address-list add address=whatismyip4.com list=speedtest
/ip firewall address-list add address=www.inmotionhosting.com list=speedtest
/ip firewall address-list add address=nordvpn.com list=speedtest
/ip firewall address-list add address=wolframalpha.com list=speedtest
/ip firewall address-list add address=cactusvpn.com list=speedtest
/ip firewall address-list add address=www.cactusvpn.com list=speedtest
/ip firewall address-list add address=m.wolframalpha.com list=speedtest
/ip firewall address-list add address=ipcow.com list=speedtest
/ip firewall address-list add address=whatismycountry.com list=speedtest
/ip firewall address-list add address=passwordsgenerator.net list=speedtest
/ip firewall address-list add address=att-services.net list=speedtest
/ip firewall address-list add address=wtfismyip.com list=speedtest
/ip firewall address-list add address=whatismyip.network list=speedtest
/ip firewall address-list add address=ipinfo.info list=speedtest
/ip firewall address-list add address=encodable.com list=speedtest
/ip firewall address-list add address=www.overplay.net list=speedtest
/ip firewall address-list add address=myipaddress.com list=speedtest
/ip firewall address-list add address=www.myipaddress.com list=speedtest
/ip firewall address-list add address=whoer.net list=speedtest
/ip firewall address-list add address=whatismyip.com list=speedtest
/ip firewall address-list add address=www.speedtest.net list=speedtest
/ip firewall address-list add address=c.speedtest.net list=speedtest
/ip firewall address-list add address=www.ipleak.net list=speedtest
/ip firewall address-list add address=ipleak.net list=speedtest
/ip firewall address-list add address=whatismyipaddress.com list=speedtest
/ip firewall address-list add address=whatismyip.host list=speedtest
/ip firewall address-list add address=bearsmyip.com list=speedtest
/ip firewall address-list add address=check-host.net list=speedtest
/ip firewall address-list add address=hide.me list=speedtest
/ip firewall address-list add address=ipv6test.hide.me list=speedtest
/ip firewall address-list add address=ipleak.com list=speedtest
/ip firewall address-list add address=www.perfect-privacy.com list=speedtest
/ip firewall address-list add address=perfect-privacy.com list=speedtest
/ip firewall address-list add address=www.whatsmyip.org list=speedtest
/ip firewall address-list add address=10.0.0.0/8 list=bypass
/ip firewall address-list add address=192.168.0.0/16 list=bypass
/ip firewall address-list add address=172.16.0.0/12 list=bypass
/ip firewall address-list add address=103.226.138.15 list=bypass
/ip firewall address-list add address=172.80.10.0/24 list=bypass
/ip firewall address-list add address=roblox.com list=roblox
/ip firewall address-list add address=bgp.he.net list=speedtest
/ip firewall address-list add address=whatsapp.com list=WHATSAPP
/ip firewall address-list add address=whatsapp.net list=WHATSAPP
/ip firewall address-list add address=wa.me list=WHATSAPP
/ip firewall address-list add address=172.90.10.0/24 list=private-lokal
/ip firewall filter add action=passthrough chain=unused-hs-chain comment="place hotspot rules here" disabled=yes
/ip firewall filter add action=fasttrack-connection chain=forward connection-state=established,related disabled=yes dst-port=3478,4244,5222,5223,5228,5288,5242,5349,34784,45395,50318,59234 protocol=tcp src-address=10.10.10.0/24
/ip firewall filter add action=fasttrack-connection chain=forward connection-state=established,related disabled=yes dst-port=3478,4244,5222,5223,5228,5288,5242,5349,34784,45395,50318,59234 protocol=udp src-address=10.10.10.0/24
/ip firewall filter add action=fasttrack-connection chain=forward connection-state=established,related disabled=yes dst-port=3478,4244,5222,5223,5228,5288,5242,5349,34784,45395,50318,59234 protocol=tcp src-address=192.168.44.0/24
/ip firewall filter add action=fasttrack-connection chain=forward connection-state=established,related disabled=yes dst-port=3478,4244,5222,5223,5228,5288,5242,5349,34784,45395,50318,59234 protocol=udp src-address=192.168.44.0/24
/ip firewall filter add action=accept chain=forward connection-state=established,related
/ip firewall filter add action=drop chain=forward comment=ISOLIR|220312184723 src-address=10.10.10.49
/ip firewall filter add action=drop chain=forward comment=ISOLIR|211106091137 src-address=10.10.10.79
/ip firewall filter add action=drop chain=forward comment=ISOLIR|210902170902 src-address=10.10.10.128
/ip firewall filter add action=drop chain=forward comment=ISOLIR|210903131530 src-address=10.10.10.29
/ip firewall filter add action=drop chain=forward comment=ISOLIR|221108133829 src-address=192.168.44.37
/ip firewall filter add action=drop chain=forward comment=ISOLIR|230114074211 src-address=192.168.44.25
/ip firewall filter add action=drop chain=forward comment=ISOLIR|230108152454 src-address=192.168.44.49
/ip firewall filter add action=drop chain=forward comment=ISOLIR|220106111738 src-address=10.10.10.152
/ip firewall filter add action=drop chain=forward comment=ISOLIR|210902124352 src-address=10.10.10.44
/ip firewall filter add action=drop chain=forward comment=ISOLIR|230114074221 src-address=192.168.44.68
/ip firewall filter add action=drop chain=forward comment=ISOLIR|231008170934 src-address=10.10.10.81
/ip firewall filter add action=drop chain=forward comment=ISOLIR|210902163618 src-address=10.10.10.58
/ip firewall filter add action=drop chain=forward comment=ISOLIR|221119172550 src-address=10.10.10.117
/ip firewall filter add action=accept chain=input dst-port=161 protocol=udp src-address=172.18.0.0/16
/ip firewall filter add action=accept chain=forward comment="Allow Zabbix to pfSense" dst-address=192.168.123.1 dst-port=10050 protocol=tcp
/ip firewall filter add action=drop chain=input src-address=45.205.1.110
/ip firewall filter add action=drop chain=input src-address=91.92.103.149
/ip firewall filter add action=drop chain=input src-address=103.110.8.106
/ip firewall filter add action=drop chain=input src-address=86.125.222.222
/ip firewall filter add action=log chain=forward dst-address=172.80.10.100 dst-port=8728 log-prefix="CCR2116-API-ATTACK: " protocol=tcp
/ip firewall filter add action=drop chain=forward comment=BLOCK-CCR2116-API-WAN dst-address=172.80.10.100 dst-port=8728 protocol=tcp src-address=!10.0.0.0/8
/ip firewall mangle add action=accept chain=forward disabled=yes dst-address-list=bypass src-address-list=bypass
/ip firewall mangle add action=accept chain=output disabled=yes dst-address-list=bypass src-address-list=bypass
/ip firewall mangle add action=accept chain=prerouting disabled=yes dst-address-list=bypass src-address-list=bypass
/ip firewall mangle add action=mark-routing chain=prerouting comment="<<<===|| VPN-SPEEDTEST ||===>>>" disabled=yes dst-address-list=speedtest new-routing-mark=FASTAMA passthrough=no src-address-list=private-lokal
/ip firewall mangle add action=mark-routing chain=prerouting disabled=yes new-routing-mark=MYREP passthrough=yes src-address=10.10.10.28
/ip firewall mangle add action=mark-routing chain=prerouting disabled=yes new-routing-mark=MYREP passthrough=yes src-address=172.90.10.11
/ip firewall mangle add action=mark-routing chain=prerouting disabled=yes new-routing-mark=MYREP passthrough=yes src-address=10.10.10.22-10.10.10.51
/ip firewall mangle add action=mark-routing chain=prerouting disabled=yes new-routing-mark=MYREP passthrough=yes src-address=10.10.10.18
/ip firewall mangle add action=mark-routing chain=prerouting disabled=yes new-routing-mark=MYREP passthrough=yes src-address=10.10.10.53-10.10.10.199
/ip firewall mangle add action=mark-routing chain=prerouting comment="HOTSPOT VOUCHER" disabled=yes new-routing-mark=MYREP passthrough=yes src-address-list=VOUCHER
/ip firewall mangle add action=mark-routing chain=prerouting comment="MYREP INOY" disabled=yes new-routing-mark=MYREP passthrough=yes src-address=10.1.0.0/22
/ip firewall mangle add action=mark-routing chain=prerouting comment="MYREP INOY" disabled=yes new-routing-mark=MYREP passthrough=yes src-address=10.4.0.0/22
/ip firewall mangle add action=mark-routing chain=prerouting comment="MYREP INOY" disabled=yes new-routing-mark=MYREP passthrough=yes src-address=10.2.0.0/22
/ip firewall mangle add action=mark-routing chain=prerouting comment="MYREP INOY" disabled=yes new-routing-mark=MYREP passthrough=yes src-address=10.3.0.0/22
/ip firewall mangle add action=mark-routing chain=prerouting disabled=yes new-routing-mark=MYREP passthrough=yes src-address=192.168.44.13-192.168.44.71
/ip firewall mangle add action=mark-routing chain=prerouting disabled=yes new-routing-mark=MYREP passthrough=yes src-address-list=VOUCHER2
/ip firewall mangle add action=add-dst-to-address-list address-list=video address-list-timeout=1h chain=forward disabled=yes protocol=tcp tls-host=*video*
/ip firewall mangle add action=add-dst-to-address-list address-list=video address-list-timeout=1h chain=forward disabled=yes protocol=tcp tls-host=*tiktokv*
/ip firewall mangle add action=add-dst-to-address-list address-list=video address-list-timeout=1h chain=forward disabled=yes protocol=tcp tls-host=*tiktokcdn*
/ip firewall mangle add action=add-dst-to-address-list address-list=video address-list-timeout=1h chain=forward disabled=yes protocol=tcp tls-host=*fbcdn*
/ip firewall mangle add action=mark-packet chain=forward disabled=yes new-packet-mark=video passthrough=no src-address-list=video
/ip firewall mangle add action=mark-routing chain=prerouting disabled=yes dst-address-list=video new-routing-mark=VIDEOTLS passthrough=yes src-address-list=private-lokal
/ip firewall mangle add action=mark-routing chain=prerouting comment=WHATSAPP disabled=yes dst-address-list=WHATSAPP-DOMAIN new-routing-mark=VIA-SIMAYA passthrough=yes src-address-list=private-lokal
/ip firewall mangle add action=mark-routing chain=prerouting comment=UMUM disabled=yes dst-port=21-23,80,81,88,182,443,843,853,5050,8000-8081,8090,8443,8888 new-routing-mark=MYREP passthrough=no protocol=tcp src-address-list=YOFINO
/ip firewall mangle add action=mark-routing chain=prerouting disabled=yes dst-port=21-23,80,81,88,182,443,843,853,5050,8000-8081,8090,8443,8888 new-routing-mark=MYREP passthrough=no protocol=udp src-address-list=YOFINO
/ip firewall mangle add action=mark-routing chain=prerouting comment=MARKETPLACE disabled=yes dst-address-list=WHATSAPP new-routing-mark=VIA-SIMAYA passthrough=no src-address-list=private-lokal
/ip firewall mangle add action=mark-routing chain=prerouting comment=WA-TCP disabled=yes dst-port=443,5222,5223,5228 layer7-protocol=*1 new-routing-mark=VIA-SIMAYA passthrough=yes protocol=tcp
/ip firewall mangle add action=mark-routing chain=prerouting comment=WA-VOIP disabled=yes dst-port=3478,40000-49999 new-routing-mark=VIA-SIMAYA passthrough=yes protocol=udp
/ip firewall nat add action=passthrough chain=unused-hs-chain comment="place hotspot rules here" disabled=yes
/ip firewall nat add action=masquerade chain=srcnat disabled=yes dst-address=10.1.0.0/22 src-address=10.10.10.21
/ip firewall nat add action=dst-nat chain=dstnat dst-address=115.178.49.186 dst-port=8899 protocol=tcp to-addresses=192.168.123.1 to-ports=8291
/ip firewall nat add action=dst-nat chain=dstnat comment=NOCITA-RTR-CC1 dst-address=115.178.49.186 dst-port=1011 protocol=tcp to-addresses=10.10.10.1 to-ports=161
/ip firewall nat add action=dst-nat chain=dstnat comment=NOCITA-UPS-PUSAT dst-address=115.178.49.186 dst-port=1012 protocol=tcp to-addresses=10.10.10.18 to-ports=10050
/ip firewall nat add action=dst-nat chain=dstnat comment=NOCITA-PWR-PUSAT dst-address=115.178.49.186 dst-port=1013 protocol=tcp to-addresses=10.10.10.16 to-ports=10050
/ip firewall nat add action=dst-nat chain=dstnat comment=NOCITA-PWR-PUSAT dst-address=115.178.49.186 dst-port=1045 protocol=tcp to-addresses=192.168.123.1 to-ports=443
/ip firewall nat add action=dst-nat chain=dstnat comment=DAGO-MIKROTIK-WINBOX dst-address=115.178.49.186 dst-port=1041 protocol=tcp to-addresses=10.6.0.2 to-ports=8291
/ip firewall nat add action=dst-nat chain=dstnat comment=KATAPANG-MIKROTIK-WINBOX dst-address=115.178.49.186 dst-port=1031 protocol=tcp to-addresses=10.7.0.9 to-ports=1031
/ip firewall nat add action=dst-nat chain=dstnat comment=DAGO-MIKROTIK-API dst-address=115.178.49.186 dst-port=1141 protocol=tcp to-addresses=10.6.0.2 to-ports=8728
/ip firewall nat add action=dst-nat chain=dstnat comment="pusat x86 mikrotik" dst-address=115.178.49.186 dst-port=1044 protocol=tcp to-addresses=172.80.10.100 to-ports=8291
/ip firewall nat add action=dst-nat chain=dstnat comment="pusat x86 mikrotik" dst-address=115.178.49.186 dst-port=1144 protocol=tcp to-addresses=172.80.10.100 to-ports=8788
/ip firewall nat add action=dst-nat chain=dstnat comment=PFSENSE-DAGO dst-address=115.178.49.186 dst-port=1042 protocol=tcp to-addresses=10.6.0.2 to-ports=1042
/ip firewall nat add action=dst-nat chain=dstnat comment=PFSENSE-CILISUNG-SSL dst-address=115.178.49.186 dst-port=1022 protocol=tcp to-addresses=10.7.0.8 to-ports=1022
/ip firewall nat add action=dst-nat chain=dstnat comment=PFSENSE-CILISUNG-SSL dst-address=115.178.49.186 dst-port=1088 protocol=tcp to-addresses=10.10.10.18 to-ports=8080
/ip firewall nat add action=dst-nat chain=dstnat comment=PFSENSE-CILISUNG-SNMP dst-address=115.178.49.186 dst-port=1023 protocol=udp to-addresses=10.7.0.8 to-ports=1023
/ip firewall nat add action=dst-nat chain=dstnat comment=PFSENSE-DAGO-SNMP dst-address=115.178.49.186 dst-port=1043 protocol=udp to-addresses=10.6.0.2 to-ports=1043
/ip firewall nat add action=dst-nat chain=dstnat comment=hotware dst-address=115.178.49.186 dst-port=2042 protocol=tcp to-addresses=10.6.0.7 to-ports=2042
/ip firewall nat add action=dst-nat chain=dstnat comment=EPON-PUSAT dst-address=115.178.49.186 dst-port=1047 protocol=tcp to-addresses=10.10.10.203 to-ports=80
/ip firewall nat add action=dst-nat chain=dstnat comment=GPON-PUSAT dst-address=115.178.49.186 dst-port=1048 protocol=tcp to-addresses=10.10.10.204 to-ports=80
/ip firewall nat add action=dst-nat chain=dstnat comment=EPON-HSGQ-CILISUNG dst-address=115.178.49.186 dst-port=1049 protocol=tcp to-addresses=192.168.101.10 to-ports=80
/ip firewall nat add action=dst-nat chain=dstnat comment=EPON-HIOSO-CILISUNG dst-address=115.178.49.186 dst-port=1050 protocol=tcp to-addresses=192.168.0.88 to-ports=80
/ip firewall nat add action=dst-nat chain=dstnat comment=EPON-HIOSO-CILISUNG dst-address=115.178.49.186 dst-port=1051 protocol=tcp to-addresses=10.10.10.10 to-ports=37777
/ip firewall nat add action=dst-nat chain=dstnat comment=NOCITA-PWR-PUSAT dst-address=115.178.49.186 dst-port=1046 protocol=tcp to-addresses=10.10.10.18 to-ports=22
/ip firewall nat add action=dst-nat chain=dstnat comment=NOCITA-PWR-PUSAT dst-address=115.178.49.186 dst-port=1038 protocol=tcp to-addresses=10.10.10.30 to-ports=22
/ip firewall nat add action=masquerade chain=srcnat
/ip firewall nat add action=masquerade chain=srcnat
/ip firewall nat add action=masquerade chain=srcnat
/ip firewall nat add action=masquerade chain=srcnat
/ip firewall nat
# in/out-interface matcher not possible when interface (SFP-COMBO) is slave - use master instead (FORM-CILISUNG)
add action=masquerade chain=srcnat out-interface=SFP-COMBO
/ip firewall nat
# in/out-interface matcher not possible when interface (sfp-HYPER) is slave - use master instead (FORM-CILISUNG)
add action=masquerade chain=srcnat out-interface=sfp-HYPER
/ip firewall nat add action=masquerade chain=srcnat
/ip firewall nat add action=masquerade chain=srcnat
/ip firewall nat
# no interface
add action=masquerade chain=srcnat out-interface=*F
/ip firewall nat
# no interface
add action=masquerade chain=srcnat out-interface=*D
/ip firewall nat add action=masquerade chain=srcnat comment="masquerade hotspot network" src-address=10.10.10.0/24
/ip firewall nat
# no interface
add action=dst-nat chain=dstnat dst-port=1052 in-interface=*F protocol=tcp to-addresses=10.10.10.2 to-ports=8291
/ip firewall nat add action=dst-nat chain=dstnat disabled=yes dst-port=53 protocol=tcp src-address=!10.10.10.15 to-addresses=10.10.10.15 to-ports=5352
/ip firewall nat add action=dst-nat chain=dstnat disabled=yes dst-port=53 protocol=udp src-address=!10.10.10.15 to-addresses=10.10.10.15 to-ports=5352
/ip firewall nat add action=masquerade chain=srcnat comment="masquerade hotspot network" src-address=10.5.50.0/24
/ip firewall nat add action=dst-nat chain=dstnat disabled=yes dst-port=106 in-interface=*F protocol=tcp to-addresses=10.10.10.18 to-ports=106
/ip firewall nat add action=dst-nat chain=dstnat disabled=yes dst-port=110 in-interface=*F protocol=tcp to-addresses=10.10.10.18 to-ports=110
/ip firewall nat add action=dst-nat chain=dstnat disabled=yes dst-port=143 in-interface=*F protocol=tcp to-addresses=10.10.10.18 to-ports=143
/ip firewall nat add action=dst-nat chain=dstnat disabled=yes dst-port=2224 in-interface=*F protocol=tcp to-addresses=10.10.10.18 to-ports=2224
/ip firewall nat add action=masquerade chain=srcnat disabled=yes out-interface=*1D
/ip firewall nat add action=masquerade chain=srcnat comment="masquerade hotspot network" src-address=10.5.50.0/24
/ip firewall nat add action=masquerade chain=srcnat comment="masquerade hotspot network" src-address=10.5.50.0/24
/ip firewall nat add action=masquerade chain=srcnat comment="masquerade hotspot network" src-address=10.5.50.0/24
/ip firewall nat add action=masquerade chain=srcnat comment="masquerade hotspot network" src-address=172.20.1.0/24
/ip firewall nat add action=masquerade chain=srcnat comment="masquerade hotspot network" src-address=10.10.10.0/24
/ip firewall nat add action=dst-nat chain=dstnat dst-address=115.178.49.186 dst-port=1141 protocol=tcp to-addresses=10.6.0.2 to-ports=1141
/ip firewall nat add action=masquerade chain=srcnat comment="masquerade hotspot network" src-address=10.20.30.0/24
/ip firewall nat add action=dst-nat chain=dstnat comment=tunnel-nat-172.28.0.130-3000 dst-address=172.28.0.130 dst-port=3000 protocol=tcp to-addresses=10.10.10.230 to-ports=3000
/ip firewall nat add action=dst-nat chain=dstnat comment="GENIE ACS" dst-port=3001 in-interface=ether1-SIMAYA protocol=tcp to-addresses=10.10.10.22 to-ports=3000
/ip firewall nat
# no interface
add action=dst-nat chain=dstnat dst-port=1259 in-interface=*F protocol=tcp to-addresses=10.10.10.22 to-ports=3000
/ip firewall nat add action=dst-nat chain=dstnat comment="DAVID-SETRADUTA Winbox" dst-address=115.178.49.186 dst-port=1061 protocol=tcp to-addresses=10.7.0.2 to-ports=8291
/ip firewall nat add action=dst-nat chain=dstnat comment="ACS API" dst-address=115.178.49.186 dst-port=7557 protocol=tcp to-addresses=10.10.10.230 to-ports=7557
/ip firewall nat add action=dst-nat chain=dstnat comment="ACS API" dst-address=115.178.49.186 dst-port=7666 protocol=tcp to-addresses=10.10.10.209 to-ports=22
/ip firewall nat add action=dst-nat chain=dstnat comment="DAVID-SETRADUTA SSL" dst-address=115.178.49.186 dst-port=1062 protocol=tcp to-addresses=10.7.0.2 to-ports=443
/ip firewall nat add action=dst-nat chain=dstnat comment="RICKY-SETRADUTA Winbox" dst-address=115.178.49.186 dst-port=1063 protocol=tcp to-addresses=10.7.0.3 to-ports=8291
/ip firewall nat add action=dst-nat chain=dstnat comment="RICKY-SETRADUTA SSL" dst-address=115.178.49.186 dst-port=1064 protocol=tcp to-addresses=10.7.0.3 to-ports=443
/ip firewall nat add action=dst-nat chain=dstnat comment="TONY-KOTABARU Winbox" dst-address=115.178.49.186 dst-port=1065 protocol=tcp to-addresses=10.7.0.4 to-ports=8291
/ip firewall nat add action=dst-nat chain=dstnat comment="TONY-KOTABARU SSL" dst-address=115.178.49.186 dst-port=1066 protocol=tcp to-addresses=10.7.0.4 to-ports=443
/ip firewall nat add action=dst-nat chain=dstnat comment="HANDY-SETRADUTA Winbox" dst-address=115.178.49.186 dst-port=1067 protocol=tcp to-addresses=10.7.0.5 to-ports=8291
/ip firewall nat add action=dst-nat chain=dstnat comment="SSH ASEP" dst-address=115.178.49.186 dst-port=7556 protocol=tcp to-addresses=10.10.10.18 to-ports=22
/ip firewall nat add action=dst-nat chain=dstnat comment="HANDY-SETRADUTA SSL" dst-address=115.178.49.186 dst-port=1068 protocol=tcp to-addresses=10.7.0.5 to-ports=443
/ip firewall nat add action=dst-nat chain=dstnat comment="NILA-JATINANGOR-A Winbox" dst-address=115.178.49.186 dst-port=1069 protocol=tcp to-addresses=10.7.0.6 to-ports=8291
/ip firewall nat add action=dst-nat chain=dstnat comment="NILA-JATINANGOR-B Winbox" dst-address=115.178.49.186 dst-port=1070 protocol=tcp to-addresses=10.7.0.7 to-ports=8291
/ip firewall nat add action=dst-nat chain=dstnat comment="NILA-JATINANGOR-B Winbox" dst-address=115.178.49.186 dst-port=1171 protocol=tcp to-addresses=10.10.10.230 to-ports=7557
/ip firewall nat add action=dst-nat chain=dstnat comment="RDP MINI PC" dst-address=115.178.49.186 dst-port=33899 protocol=tcp to-addresses=10.10.10.205 to-ports=3389
/ip firewall raw add action=add-dst-to-address-list address-list=youtube.com address-list-timeout=30m chain=prerouting content=.youtube.com disabled=yes dst-address-list=!private-lokal src-address-list=private-lokal
/ip firewall raw add action=add-dst-to-address-list address-list=youtube.com address-list-timeout=1h chain=prerouting content=.ytimg.com disabled=yes dst-address-list=!private-lokal src-address-list=private-lokal
/ip firewall raw add action=add-dst-to-address-list address-list=youtube.com address-list-timeout=1h chain=prerouting content=.googlevideo.com disabled=yes dst-address-list=!private-lokal src-address-list=private-lokal
/ip hotspot ip-binding add address=10.10.10.10 comment=NVR to-address=10.10.10.10 type=bypassed
/ip hotspot ip-binding add address=10.10.10.21 comment=DOMBA to-address=10.10.10.21 type=bypassed
/ip hotspot ip-binding add address=10.10.10.22 comment=aapanel to-address=10.10.10.22 type=bypassed
/ip hotspot ip-binding add address=10.10.10.5 comment="SWITCH USW" to-address=10.10.10.5 type=bypassed
/ip hotspot ip-binding add address=10.10.10.23 comment=DOMBA to-address=10.10.10.23 type=bypassed
/ip hotspot ip-binding add address=10.10.10.4 comment="PROXMOX SERVER LOCAL" to-address=10.10.10.4 type=bypassed
/ip hotspot ip-binding add address=10.10.10.3 comment="Station ciguriang dyan" to-address=10.10.10.3 type=bypassed
/ip hotspot ip-binding add address=10.10.10.2 comment="AP UBIQUITI UTARA resti" to-address=10.10.10.2 type=bypassed
/ip hotspot ip-binding add address=10.10.10.6 comment="AP UBIQUITI KULON" to-address=10.10.10.6 type=bypassed
/ip hotspot ip-binding add address=10.10.10.7 comment="Station budi ciguriang" to-address=10.10.10.7 type=bypassed
/ip hotspot ip-binding add address=10.10.10.9 comment="AP Mikrotik" to-address=10.10.10.9 type=bypassed
/ip hotspot ip-binding add address=10.10.10.8 comment="Station carik" to-address=10.10.10.8 type=bypassed
/ip hotspot ip-binding add address=10.10.10.11 comment="AP AMAT" to-address=10.10.10.11 type=bypassed
/ip hotspot ip-binding add address=10.10.10.12 comment="kamera ip" to-address=10.10.10.12 type=bypassed
/ip hotspot ip-binding add address=10.10.10.13 comment="station fera carik" to-address=10.10.10.13 type=bypassed
/ip hotspot ip-binding add address=192.168.44.12 to-address=192.168.44.12 type=bypassed
/ip hotspot ip-binding add address=192.168.44.4 to-address=192.168.44.4 type=bypassed
/ip hotspot ip-binding add address=192.168.44.5 to-address=192.168.44.5 type=bypassed
/ip hotspot ip-binding add address=192.168.44.6 to-address=192.168.44.6 type=bypassed
/ip hotspot ip-binding add address=192.168.44.7 to-address=192.168.44.7 type=bypassed
/ip hotspot ip-binding add address=192.168.44.10 to-address=192.168.44.10 type=bypassed
/ip hotspot ip-binding add address=10.10.10.14 comment="CCTV MASJID" to-address=10.10.10.14 type=bypassed
/ip hotspot ip-binding add address=10.10.10.15 comment=WAVESHARE-RS485-ETHERNET to-address=10.10.10.15 type=bypassed
/ip hotspot ip-binding add address=10.10.10.16 comment="RASPBERY PI" to-address=10.10.10.16 type=bypassed
/ip hotspot ip-binding add address=10.10.10.18 comment=ZABBIX-GRAFANA to-address=10.10.10.18 type=bypassed
/ip hotspot ip-binding add disabled=yes mac-address=DC:F5:05:22:0E:87 type=blocked
/ip hotspot ip-binding add disabled=yes mac-address=9C:52:F8:38:24:F3 type=blocked
/ip hotspot ip-binding add disabled=yes mac-address=44:55:B1:AB:3E:B6 type=blocked
/ip hotspot ip-binding add address=10.10.10.104 to-address=10.10.10.104 type=bypassed
/ip hotspot ip-binding add disabled=yes mac-address=5C:92:5E:71:7D:E1 type=blocked
/ip hotspot ip-binding add comment="SI RENI" mac-address=04:F1:28:3A:A4:AB type=blocked
/ip hotspot ip-binding add disabled=yes mac-address=4A:B5:1C:2A:18:1A type=blocked
/ip hotspot ip-binding add disabled=yes mac-address=04:88:5F:FD:43:91 type=blocked
/ip hotspot ip-binding add disabled=yes mac-address=68:BF:C4:AE:49:56 type=bypassed
/ip hotspot ip-binding add address=10.10.10.158 to-address=10.10.10.158 type=bypassed
/ip hotspot ip-binding add address=10.10.10.164 to-address=10.10.10.164 type=bypassed
/ip hotspot ip-binding add address=10.5.50.40 to-address=10.5.50.40 type=bypassed
/ip hotspot ip-binding add disabled=yes mac-address=28:83:35:83:98:24 type=blocked
/ip hotspot ip-binding add comment=dapit disabled=yes mac-address=36:59:E4:71:28:4D type=blocked
/ip hotspot ip-binding add disabled=yes mac-address=5C:92:5E:71:55:D9 type=blocked
/ip hotspot ip-binding add address=10.10.10.200 to-address=10.10.10.200 type=bypassed
/ip hotspot ip-binding add address=10.10.10.201 to-address=10.10.10.201 type=bypassed
/ip hotspot ip-binding add address=10.10.10.202 comment="RADIO PA ANTON" to-address=10.10.10.202 type=bypassed
/ip hotspot ip-binding add address=10.10.10.203 comment="OLT EPON" to-address=10.10.10.203 type=bypassed
/ip hotspot ip-binding add address=10.10.10.204 comment="OLT GPON" to-address=10.10.10.204 type=bypassed
/ip hotspot ip-binding add address=10.10.10.205 to-address=10.10.10.205 type=bypassed
/ip hotspot ip-binding add disabled=yes mac-address=7C:D6:61:57:BD:57 type=blocked
/ip hotspot ip-binding add disabled=yes mac-address=72:AB:16:7D:6D:5E type=blocked
/ip hotspot ip-binding add disabled=yes mac-address=4C:ED:FB:21:8D:52 server=hs-MASTER type=blocked
/ip hotspot ip-binding add address=10.10.10.206 to-address=10.10.10.206 type=bypassed
/ip hotspot ip-binding add address=10.10.10.207 comment="ACCESS CONTROL" to-address=10.10.10.207 type=bypassed
/ip hotspot ip-binding add address=10.10.10.208 to-address=10.10.10.208 type=bypassed
/ip hotspot ip-binding add address=10.10.10.220 comment="LINUX GENIEACS" to-address=10.10.10.220 type=bypassed
/ip hotspot ip-binding add address=10.10.10.221 comment="LINUX GENIEACS" to-address=10.10.10.221 type=bypassed
/ip hotspot ip-binding add address=10.10.10.230 comment="LINUX GENIEACS" to-address=10.10.10.230 type=bypassed
/ip hotspot ip-binding add address=10.10.10.24 comment="AP UBIQUITI KULON" to-address=10.10.10.24 type=bypassed
/ip hotspot ip-binding add address=10.10.10.27 comment="AP UBIQUITI KULON" to-address=10.10.10.27 type=bypassed
/ip hotspot ip-binding add address=10.10.10.28 comment=PIHOLE to-address=10.10.10.28 type=bypassed
/ip hotspot ip-binding add address=10.10.10.29 comment="SERVER PROXMOX PAK RYAN" to-address=10.10.10.29 type=bypassed
/ip hotspot ip-binding add address=10.10.10.30 comment="AGENT BOS" to-address=10.10.10.30 type=bypassed
/ip hotspot ip-binding add address=10.10.10.31 comment="AGENT RYAN" to-address=10.10.10.31 type=bypassed
/ip hotspot user add name=admin password=k34Nu335577
/ip hotspot user add disabled=yes name=zaenal password=z@3nal&888
/ip hotspot user add name=arif password="arif\$111" profile=KONTRAKAN
/ip hotspot user add name=bintang password="bintang\$3388" profile=BINTANG
/ip hotspot user add disabled=yes name=TEKRALEBARAN password=TEKRALEBARAN profile=lebaran
/ip hotspot user add name=resti password="Resti\$111" profile=KONTRAKAN
/ip hotspot user add name=abah password=abah123 profile="1BULAN 1ORANG"
/ip hotspot user add disabled=yes name=salman password=salman,123 profile=KONTRAKAN
/ip hotspot user add name=mia password="mia\$111" profile="1BULAN 1ORANG"
/ip hotspot user add disabled=yes name=nicky password=khenzo888 profile="EDI JAELANI"
/ip hotspot user add disabled=yes name=iiparti password="qilla\$888" profile=ENDA
/ip hotspot user add name=zidan password="zidan\$888" profile=ENDA
/ip hotspot user add disabled=yes name=3nde password="3nde\$357" profile=KONTRAKAN
/ip hotspot user add name=server password=k34Nu335577
/ip hotspot user add name=ebih password=jadinaonwe profile="1BULAN 1ORANG"
/ip hotspot user add name=sansan password="sansan\$888" profile=KONTRAKAN
/ip hotspot user add name=test password=test
/ip hotspot user add name=susi password=deras123 profile="1BULAN 1ORANG"
/ip hotspot user add disabled=yes name=oseng password="o\$3ng888" profile=KONTRAKAN
/ip hotspot user add name="it3p\$333" profile=KONTRAKAN
/ip hotspot user add comment=vc- name=itep password=itep
/ip hotspot user add name=cecep password="c3cep\$555" profile=KONTRAKAN
/ip hotspot user add disabled=yes name=istanajaya password="istanajaya\$888" profile=istanajaya
/ip hotspot user add name=pc password=pc profile="1BULAN 1ORANG"
/ip hotspot user add name=ruli password="ruli\$888" profile="1BULAN 1ORANG"
/ip hotspot user add name=nunung password="nunung\$888" profile=KONTRAKAN
/ip hotspot user add name=imamsupriyanto password="imam\$111" profile="EDI JAELANI"
/ip hotspot user add disabled=yes name=ridwan password="ridwan\$123" profile=pipin
/ip hotspot user add disabled=yes name=asul password=asul&888 profile="1BULAN 1ORANG"
/ip hotspot user add name=yofi password=k34Nu335577
/ip hotspot user add disabled=yes name=mukhlis password=mukhlis999 profile=BINTANG
/ip hotspot user add name=deni password="deni\$123" profile="1BULAN 1ORANG"
/ip hotspot user add disabled=yes name=lery password="lery\$998" profile=LERI
/ip hotspot user add name=user1 password=user profile="1BULAN 1ORANG"
/ip hotspot user add name=dini password=867dini profile="1BULAN 1ORANG"
/ip hotspot user add disabled=yes name=david password="david\$111" profile=KONTRAKAN
/ip hotspot user add name=nenden password="sandi\$888" profile="1BULAN 1ORANG"
/ip hotspot user add name=tata password="tata\$888" profile=KONTRAKAN
/ip hotspot user add name=edi password="edi\$888" profile="1BULAN 1ORANG"
/ip hotspot user add name=khenzo password="khenzo\$888" profile="1BULAN 1ORANG"
/ip hotspot user add name=888ipenk password=888ipenk profile=KONTRAKAN
/ip hotspot user add name=837stb password=837stb profile=LERI
/ip hotspot user add disabled=yes name=1444h password=1444h profile=lebaran
/ip hotspot user add name=pipin password="pipin\$111" profile=KONTRAKAN
/ip hotspot user add disabled=yes name=lery2 password=lery2 profile="EDI JAELANI"
/ip hotspot user add name=UBUK password=UBUK profile=KONTRAKAN
/ip hotspot user add name=DOMBA password=DOMBA profile="1BULAN 1ORANG"
/ip hotspot user add disabled=yes name=15panitia password=15panitia profile=lebaran server=hs-MASTER
/ip hotspot user add name=1nara password="1nara\$888" profile="1BULAN 1ORANG"
/ip hotspot user add name=iyong password="iyong\$888" profile=KONTRAKAN
/ip hotspot user add name=wina password=wina123 profile="1BULAN 1ORANG"
/ip hotspot user add name=andri password="888\$andri" profile=KONTRAKAN
/ip hotspot user add comment=vc- name=ATa5mgbuza password=ATa5mgbuza profile=V-2000
/ip hotspot user add comment=vc- name=ATjdtquexb password=ATjdtquexb profile=V-2000
/ip hotspot user add comment=vc- name=ATgp2lqpms password=ATgp2lqpms profile=V-2000
/ip hotspot user add comment=vc- name=ATxp2y9qr8 password=ATxp2y9qr8 profile=V-2000
/ip hotspot user add disabled=yes name=maryani password=maryani12345 profile="1BULAN 1ORANG"
/ip hotspot user add name=INDRI password="indri\$888" profile="1BULAN 1ORANG"
/ip hotspot user add name=DEVI password=12345devi profile="1BULAN 1ORANG"
/ip hotspot user add comment=vc- name=AT0j8f1m1w password=AT0j8f1m1w profile=V-2000
/ip hotspot user add comment=vc-516-01.02.25- limit-uptime=6h name=3zh32 password=3zh32 profile=Paket6jam
/ip hotspot user add comment=vc-516-01.02.25- limit-uptime=6h name=3ft39 password=3ft39 profile=Paket6jam
/ip hotspot user add comment=vc-516-01.02.25- limit-uptime=6h name=3zx97 password=3zx97 profile=Paket6jam
/ip hotspot user add comment=vc-516-01.02.25- limit-uptime=6h name=3uu47 password=3uu47 profile=Paket6jam
/ip hotspot user add comment=vc-516-01.02.25- limit-uptime=6h name=3fx37 password=3fx37 profile=Paket6jam
/ip hotspot user add comment=vc-516-01.02.25- limit-uptime=6h name=3tg98 password=3tg98 profile=Paket6jam
/ip hotspot user add comment=vc-516-01.02.25- limit-uptime=6h name=3jy36 password=3jy36 profile=Paket6jam
/ip hotspot user add comment=vc-516-01.02.25- limit-uptime=6h name=3yh95 password=3yh95 profile=Paket6jam
/ip hotspot user add comment=vc-516-01.02.25- limit-uptime=6h name=3hy76 password=3hy76 profile=Paket6jam
/ip hotspot user add comment=vc-516-01.02.25- limit-uptime=6h name=3zb87 password=3zb87 profile=Paket6jam
/ip hotspot user add comment=vc-516-01.02.25- limit-uptime=6h name=3ku52 password=3ku52 profile=Paket6jam
/ip hotspot user add comment=vc-516-01.02.25- limit-uptime=6h name=3sa97 password=3sa97 profile=Paket6jam
/ip hotspot user add comment="Rohman abdurochiman-250105132628" name=ROHMAN password=888rohman profile=KONTRAKAN
/ip hotspot user add comment=vc- name=AT5yta34vh password=AT5yta34vh profile=V-3500
/ip hotspot user add comment=vc- name=ATfifwe3i5 password=ATfifwe3i5 profile=V-6000
/ip hotspot user add comment=vc-912-01.09.25- limit-uptime=2h name=2tu45 password=2tu45 profile=Paket2jam
/ip hotspot user add comment=vc-912-01.09.25- limit-uptime=2h name=2zx79 password=2zx79 profile=Paket2jam
/ip hotspot user add comment=vc-912-01.09.25- limit-uptime=2h name=2rn73 password=2rn73 profile=Paket2jam
/ip hotspot user add comment=vc-912-01.09.25- limit-uptime=2h name=2ef32 password=2ef32 profile=Paket2jam
/ip hotspot user add comment=vc-912-01.09.25- limit-uptime=2h name=2xm49 password=2xm49 profile=Paket2jam
/ip hotspot user add comment=vc-912-01.09.25- limit-uptime=2h name=2me63 password=2me63 profile=Paket2jam
/ip hotspot user add comment=vc-912-01.09.25- limit-uptime=2h name=2tm94 password=2tm94 profile=Paket2jam
/ip hotspot user add comment=vc-912-01.09.25- limit-uptime=2h name=2uv93 password=2uv93 profile=Paket2jam
/ip hotspot user add comment=vc-912-01.09.25- limit-uptime=2h name=2xf24 password=2xf24 profile=Paket2jam
/ip hotspot user add comment=vc-912-01.09.25- limit-uptime=2h name=2mv98 password=2mv98 profile=Paket2jam
/ip hotspot user add comment=vc-912-01.09.25- limit-uptime=2h name=2hb46 password=2hb46 profile=Paket2jam
/ip hotspot user add comment=vc-912-01.09.25- limit-uptime=2h name=2pp52 password=2pp52 profile=Paket2jam
/ip hotspot user add comment=vc-912-01.09.25- limit-uptime=2h name=2wi62 password=2wi62 profile=Paket2jam
/ip hotspot user add comment=vc-912-01.09.25- limit-uptime=2h name=2tk47 password=2tk47 profile=Paket2jam
/ip hotspot user add comment=vc-912-01.09.25- limit-uptime=2h name=2pr27 password=2pr27 profile=Paket2jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1ca82 password=1ca82 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1hz49 password=1hz49 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1mm58 password=1mm58 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1ux78 password=1ux78 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1yy44 password=1yy44 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1kk82 password=1kk82 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1yj44 password=1yj44 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1kx95 password=1kx95 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1xk39 password=1xk39 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1yb95 password=1yb95 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1hr92 password=1hr92 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1mc63 password=1mc63 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1ab96 password=1ab96 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1bj48 password=1bj48 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1en42 password=1en42 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1xx28 password=1xx28 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1pt22 password=1pt22 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1ft44 password=1ft44 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1mt78 password=1mt78 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1bn57 password=1bn57 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1nx84 password=1nx84 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1ia55 password=1ia55 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1ji24 password=1ji24 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1mv33 password=1mv33 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1pi57 password=1pi57 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1ki89 password=1ki89 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1tc49 password=1tc49 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1vz96 password=1vz96 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1we46 password=1we46 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1cd93 password=1cd93 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1er47 password=1er47 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1sa37 password=1sa37 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1bd49 password=1bd49 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1ih73 password=1ih73 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1si32 password=1si32 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1zv38 password=1zv38 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1ay74 password=1ay74 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1kk56 password=1kk56 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1ji59 password=1ji59 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1sa55 password=1sa55 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1ve83 password=1ve83 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1yf76 password=1yf76 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1iu68 password=1iu68 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1xw26 password=1xw26 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1pt29 password=1pt29 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1ng79 password=1ng79 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1su89 password=1su89 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1dg69 password=1dg69 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1mv44 password=1mv44 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1ck42 password=1ck42 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1gg97 password=1gg97 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1fv29 password=1fv29 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1en98 password=1en98 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1sm38 password=1sm38 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1ct73 password=1ct73 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1bh38 password=1bh38 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1jj54 password=1jj54 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1mi84 password=1mi84 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1jn98 password=1jn98 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1ep76 password=1ep76 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1ps84 password=1ps84 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1vt46 password=1vt46 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1vd69 password=1vd69 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1ju24 password=1ju24 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1va35 password=1va35 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1ek45 password=1ek45 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1is38 password=1is38 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1yf72 password=1yf72 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1zv98 password=1zv98 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1yd37 password=1yd37 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1fi42 password=1fi42 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1wz44 password=1wz44 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1di37 password=1di37 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1ud42 password=1ud42 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1mi82 password=1mi82 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1ym24 password=1ym24 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1te28 password=1te28 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1bb42 password=1bb42 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1gu76 password=1gu76 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1cw94 password=1cw94 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1tn35 password=1tn35 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1nb89 password=1nb89 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1kx38 password=1kx38 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1uw59 password=1uw59 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1er73 password=1er73 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1wg36 password=1wg36 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1mh92 password=1mh92 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1mt33 password=1mt33 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1gv55 password=1gv55 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1fy44 password=1fy44 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1rn42 password=1rn42 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1dm59 password=1dm59 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1iy26 password=1iy26 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1rr97 password=1rr97 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1hu36 password=1hu36 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1hz36 password=1hz36 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1en44 password=1en44 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1ke74 password=1ke74 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1fj34 password=1fj34 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1ta23 password=1ta23 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1hh69 password=1hh69 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1vx92 password=1vx92 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1vx27 password=1vx27 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1fb29 password=1fb29 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1gj36 password=1gj36 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1vu45 password=1vu45 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1vp36 password=1vp36 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1dz63 password=1dz63 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1ew68 password=1ew68 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1jv47 password=1jv47 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1ve66 password=1ve66 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1wi73 password=1wi73 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1gg29 password=1gg29 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1ud29 password=1ud29 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1ms47 password=1ms47 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1uk83 password=1uk83 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1jz62 password=1jz62 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1hg45 password=1hg45 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1vg88 password=1vg88 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1xv92 password=1xv92 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1mf76 password=1mf76 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1gc97 password=1gc97 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1dw98 password=1dw98 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1nt28 password=1nt28 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1bs54 password=1bs54 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1kb97 password=1kb97 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1sf53 password=1sf53 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1xn42 password=1xn42 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1jk64 password=1jk64 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1ab36 password=1ab36 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1dy93 password=1dy93 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1gc78 password=1gc78 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1hv93 password=1hv93 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1ic49 password=1ic49 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1uc48 password=1uc48 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1yg42 password=1yg42 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1zx92 password=1zx92 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1iy27 password=1iy27 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1ej28 password=1ej28 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1ce84 password=1ce84 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1ii68 password=1ii68 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1wb95 password=1wb95 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1cc26 password=1cc26 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1fi88 password=1fi88 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1pp95 password=1pp95 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1ud85 password=1ud85 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1ct53 password=1ct53 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1uz57 password=1uz57 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1cc93 password=1cc93 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1bw88 password=1bw88 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1da29 password=1da29 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1su83 password=1su83 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1mf95 password=1mf95 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1za56 password=1za56 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1jy28 password=1jy28 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1zc42 password=1zc42 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1mt23 password=1mt23 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1vi99 password=1vi99 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1ut44 password=1ut44 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1pw92 password=1pw92 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1nv68 password=1nv68 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1ky22 password=1ky22 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1ia42 password=1ia42 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1nb32 password=1nb32 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1ik28 password=1ik28 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1rj97 password=1rj97 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1cc98 password=1cc98 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1bp35 password=1bp35 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1ej22 password=1ej22 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1nc59 password=1nc59 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1if57 password=1if57 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1hi52 password=1hi52 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1je75 password=1je75 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1sm93 password=1sm93 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1hd44 password=1hd44 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1wv25 password=1wv25 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1yu22 password=1yu22 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1be78 password=1be78 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1mc83 password=1mc83 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1sf44 password=1sf44 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1pu38 password=1pu38 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1bu76 password=1bu76 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1ky49 password=1ky49 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1hg39 password=1hg39 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1uh78 password=1uh78 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1tw23 password=1tw23 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1xf72 password=1xf72 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1te73 password=1te73 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1hm36 password=1hm36 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1cd69 password=1cd69 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1hz28 password=1hz28 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1ha77 password=1ha77 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1md99 password=1md99 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1pk34 password=1pk34 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1as38 password=1as38 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1wc57 password=1wc57 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1yx97 password=1yx97 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1xk26 password=1xk26 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1nf83 password=1nf83 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1aj43 password=1aj43 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1zw44 password=1zw44 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1xz78 password=1xz78 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1ui45 password=1ui45 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1va37 password=1va37 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1dn38 password=1dn38 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1rv34 password=1rv34 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1nn97 password=1nn97 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1bd52 password=1bd52 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1xi26 password=1xi26 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1gv98 password=1gv98 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1dd99 password=1dd99 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1uf93 password=1uf93 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1tf27 password=1tf27 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1xe45 password=1xe45 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1mr94 password=1mr94 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1bk68 password=1bk68 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1vw55 password=1vw55 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1dn29 password=1dn29 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1ki26 password=1ki26 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1ne58 password=1ne58 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1ii23 password=1ii23 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1sy98 password=1sy98 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1ss84 password=1ss84 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1mp58 password=1mp58 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1pm57 password=1pm57 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1wf96 password=1wf96 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1hm54 password=1hm54 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1ev77 password=1ev77 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1xk87 password=1xk87 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1bn22 password=1bn22 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1ay95 password=1ay95 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1fe89 password=1fe89 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1mg94 password=1mg94 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1bd47 password=1bd47 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1kf32 password=1kf32 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1ap28 password=1ap28 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1st43 password=1st43 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1cj46 password=1cj46 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1kx44 password=1kx44 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1px37 password=1px37 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1wy55 password=1wy55 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1em28 password=1em28 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1gi84 password=1gi84 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1fh66 password=1fh66 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1nt42 password=1nt42 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1yp73 password=1yp73 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1zj28 password=1zj28 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1ew49 password=1ew49 profile=Paket-1-jam
/ip hotspot user add comment=vc-551-01.09.25- limit-uptime=1h name=1py72 password=1py72 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1vd24 password=1vd24 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1ye92 password=1ye92 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1js52 password=1js52 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1we99 password=1we99 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1jy45 password=1jy45 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1ug35 password=1ug35 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1rc55 password=1rc55 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1fu76 password=1fu76 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1df25 password=1df25 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1zi43 password=1zi43 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1pi72 password=1pi72 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1gv25 password=1gv25 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1rb83 password=1rb83 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1vh72 password=1vh72 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1cy96 password=1cy96 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1nx44 password=1nx44 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1ps42 password=1ps42 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1iz44 password=1iz44 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1np57 password=1np57 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1ug46 password=1ug46 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1xa28 password=1xa28 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1md29 password=1md29 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1aw92 password=1aw92 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1pv42 password=1pv42 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1jt43 password=1jt43 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1pf59 password=1pf59 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1yj65 password=1yj65 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1gj35 password=1gj35 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1jp48 password=1jp48 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1cj55 password=1cj55 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1wi27 password=1wi27 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1fn43 password=1fn43 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1mp27 password=1mp27 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1dm32 password=1dm32 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1yt89 password=1yt89 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1cc28 password=1cc28 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1tg44 password=1tg44 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1cs56 password=1cs56 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1fw33 password=1fw33 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1gc72 password=1gc72 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1uj27 password=1uj27 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1sv47 password=1sv47 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1ty75 password=1ty75 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1mg47 password=1mg47 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1hg96 password=1hg96 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1ee32 password=1ee32 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1ty96 password=1ty96 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1vw38 password=1vw38 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1sj74 password=1sj74 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1nd94 password=1nd94 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1cc63 password=1cc63 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1sg27 password=1sg27 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1uz29 password=1uz29 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1bj59 password=1bj59 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1gx45 password=1gx45 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1kh27 password=1kh27 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1ap98 password=1ap98 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1nd67 password=1nd67 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1ex78 password=1ex78 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1de54 password=1de54 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1sp79 password=1sp79 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1jh92 password=1jh92 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1gz57 password=1gz57 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1xg23 password=1xg23 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1kz59 password=1kz59 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1vw48 password=1vw48 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1et42 password=1et42 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1wc97 password=1wc97 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1gy98 password=1gy98 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1iw47 password=1iw47 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1ef27 password=1ef27 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1eu96 password=1eu96 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1nk39 password=1nk39 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1ge83 password=1ge83 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1gj76 password=1gj76 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1ee86 password=1ee86 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1ia95 password=1ia95 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1xw35 password=1xw35 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1fd53 password=1fd53 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1tb24 password=1tb24 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1ag69 password=1ag69 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1ui78 password=1ui78 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1kk53 password=1kk53 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1wu33 password=1wu33 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1sy37 password=1sy37 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1hw85 password=1hw85 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1wd93 password=1wd93 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1fa73 password=1fa73 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1ix94 password=1ix94 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1fh46 password=1fh46 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1pa32 password=1pa32 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1yb44 password=1yb44 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1et97 password=1et97 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1nk86 password=1nk86 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1bc38 password=1bc38 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1va29 password=1va29 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1vy39 password=1vy39 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1zm24 password=1zm24 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1jz44 password=1jz44 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1tc73 password=1tc73 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1ra75 password=1ra75 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1xg88 password=1xg88 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1jt79 password=1jt79 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1ax46 password=1ax46 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1jn46 password=1jn46 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1sx48 password=1sx48 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1gf44 password=1gf44 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1ym23 password=1ym23 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1at36 password=1at36 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1tw97 password=1tw97 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1aj53 password=1aj53 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1uj35 password=1uj35 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1va75 password=1va75 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1fy98 password=1fy98 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1se82 password=1se82 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1kh54 password=1kh54 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1yj66 password=1yj66 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1ju32 password=1ju32 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1dt78 password=1dt78 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1sz85 password=1sz85 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1rc53 password=1rc53 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1ff57 password=1ff57 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1yf36 password=1yf36 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1jp42 password=1jp42 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1jh26 password=1jh26 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1pk24 password=1pk24 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1rk42 password=1rk42 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1bu47 password=1bu47 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1fn73 password=1fn73 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1hu85 password=1hu85 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1we35 password=1we35 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1tw75 password=1tw75 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1tv76 password=1tv76 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1ui87 password=1ui87 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1mz45 password=1mz45 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1ja22 password=1ja22 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1xk96 password=1xk96 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1ki39 password=1ki39 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1it54 password=1it54 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1jn93 password=1jn93 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1um72 password=1um72 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1px38 password=1px38 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1zj98 password=1zj98 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1nj73 password=1nj73 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1er76 password=1er76 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1ad49 password=1ad49 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1ae49 password=1ae49 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1ez58 password=1ez58 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1ep98 password=1ep98 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1ms48 password=1ms48 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1up96 password=1up96 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1ik84 password=1ik84 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1jn55 password=1jn55 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1vc57 password=1vc57 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1uk84 password=1uk84 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1ed93 password=1ed93 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1jg79 password=1jg79 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1hd97 password=1hd97 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1dy45 password=1dy45 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1dt35 password=1dt35 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1ds86 password=1ds86 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1pa43 password=1pa43 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1if33 password=1if33 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1tj53 password=1tj53 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1tt25 password=1tt25 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1jj93 password=1jj93 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1bi86 password=1bi86 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1ty65 password=1ty65 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1cd27 password=1cd27 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1xe99 password=1xe99 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1bb32 password=1bb32 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1wc96 password=1wc96 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1tu25 password=1tu25 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1dk94 password=1dk94 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1rd29 password=1rd29 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1pf45 password=1pf45 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1us92 password=1us92 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1sx34 password=1sx34 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1fp99 password=1fp99 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1dd22 password=1dd22 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1yc25 password=1yc25 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1wi43 password=1wi43 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1mb22 password=1mb22 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1zn97 password=1zn97 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1rz45 password=1rz45 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1xg92 password=1xg92 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1ae43 password=1ae43 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1ti76 password=1ti76 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1rf25 password=1rf25 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1vk25 password=1vk25 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1pj56 password=1pj56 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1ry65 password=1ry65 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1fb52 password=1fb52 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1kn24 password=1kn24 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1py28 password=1py28 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1mm56 password=1mm56 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1hn47 password=1hn47 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1sy82 password=1sy82 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1re37 password=1re37 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1yu52 password=1yu52 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1au57 password=1au57 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1pu45 password=1pu45 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1te27 password=1te27 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1ac36 password=1ac36 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1vd45 password=1vd45 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1fk55 password=1fk55 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1ky33 password=1ky33 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1yb67 password=1yb67 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1is76 password=1is76 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1sz42 password=1sz42 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1es72 password=1es72 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1jn64 password=1jn64 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1nj89 password=1nj89 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1mf55 password=1mf55 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1ba97 password=1ba97 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1nf49 password=1nf49 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1jg49 password=1jg49 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1bp23 password=1bp23 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1yi95 password=1yi95 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1ey84 password=1ey84 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1zf94 password=1zf94 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1ru72 password=1ru72 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1ux36 password=1ux36 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1hs88 password=1hs88 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1em55 password=1em55 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1ng23 password=1ng23 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1bk84 password=1bk84 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1vc86 password=1vc86 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1wg26 password=1wg26 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1wp34 password=1wp34 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1yf49 password=1yf49 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1cu92 password=1cu92 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1tx23 password=1tx23 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1en54 password=1en54 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1kh95 password=1kh95 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1bm35 password=1bm35 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1pt46 password=1pt46 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1zx24 password=1zx24 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1cy45 password=1cy45 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1uh28 password=1uh28 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1kt32 password=1kt32 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1xe57 password=1xe57 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1de94 password=1de94 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1nv46 password=1nv46 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1vs45 password=1vs45 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1py59 password=1py59 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1hk34 password=1hk34 profile=Paket-1-jam
/ip hotspot user add comment=vc-523-01.25.25- limit-uptime=1h name=1ka79 password=1ka79 profile=Paket-1-jam
/ip hotspot user add comment=vc-609-01.27.25- limit-uptime=6h name=6jx67 password=6jx67 profile=Paket6jam
/ip hotspot user add comment=vc-609-01.27.25- limit-uptime=6h name=667kv password=667kv profile=Paket6jam
/ip hotspot user add comment=vc-609-01.27.25- limit-uptime=6h name=6rm33 password=6rm33 profile=Paket6jam
/ip hotspot user add comment=vc-609-01.27.25- limit-uptime=6h name=6hkkz password=6hkkz profile=Paket6jam
/ip hotspot user add comment=vc-609-01.27.25- limit-uptime=6h name=6geja password=6geja profile=Paket6jam
/ip hotspot user add comment=vc-609-01.27.25- limit-uptime=6h name=68ybf password=68ybf profile=Paket6jam
/ip hotspot user add comment=vc-609-01.27.25- limit-uptime=6h name=6fvj3 password=6fvj3 profile=Paket6jam
/ip hotspot user add comment=vc-609-01.27.25- limit-uptime=6h name=6sntr password=6sntr profile=Paket6jam
/ip hotspot user add comment=vc-609-01.27.25- limit-uptime=6h name=6ybng password=6ybng profile=Paket6jam
/ip hotspot user add comment=vc-609-01.27.25- limit-uptime=6h name=6t5ve password=6t5ve profile=Paket6jam
/ip hotspot user add comment=vc-609-01.27.25- limit-uptime=6h name=6s856 password=6s856 profile=Paket6jam
/ip hotspot user add comment=vc-609-01.27.25- limit-uptime=6h name=6t7fb password=6t7fb profile=Paket6jam
/ip hotspot user add comment=vc-609-01.27.25- limit-uptime=6h name=6tpwb password=6tpwb profile=Paket6jam
/ip hotspot user add comment=vc-609-01.27.25- limit-uptime=6h name=65mij password=65mij profile=Paket6jam
/ip hotspot user add comment=vc-609-01.27.25- limit-uptime=6h name=6p5pg password=6p5pg profile=Paket6jam
/ip hotspot user add comment=vc-609-01.27.25- limit-uptime=6h name=6e7iw password=6e7iw profile=Paket6jam
/ip hotspot user add comment=vc-609-01.27.25- limit-uptime=6h name=6cwcm password=6cwcm profile=Paket6jam
/ip hotspot user add comment=vc-609-01.27.25- limit-uptime=6h name=6ay6r password=6ay6r profile=Paket6jam
/ip hotspot user add comment=vc-609-01.27.25- limit-uptime=6h name=6mzhf password=6mzhf profile=Paket6jam
/ip hotspot user add comment=vc-701-01.31.25- limit-uptime=2h name=2ds38 password=2ds38 profile=Paket2jam
/ip hotspot user add comment=vc-701-01.31.25- limit-uptime=2h name=2iz33 password=2iz33 profile=Paket2jam
/ip hotspot user add comment=vc-701-01.31.25- limit-uptime=2h name=2us36 password=2us36 profile=Paket2jam
/ip hotspot user add comment=vc-701-01.31.25- limit-uptime=2h name=2pk38 password=2pk38 profile=Paket2jam
/ip hotspot user add comment=vc-701-01.31.25- limit-uptime=2h name=2fp84 password=2fp84 profile=Paket2jam
/ip hotspot user add comment=vc-701-01.31.25- limit-uptime=2h name=2pw52 password=2pw52 profile=Paket2jam
/ip hotspot user add comment=vc-701-01.31.25- limit-uptime=2h name=2mb36 password=2mb36 profile=Paket2jam
/ip hotspot user add comment=vc-701-01.31.25- limit-uptime=2h name=2vb52 password=2vb52 profile=Paket2jam
/ip hotspot user add comment=vc-701-01.31.25- limit-uptime=2h name=2ax98 password=2ax98 profile=Paket2jam
/ip hotspot user add comment=vc-701-01.31.25- limit-uptime=2h name=2xy87 password=2xy87 profile=Paket2jam
/ip hotspot user add comment=vc-701-01.31.25- limit-uptime=2h name=2jc87 password=2jc87 profile=Paket2jam
/ip hotspot user add comment=vc-701-01.31.25- limit-uptime=2h name=2sf99 password=2sf99 profile=Paket2jam
/ip hotspot user add comment=vc-701-01.31.25- limit-uptime=2h name=2xj62 password=2xj62 profile=Paket2jam
/ip hotspot user add comment=vc-701-01.31.25- limit-uptime=2h name=2ks76 password=2ks76 profile=Paket2jam
/ip hotspot user add comment=vc-863-01.31.25- limit-uptime=1h name=1zw76 password=1zw76 profile=Paket-1-jam
/ip hotspot user add comment=vc-863-01.31.25- limit-uptime=1h name=1db46 password=1db46 profile=Paket-1-jam
/ip hotspot user add comment=vc-863-01.31.25- limit-uptime=1h name=1xh92 password=1xh92 profile=Paket-1-jam
/ip hotspot user add comment=vc-863-01.31.25- limit-uptime=1h name=1em69 password=1em69 profile=Paket-1-jam
/ip hotspot user add comment=vc-863-01.31.25- limit-uptime=1h name=1td99 password=1td99 profile=Paket-1-jam
/ip hotspot user add comment=vc-863-01.31.25- limit-uptime=1h name=1sn23 password=1sn23 profile=Paket-1-jam
/ip hotspot user add comment=vc-863-01.31.25- limit-uptime=1h name=1ik39 password=1ik39 profile=Paket-1-jam
/ip hotspot user add comment=vc-863-01.31.25- limit-uptime=1h name=1ht66 password=1ht66 profile=Paket-1-jam
/ip hotspot user add comment=vc-863-01.31.25- limit-uptime=1h name=1fy62 password=1fy62 profile=Paket-1-jam
/ip hotspot user add comment=vc-863-01.31.25- limit-uptime=1h name=1rj99 password=1rj99 profile=Paket-1-jam
/ip hotspot user add comment=vc-863-01.31.25- limit-uptime=1h name=1zj37 password=1zj37 profile=Paket-1-jam
/ip hotspot user add name=888qipin password=888qipin profile="1BULAN 1ORANG"
/ip hotspot user add disabled=yes name=indri password=indri12345 profile="1BULAN 1ORANG"
/ip hotspot user add disabled=yes name=iki password=iki12345 profile="1BULAN 1ORANG"
/ip hotspot user add disabled=yes name=sela password=sela12345 profile="1BULAN 1ORANG"
/ip hotspot user add comment="NENG DEDAH-250205093832" name=DEDAH password="888\$dedah" profile="1BULAN 1ORANG"
/ip hotspot user add comment="SHIVA NURAISYAH-250205130133" disabled=yes name=SHIVA password="186\$shiva" profile="1BULAN 1ORANG"
/ip hotspot user add name=KANTORRW password=KANTORRW profile=KONTRAKAN
/ip hotspot user add disabled=yes name=ADIBIL password=ADIBIL profile=ADIBIL
/ip hotspot user add comment=vc-755-02.11.25- limit-uptime=6h name=3iy25 password=3iy25 profile=Paket6jam
/ip hotspot user add comment=vc-755-02.11.25- limit-uptime=6h name=3is62 password=3is62 profile=Paket6jam
/ip hotspot user add comment=vc-755-02.11.25- limit-uptime=6h name=3gu93 password=3gu93 profile=Paket6jam
/ip hotspot user add comment=vc-755-02.11.25- limit-uptime=6h name=3ch98 password=3ch98 profile=Paket6jam
/ip hotspot user add comment=vc-755-02.11.25- limit-uptime=6h name=3fy87 password=3fy87 profile=Paket6jam
/ip hotspot user add comment=vc-755-02.11.25- limit-uptime=6h name=3da37 password=3da37 profile=Paket6jam
/ip hotspot user add comment=vc-755-02.11.25- limit-uptime=6h name=3yn32 password=3yn32 profile=Paket6jam
/ip hotspot user add comment=vc-755-02.11.25- limit-uptime=6h name=3zd74 password=3zd74 profile=Paket6jam
/ip hotspot user add comment=vc-755-02.11.25- limit-uptime=6h name=3wv95 password=3wv95 profile=Paket6jam
/ip hotspot user add comment=vc-755-02.11.25- limit-uptime=6h name=3gg92 password=3gg92 profile=Paket6jam
/ip hotspot user add comment=vc-755-02.11.25- limit-uptime=6h name=3jn92 password=3jn92 profile=Paket6jam
/ip hotspot user add comment=vc-755-02.11.25- limit-uptime=6h name=3ji23 password=3ji23 profile=Paket6jam
/ip hotspot user add name=FAHRUN password=FAHRUN profile="1BULAN 1ORANG" server=hs-MASTER
/ip hotspot user add name=isen password="isen\$888" profile="1BULAN 1ORANG"
/ip hotspot user add comment=up-987-02.28.25- limit-uptime=2h name=29y4h password=9297 profile=Paket2jam
/ip hotspot user add comment=up-987-02.28.25- limit-uptime=2h name=26twi password=5445 profile=Paket2jam
/ip hotspot user add comment=up-987-02.28.25- limit-uptime=2h name=2ykw8 password=8329 profile=Paket2jam
/ip hotspot user add comment=up-987-02.28.25- limit-uptime=2h name=28kdg password=5254 profile=Paket2jam
/ip hotspot user add comment=up-987-02.28.25- limit-uptime=2h name=2akkv password=7753 profile=Paket2jam
/ip hotspot user add comment=up-987-02.28.25- limit-uptime=2h name=2v2vu password=5997 profile=Paket2jam
/ip hotspot user add comment=up-987-02.28.25- limit-uptime=2h name=2fagh password=4559 profile=Paket2jam
/ip hotspot user add comment=up-987-02.28.25- limit-uptime=2h name=2rgsx password=6827 profile=Paket2jam
/ip hotspot user add comment=up-987-02.28.25- limit-uptime=2h name=23u45 password=5966 profile=Paket2jam
/ip hotspot user add comment=up-987-02.28.25- limit-uptime=2h name=2vjzu password=5456 profile=Paket2jam
/ip hotspot user add comment=up-987-02.28.25- limit-uptime=2h name=28y9a password=2994 profile=Paket2jam
/ip hotspot user add comment=up-987-02.28.25- limit-uptime=2h name=2ny28 password=2388 profile=Paket2jam
/ip hotspot user add comment=up-987-02.28.25- limit-uptime=2h name=22fib password=9779 profile=Paket2jam
/ip hotspot user add comment=up-987-02.28.25- limit-uptime=2h name=2vtnm password=4642 profile=Paket2jam
/ip hotspot user add comment=up-987-02.28.25- limit-uptime=2h name=2gw3v password=5455 profile=Paket2jam
/ip hotspot user add comment=up-987-02.28.25- limit-uptime=2h name=2wast password=7475 profile=Paket2jam
/ip hotspot user add comment=up-987-02.28.25- limit-uptime=2h name=22aes password=9334 profile=Paket2jam
/ip hotspot user add comment=up-987-02.28.25- limit-uptime=2h name=242xv password=9265 profile=Paket2jam
/ip hotspot user add comment=up-987-02.28.25- limit-uptime=2h name=25cpt password=7478 profile=Paket2jam
/ip hotspot user add comment=up-987-02.28.25- limit-uptime=2h name=27uwu password=2722 profile=Paket2jam
/ip hotspot user add comment=up-987-02.28.25- limit-uptime=2h name=2v6yj password=6632 profile=Paket2jam
/ip hotspot user add comment=up-987-02.28.25- limit-uptime=2h name=2i5ty password=5874 profile=Paket2jam
/ip hotspot user add comment=up-987-02.28.25- limit-uptime=2h name=244i5 password=5947 profile=Paket2jam
/ip hotspot user add comment=up-987-02.28.25- limit-uptime=2h name=2yc7z password=7234 profile=Paket2jam
/ip hotspot user add comment=up-987-02.28.25- limit-uptime=2h name=2r8jt password=5339 profile=Paket2jam
/ip hotspot user add comment=up-987-02.28.25- limit-uptime=2h name=26hm7 password=4383 profile=Paket2jam
/ip hotspot user add comment=up-987-02.28.25- limit-uptime=2h name=2zjms password=4365 profile=Paket2jam
/ip hotspot user add comment=up-987-02.28.25- limit-uptime=2h name=2cp9y password=4372 profile=Paket2jam
/ip hotspot user add comment=up-987-02.28.25- limit-uptime=2h name=2fykr password=2889 profile=Paket2jam
/ip hotspot user add comment=up-987-02.28.25- limit-uptime=2h name=2xkut password=8257 profile=Paket2jam
/ip hotspot user add comment=up-987-02.28.25- limit-uptime=2h name=2ufb4 password=8446 profile=Paket2jam
/ip hotspot user add comment=up-987-02.28.25- limit-uptime=2h name=25k9w password=5892 profile=Paket2jam
/ip hotspot user add comment=up-987-02.28.25- limit-uptime=2h name=2pw49 password=4929 profile=Paket2jam
/ip hotspot user add comment=up-987-02.28.25- limit-uptime=2h name=2kynr password=5965 profile=Paket2jam
/ip hotspot user add comment=up-987-02.28.25- limit-uptime=2h name=29nkx password=9674 profile=Paket2jam
/ip hotspot user add comment=up-987-02.28.25- limit-uptime=2h name=24ihi password=6324 profile=Paket2jam
/ip hotspot user add comment=up-987-02.28.25- limit-uptime=2h name=26mf4 password=7268 profile=Paket2jam
/ip hotspot user add comment=up-987-02.28.25- limit-uptime=2h name=2bzf4 password=6965 profile=Paket2jam
/ip hotspot user add comment=up-987-02.28.25- limit-uptime=2h name=2izxj password=6772 profile=Paket2jam
/ip hotspot user add comment=up-987-02.28.25- limit-uptime=2h name=2gddn password=6576 profile=Paket2jam
/ip hotspot user add comment=up-987-02.28.25- limit-uptime=2h name=2nfke password=5427 profile=Paket2jam
/ip hotspot user add comment=up-987-02.28.25- limit-uptime=2h name=2har4 password=9798 profile=Paket2jam
/ip hotspot user add comment=up-987-02.28.25- limit-uptime=2h name=2rswz password=8358 profile=Paket2jam
/ip hotspot user add comment=up-987-02.28.25- limit-uptime=2h name=2r2yg password=7647 profile=Paket2jam
/ip hotspot user add comment=up-987-02.28.25- limit-uptime=2h name=2mvkm password=7597 profile=Paket2jam
/ip hotspot user add comment=up-987-02.28.25- limit-uptime=2h name=23hzm password=6655 profile=Paket2jam
/ip hotspot user add disabled=yes name=aji password="aji\$888" profile="1BULAN 1ORANG"
/ip hotspot user add comment=vc-247-03.06.25- limit-uptime=6h name=6rexc password=6rexc profile=Paket6jam
/ip hotspot user add comment=vc-247-03.06.25- limit-uptime=6h name=6ccd4 password=6ccd4 profile=Paket6jam
/ip hotspot user add comment=vc-247-03.06.25- limit-uptime=6h name=6eg8h password=6eg8h profile=Paket6jam
/ip hotspot user add comment=vc-247-03.06.25- limit-uptime=6h name=6m4nt password=6m4nt profile=Paket6jam
/ip hotspot user add comment=vc-247-03.06.25- limit-uptime=6h name=66dkx password=66dkx profile=Paket6jam
/ip hotspot user add comment=vc-247-03.06.25- limit-uptime=6h name=6h566 password=6h566 profile=Paket6jam
/ip hotspot user add comment=vc-247-03.06.25- limit-uptime=6h name=6cfpe password=6cfpe profile=Paket6jam
/ip hotspot user add comment=vc-247-03.06.25- limit-uptime=6h name=65gyp password=65gyp profile=Paket6jam
/ip hotspot user add comment=vc-197-03.06.25- limit-uptime=1h name=19bzk password=19bzk profile=Paket-1-jam
/ip hotspot user add comment=vc-197-03.06.25- limit-uptime=1h name=1umff password=1umff profile=Paket-1-jam
/ip hotspot user add comment=vc-197-03.06.25- limit-uptime=1h name=1d42t password=1d42t profile=Paket-1-jam
/ip hotspot user add comment=vc-197-03.06.25- limit-uptime=1h name=1fj6k password=1fj6k profile=Paket-1-jam
/ip hotspot user add comment=vc-197-03.06.25- limit-uptime=1h name=1xihv password=1xihv profile=Paket-1-jam
/ip hotspot user add comment=vc-197-03.06.25- limit-uptime=1h name=16967 password=16967 profile=Paket-1-jam
/ip hotspot user add comment=vc-197-03.06.25- limit-uptime=1h name=18328 password=18328 profile=Paket-1-jam
/ip hotspot user add comment=vc-197-03.06.25- limit-uptime=1h name=1hyi2 password=1hyi2 profile=Paket-1-jam
/ip hotspot user add comment=vc-197-03.06.25- limit-uptime=1h name=1enee password=1enee profile=Paket-1-jam
/ip hotspot user add comment=vc-197-03.06.25- limit-uptime=1h name=1rgtv password=1rgtv profile=Paket-1-jam
/ip hotspot user add comment=vc-197-03.06.25- limit-uptime=1h name=1fkw5 password=1fkw5 profile=Paket-1-jam
/ip hotspot user add comment=vc-197-03.06.25- limit-uptime=1h name=1ifng password=1ifng profile=Paket-1-jam
/ip hotspot user add comment=vc-197-03.06.25- limit-uptime=1h name=15hh2 password=15hh2 profile=Paket-1-jam
/ip hotspot user add comment=vc-197-03.06.25- limit-uptime=1h name=1g2ix password=1g2ix profile=Paket-1-jam
/ip hotspot user add comment=vc-197-03.06.25- limit-uptime=1h name=1k4p6 password=1k4p6 profile=Paket-1-jam
/ip hotspot user add comment=vc-197-03.06.25- limit-uptime=1h name=1ykn2 password=1ykn2 profile=Paket-1-jam
/ip hotspot user add comment=vc-197-03.06.25- limit-uptime=1h name=1ehka password=1ehka profile=Paket-1-jam
/ip hotspot user add comment=vc-197-03.06.25- limit-uptime=1h name=1mp5z password=1mp5z profile=Paket-1-jam
/ip hotspot user add comment=vc-197-03.06.25- limit-uptime=1h name=1ux9a password=1ux9a profile=Paket-1-jam
/ip hotspot user add comment=vc-631-03.25.25- limit-uptime=2h name=2kx29 password=2kx29 profile=Paket2jam
/ip hotspot user add comment=vc-631-03.25.25- limit-uptime=2h name=2fi29 password=2fi29 profile=Paket2jam
/ip hotspot user add comment=vc-631-03.25.25- limit-uptime=2h name=2ev44 password=2ev44 profile=Paket2jam
/ip hotspot user add comment=vc-631-03.25.25- limit-uptime=2h name=2fr64 password=2fr64 profile=Paket2jam
/ip hotspot user add comment=vc-631-03.25.25- limit-uptime=2h name=2df63 password=2df63 profile=Paket2jam
/ip hotspot user add comment=vc-631-03.25.25- limit-uptime=2h name=2ye54 password=2ye54 profile=Paket2jam
/ip hotspot user add comment=vc-631-03.25.25- limit-uptime=2h name=2rk86 password=2rk86 profile=Paket2jam
/ip hotspot user add comment=vc-631-03.25.25- limit-uptime=2h name=2ug53 password=2ug53 profile=Paket2jam
/ip hotspot user add comment=vc-894-04.03.25- limit-uptime=6h name=6wzj6 password=6wzj6 profile=Paket6jam
/ip hotspot user add comment=vc-894-04.03.25- limit-uptime=6h name=6y9ac password=6y9ac profile=Paket6jam
/ip hotspot user add comment=vc-894-04.03.25- limit-uptime=6h name=6bdr2 password=6bdr2 profile=Paket6jam
/ip hotspot user add comment=vc-894-04.03.25- limit-uptime=6h name=6mc2h password=6mc2h profile=Paket6jam
/ip hotspot user add comment=vc-894-04.03.25- limit-uptime=6h name=6crzp password=6crzp profile=Paket6jam
/ip hotspot user add comment=vc-894-04.03.25- limit-uptime=6h name=69mrk password=69mrk profile=Paket6jam
/ip hotspot user add comment=vc-894-04.03.25- limit-uptime=6h name=6j2ef password=6j2ef profile=Paket6jam
/ip hotspot user add comment=vc-894-04.03.25- limit-uptime=6h name=6r77b password=6r77b profile=Paket6jam
/ip hotspot user add comment=vc-894-04.03.25- limit-uptime=6h name=6gaxg password=6gaxg profile=Paket6jam
/ip hotspot user add comment=vc-894-04.03.25- limit-uptime=6h name=6u22z password=6u22z profile=Paket6jam
/ip hotspot user add comment=vc-894-04.03.25- limit-uptime=6h name=6hcji password=6hcji profile=Paket6jam
/ip hotspot user add comment=vc-894-04.03.25- limit-uptime=6h name=67s24 password=67s24 profile=Paket6jam
/ip hotspot user add comment=vc-894-04.03.25- limit-uptime=6h name=6yzwv password=6yzwv profile=Paket6jam
/ip hotspot user add comment=vc-894-04.03.25- limit-uptime=6h name=6j5ji password=6j5ji profile=Paket6jam
/ip hotspot user add comment=vc-894-04.03.25- limit-uptime=6h name=6jm3t password=6jm3t profile=Paket6jam
/ip hotspot user add comment=vc-894-04.03.25- limit-uptime=6h name=63wiu password=63wiu profile=Paket6jam
/ip hotspot user add comment=vc-894-04.03.25- limit-uptime=6h name=66wk4 password=66wk4 profile=Paket6jam
/ip hotspot user add comment=vc-894-04.03.25- limit-uptime=6h name=66kbb password=66kbb profile=Paket6jam
/ip hotspot user add comment=vc-894-04.03.25- limit-uptime=6h name=6k7n6 password=6k7n6 profile=Paket6jam
/ip hotspot user add comment=vc-894-04.03.25- limit-uptime=6h name=6jukn password=6jukn profile=Paket6jam
/ip hotspot user add comment=vc-894-04.03.25- limit-uptime=6h name=6ujpn password=6ujpn profile=Paket6jam
/ip hotspot user add comment=vc-894-04.03.25- limit-uptime=6h name=6tb4r password=6tb4r profile=Paket6jam
/ip hotspot user add comment=vc-894-04.03.25- limit-uptime=6h name=69w28 password=69w28 profile=Paket6jam
/ip hotspot user add comment=vc-133-04.03.25- limit-uptime=1h name=1jb59 password=1jb59 profile=Paket-1-jam
/ip hotspot user add comment=vc-133-04.03.25- limit-uptime=1h name=1vvtm password=1vvtm profile=Paket-1-jam
/ip hotspot user add comment=vc-133-04.03.25- limit-uptime=1h name=1isd7 password=1isd7 profile=Paket-1-jam
/ip hotspot user add comment=vc-133-04.03.25- limit-uptime=1h name=16gmi password=16gmi profile=Paket-1-jam
/ip hotspot user add comment=vc-133-04.03.25- limit-uptime=1h name=19f6b password=19f6b profile=Paket-1-jam
/ip hotspot user add comment=vc-133-04.03.25- limit-uptime=1h name=12mmy password=12mmy profile=Paket-1-jam
/ip hotspot user add comment=vc-133-04.03.25- limit-uptime=1h name=1m48a password=1m48a profile=Paket-1-jam
/ip hotspot user add comment=vc-133-04.03.25- limit-uptime=1h name=1v3zv password=1v3zv profile=Paket-1-jam
/ip hotspot user add comment=vc-133-04.03.25- limit-uptime=1h name=1rbit password=1rbit profile=Paket-1-jam
/ip hotspot user add comment=vc-133-04.03.25- limit-uptime=1h name=1magr password=1magr profile=Paket-1-jam
/ip hotspot user add comment=vc-133-04.03.25- limit-uptime=1h name=1ftbh password=1ftbh profile=Paket-1-jam
/ip hotspot user add comment=vc-133-04.03.25- limit-uptime=1h name=1zmb2 password=1zmb2 profile=Paket-1-jam
/ip hotspot user add comment=vc-133-04.03.25- limit-uptime=1h name=1nrku password=1nrku profile=Paket-1-jam
/ip hotspot user add comment=vc-133-04.03.25- limit-uptime=1h name=1jx6y password=1jx6y profile=Paket-1-jam
/ip hotspot user add comment=vc-133-04.03.25- limit-uptime=1h name=1e9mv password=1e9mv profile=Paket-1-jam
/ip hotspot user add comment=vc-133-04.03.25- limit-uptime=1h name=1f9zv password=1f9zv profile=Paket-1-jam
/ip hotspot user add comment=vc-133-04.03.25- limit-uptime=1h name=1uzhs password=1uzhs profile=Paket-1-jam
/ip hotspot user add comment=vc-133-04.03.25- limit-uptime=1h name=1srvn password=1srvn profile=Paket-1-jam
/ip hotspot user add comment=vc-133-04.03.25- limit-uptime=1h name=1h2bv password=1h2bv profile=Paket-1-jam
/ip hotspot user add comment=vc-133-04.03.25- limit-uptime=1h name=1vw9i password=1vw9i profile=Paket-1-jam
/ip hotspot user add comment=vc-133-04.03.25- limit-uptime=1h name=145k6 password=145k6 profile=Paket-1-jam
/ip hotspot user add comment=vc-133-04.03.25- limit-uptime=1h name=1aayg password=1aayg profile=Paket-1-jam
/ip hotspot user add comment=vc-133-04.03.25- limit-uptime=1h name=197gk password=197gk profile=Paket-1-jam
/ip hotspot user add comment=vc-133-04.03.25- limit-uptime=1h name=1idx9 password=1idx9 profile=Paket-1-jam
/ip hotspot user add comment=vc-133-04.03.25- limit-uptime=1h name=12pen password=12pen profile=Paket-1-jam
/ip hotspot user add comment=vc-133-04.03.25- limit-uptime=1h name=1vrdv password=1vrdv profile=Paket-1-jam
/ip hotspot user add comment=vc-133-04.03.25- limit-uptime=1h name=17fyr password=17fyr profile=Paket-1-jam
/ip hotspot user add comment=vc-133-04.03.25- limit-uptime=1h name=1hiy2 password=1hiy2 profile=Paket-1-jam
/ip hotspot user add comment=vc-133-04.03.25- limit-uptime=1h name=12taw password=12taw profile=Paket-1-jam
/ip hotspot user add comment=vc-133-04.03.25- limit-uptime=1h name=1i3jm password=1i3jm profile=Paket-1-jam
/ip hotspot user add comment=vc-133-04.03.25- limit-uptime=1h name=13249 password=13249 profile=Paket-1-jam
/ip hotspot user add comment=vc-133-04.03.25- limit-uptime=1h name=1xrxb password=1xrxb profile=Paket-1-jam
/ip hotspot user add comment=vc-133-04.03.25- limit-uptime=1h name=1d75d password=1d75d profile=Paket-1-jam
/ip hotspot user add comment=vc-133-04.03.25- limit-uptime=1h name=1ivrx password=1ivrx profile=Paket-1-jam
/ip hotspot user add comment=vc-133-04.03.25- limit-uptime=1h name=17r84 password=17r84 profile=Paket-1-jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=2uhhw password=2uhhw profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=2s486 password=2s486 profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=2hjg7 password=2hjg7 profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=2n3pi password=2n3pi profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=26zwx password=26zwx profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=2vgy3 password=2vgy3 profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=2jbpj password=2jbpj profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=227z9 password=227z9 profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=2mwyn password=2mwyn profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=2yag8 password=2yag8 profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=298n9 password=298n9 profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=2z2hu password=2z2hu profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=2ut4w password=2ut4w profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=23ffe password=23ffe profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=2xuji password=2xuji profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=2ar6h password=2ar6h profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=2y3wv password=2y3wv profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=2pkar password=2pkar profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=2adiu password=2adiu profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=28scs password=28scs profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=2s5ux password=2s5ux profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=2fjnp password=2fjnp profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=2jpep password=2jpep profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=2ywuv password=2ywuv profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=29hhf password=29hhf profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=2sxkd password=2sxkd profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=2jabh password=2jabh profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=2k4my password=2k4my profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=2a35f password=2a35f profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=2xi7w password=2xi7w profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=22hy2 password=22hy2 profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=2wjs5 password=2wjs5 profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=29cvj password=29cvj profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=2vec5 password=2vec5 profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=2ujha password=2ujha profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=2wd6g password=2wd6g profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=2sezb password=2sezb profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=2hv2u password=2hv2u profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=2ffun password=2ffun profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=2yi6u password=2yi6u profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=2fyu4 password=2fyu4 profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=2j6jf password=2j6jf profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=2ad7d password=2ad7d profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=2nvy6 password=2nvy6 profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=2jtnd password=2jtnd profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=2sch4 password=2sch4 profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=2crxs password=2crxs profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=2ug97 password=2ug97 profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=2yxe4 password=2yxe4 profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=26syd password=26syd profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=2e52k password=2e52k profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=2dt46 password=2dt46 profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=2ygd5 password=2ygd5 profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=257dp password=257dp profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=25zir password=25zir profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=28n7b password=28n7b profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=2sd2t password=2sd2t profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=22d9v password=22d9v profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=2ujkg password=2ujkg profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=2h8mh password=2h8mh profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=2hj94 password=2hj94 profile=Paket2jam
/ip hotspot user add comment=vc-436-04.21.25- limit-uptime=2h name=2wazv password=2wazv profile=Paket2jam
/ip hotspot user add comment=vc-130-04.27.25- limit-uptime=6h name=6fang password=6fang profile=Paket6jam
/ip hotspot user add comment=vc-130-04.27.25- limit-uptime=6h name=6dgih password=6dgih profile=Paket6jam
/ip hotspot user add comment=vc-130-04.27.25- limit-uptime=6h name=6ejnc password=6ejnc profile=Paket6jam
/ip hotspot user add comment=vc-130-04.27.25- limit-uptime=6h name=64624 password=64624 profile=Paket6jam
/ip hotspot user add comment=vc-130-04.27.25- limit-uptime=6h name=6bz3c password=6bz3c profile=Paket6jam
/ip hotspot user add comment=vc-130-04.27.25- limit-uptime=6h name=69gde password=69gde profile=Paket6jam
/ip hotspot user add comment=vc-130-04.27.25- limit-uptime=6h name=6v5ya password=6v5ya profile=Paket6jam
/ip hotspot user add comment=vc-130-04.27.25- limit-uptime=6h name=6fndm password=6fndm profile=Paket6jam
/ip hotspot user add comment=vc-130-04.27.25- limit-uptime=6h name=6t2fc password=6t2fc profile=Paket6jam
/ip hotspot user add comment=vc-130-04.27.25- limit-uptime=6h name=6d3kr password=6d3kr profile=Paket6jam
/ip hotspot user add comment=vc-130-04.27.25- limit-uptime=6h name=6ysz9 password=6ysz9 profile=Paket6jam
/ip hotspot user add comment=vc- name=AT0r2ucuyb password=AT0r2ucuyb profile=V-2000
/ip hotspot user add comment="CECEP MAULANA-250502161133" disabled=yes name=CECEP password=cecep888 profile="1BULAN 1ORANG"
/ip hotspot user add name=sandi password=sandi888 profile="1BULAN 1ORANG"
/ip hotspot user add comment=vc-244-05.05.25- limit-uptime=1h name=1rjtk password=1rjtk profile=Paket-1-jam
/ip hotspot user add comment=vc-244-05.05.25- limit-uptime=1h name=1fg4p password=1fg4p profile=Paket-1-jam
/ip hotspot user add comment=vc-244-05.05.25- limit-uptime=1h name=19rta password=19rta profile=Paket-1-jam
/ip hotspot user add comment=vc-244-05.05.25- limit-uptime=1h name=13erg password=13erg profile=Paket-1-jam
/ip hotspot user add comment=vc-244-05.05.25- limit-uptime=1h name=17bws password=17bws profile=Paket-1-jam
/ip hotspot user add comment=vc-244-05.05.25- limit-uptime=1h name=1rnih password=1rnih profile=Paket-1-jam
/ip hotspot user add comment=vc-244-05.05.25- limit-uptime=1h name=1wnac password=1wnac profile=Paket-1-jam
/ip hotspot user add comment=vc-244-05.05.25- limit-uptime=1h name=16epc password=16epc profile=Paket-1-jam
/ip hotspot user add comment=vc-244-05.05.25- limit-uptime=1h name=1j6em password=1j6em profile=Paket-1-jam
/ip hotspot user add comment=vc-244-05.05.25- limit-uptime=1h name=1cm5j password=1cm5j profile=Paket-1-jam
/ip hotspot user add comment=vc-244-05.05.25- limit-uptime=1h name=1yyhc password=1yyhc profile=Paket-1-jam
/ip hotspot user add comment=vc-244-05.05.25- limit-uptime=1h name=17473 password=17473 profile=Paket-1-jam
/ip hotspot user add comment=vc-244-05.05.25- limit-uptime=1h name=1yjje password=1yjje profile=Paket-1-jam
/ip hotspot user add comment=vc-244-05.05.25- limit-uptime=1h name=13dvd password=13dvd profile=Paket-1-jam
/ip hotspot user add comment=vc-244-05.05.25- limit-uptime=1h name=187tx password=187tx profile=Paket-1-jam
/ip hotspot user add comment=vc-244-05.05.25- limit-uptime=1h name=16ebf password=16ebf profile=Paket-1-jam
/ip hotspot user add comment=vc-244-05.05.25- limit-uptime=1h name=123sf password=123sf profile=Paket-1-jam
/ip hotspot user add comment=vc-244-05.05.25- limit-uptime=1h name=13u77 password=13u77 profile=Paket-1-jam
/ip hotspot user add comment=vc- name=ATczq9bhr4 password=ATczq9bhr4 profile=V-6000
/ip hotspot user add comment=vc-838-05.15.25- limit-uptime=2h name=2fvt8 password=2fvt8 profile=Paket2jam
/ip hotspot user add comment=vc-838-05.15.25- limit-uptime=2h name=2zzxb password=2zzxb profile=Paket2jam
/ip hotspot user add comment=vc-838-05.15.25- limit-uptime=2h name=2jkzf password=2jkzf profile=Paket2jam
/ip hotspot user add comment=vc-838-05.15.25- limit-uptime=2h name=2ptg8 password=2ptg8 profile=Paket2jam
/ip hotspot user add comment=vc-838-05.15.25- limit-uptime=2h name=2we5y password=2we5y profile=Paket2jam
/ip hotspot user add comment=vc-838-05.15.25- limit-uptime=2h name=2d6k9 password=2d6k9 profile=Paket2jam
/ip hotspot user add comment=vc-838-05.15.25- limit-uptime=2h name=2886w password=2886w profile=Paket2jam
/ip hotspot user add comment=vc-838-05.15.25- limit-uptime=2h name=22292 password=22292 profile=Paket2jam
/ip hotspot user add comment=vc-838-05.15.25- limit-uptime=2h name=2n8he password=2n8he profile=Paket2jam
/ip hotspot user add comment=vc-838-05.15.25- limit-uptime=2h name=26p46 password=26p46 profile=Paket2jam
/ip hotspot user add comment=vc-838-05.15.25- limit-uptime=2h name=24ujg password=24ujg profile=Paket2jam
/ip hotspot user add comment=vc-838-05.15.25- limit-uptime=2h name=2rbnm password=2rbnm profile=Paket2jam
/ip hotspot user add comment=vc-838-05.15.25- limit-uptime=2h name=2v7b8 password=2v7b8 profile=Paket2jam
/ip hotspot user add comment=vc-838-05.15.25- limit-uptime=2h name=2rdvn password=2rdvn profile=Paket2jam
/ip hotspot user add comment=vc-838-05.15.25- limit-uptime=2h name=2zr67 password=2zr67 profile=Paket2jam
/ip hotspot user add comment=vc-838-05.15.25- limit-uptime=2h name=2cbjj password=2cbjj profile=Paket2jam
/ip hotspot user add comment=vc-838-05.15.25- limit-uptime=2h name=2hzgt password=2hzgt profile=Paket2jam
/ip hotspot user add comment=vc-838-05.15.25- limit-uptime=2h name=2i5is password=2i5is profile=Paket2jam
/ip hotspot user add comment=vc-838-05.15.25- limit-uptime=2h name=2zsmh password=2zsmh profile=Paket2jam
/ip hotspot user add comment=vc-838-05.15.25- limit-uptime=2h name=2ifmb password=2ifmb profile=Paket2jam
/ip hotspot user add comment=vc-838-05.15.25- limit-uptime=2h name=2pf5b password=2pf5b profile=Paket2jam
/ip hotspot user add comment=vc-838-05.15.25- limit-uptime=2h name=2jut2 password=2jut2 profile=Paket2jam
/ip hotspot user add comment=vc-838-05.15.25- limit-uptime=2h name=23sun password=23sun profile=Paket2jam
/ip hotspot user add comment=vc-838-05.15.25- limit-uptime=2h name=2k524 password=2k524 profile=Paket2jam
/ip hotspot user add comment=vc-838-05.15.25- limit-uptime=2h name=2yrey password=2yrey profile=Paket2jam
/ip hotspot user add comment=vc-838-05.15.25- limit-uptime=2h name=2u766 password=2u766 profile=Paket2jam
/ip hotspot user add comment=vc-852-05.15.25- limit-uptime=6h name=6Zz29 password=6Zz29 profile=Paket6jam
/ip hotspot user add comment=vc-852-05.15.25- limit-uptime=6h name=6XT69 password=6XT69 profile=Paket6jam
/ip hotspot user add comment=vc-852-05.15.25- limit-uptime=6h name=6tP27 password=6tP27 profile=Paket6jam
/ip hotspot user add comment=vc-852-05.15.25- limit-uptime=6h name=6AX34 password=6AX34 profile=Paket6jam
/ip hotspot user add comment=vc-852-05.15.25- limit-uptime=6h name=6At58 password=6At58 profile=Paket6jam
/ip hotspot user add comment=vc-852-05.15.25- limit-uptime=6h name=6tC64 password=6tC64 profile=Paket6jam
/ip hotspot user add comment=vc-852-05.15.25- limit-uptime=6h name=6Ax35 password=6Ax35 profile=Paket6jam
/ip hotspot user add comment=vc-852-05.15.25- limit-uptime=6h name=6Gg84 password=6Gg84 profile=Paket6jam
/ip hotspot user add comment=vc-852-05.15.25- limit-uptime=6h name=6kD34 password=6kD34 profile=Paket6jam
/ip hotspot user add comment=vc-852-05.15.25- limit-uptime=6h name=6PE33 password=6PE33 profile=Paket6jam
/ip hotspot user add comment=vc-852-05.15.25- limit-uptime=6h name=6pb36 password=6pb36 profile=Paket6jam
/ip hotspot user add comment=vc-852-05.15.25- limit-uptime=6h name=6Sd67 password=6Sd67 profile=Paket6jam
/ip hotspot user add comment=vc-852-05.15.25- limit-uptime=6h name=6LM98 password=6LM98 profile=Paket6jam
/ip hotspot user add comment=vc-852-05.15.25- limit-uptime=6h name=6bL97 password=6bL97 profile=Paket6jam
/ip hotspot user add comment=vc-852-05.15.25- limit-uptime=6h name=6xN84 password=6xN84 profile=Paket6jam
/ip hotspot user add comment=vc-852-05.15.25- limit-uptime=6h name=6NH98 password=6NH98 profile=Paket6jam
/ip hotspot user add comment=vc-852-05.15.25- limit-uptime=6h name=6Yz43 password=6Yz43 profile=Paket6jam
/ip hotspot user add comment=vc-852-05.15.25- limit-uptime=6h name=6UC55 password=6UC55 profile=Paket6jam
/ip hotspot user add comment=vc-852-05.15.25- limit-uptime=6h name=6Rx55 password=6Rx55 profile=Paket6jam
/ip hotspot user add comment=vc-852-05.15.25- limit-uptime=6h name=6rH36 password=6rH36 profile=Paket6jam
/ip hotspot user add comment=vc-852-05.15.25- limit-uptime=6h name=6Xw65 password=6Xw65 profile=Paket6jam
/ip hotspot user add comment=vc-852-05.15.25- limit-uptime=6h name=6TA86 password=6TA86 profile=Paket6jam
/ip hotspot user add comment=vc-852-05.15.25- limit-uptime=6h name=6VB58 password=6VB58 profile=Paket6jam
/ip hotspot user add comment=vc-852-05.15.25- limit-uptime=6h name=6PT68 password=6PT68 profile=Paket6jam
/ip hotspot user add comment=vc-852-05.15.25- limit-uptime=6h name=6GD59 password=6GD59 profile=Paket6jam
/ip hotspot user add comment=vc-852-05.15.25- limit-uptime=6h name=6fU72 password=6fU72 profile=Paket6jam
/ip hotspot user add comment=vc-852-05.15.25- limit-uptime=6h name=6aG58 password=6aG58 profile=Paket6jam
/ip hotspot user add comment=vc-852-05.15.25- limit-uptime=6h name=6fP99 password=6fP99 profile=Paket6jam
/ip hotspot user add comment=vc-852-05.15.25- limit-uptime=6h name=6Es73 password=6Es73 profile=Paket6jam
/ip hotspot user add comment=vc-852-05.15.25- limit-uptime=6h name=6Dc69 password=6Dc69 profile=Paket6jam
/ip hotspot user add comment=vc-852-05.15.25- limit-uptime=6h name=6LR43 password=6LR43 profile=Paket6jam
/ip hotspot user add comment=vc-852-05.15.25- limit-uptime=6h name=6DN67 password=6DN67 profile=Paket6jam
/ip hotspot user add comment=vc-852-05.15.25- limit-uptime=6h name=6Tt73 password=6Tt73 profile=Paket6jam
/ip hotspot user add comment=vc-852-05.15.25- limit-uptime=6h name=6Jc62 password=6Jc62 profile=Paket6jam
/ip hotspot user add comment=vc-852-05.15.25- limit-uptime=6h name=6Yj54 password=6Yj54 profile=Paket6jam
/ip hotspot user add comment=vc-852-05.15.25- limit-uptime=6h name=6Ht75 password=6Ht75 profile=Paket6jam
/ip hotspot user add comment=vc-852-05.15.25- limit-uptime=6h name=6Lf32 password=6Lf32 profile=Paket6jam
/ip hotspot user add comment=vc-852-05.15.25- limit-uptime=6h name=6kT54 password=6kT54 profile=Paket6jam
/ip hotspot user add name=domba password=domba
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1gf93 password=1gf93 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1fv77 password=1fv77 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1wa57 password=1wa57 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1in63 password=1in63 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1ds83 password=1ds83 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1dp25 password=1dp25 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1ri28 password=1ri28 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1mn63 password=1mn63 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1ce62 password=1ce62 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1is67 password=1is67 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1en96 password=1en96 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1gc83 password=1gc83 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1gs77 password=1gs77 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1cf42 password=1cf42 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1ct38 password=1ct38 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1tz87 password=1tz87 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1ct88 password=1ct88 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1ey94 password=1ey94 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1nz93 password=1nz93 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1xx89 password=1xx89 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1bs68 password=1bs68 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1vj92 password=1vj92 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1eu83 password=1eu83 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1nn95 password=1nn95 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1db25 password=1db25 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1bf27 password=1bf27 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1ru76 password=1ru76 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1zv92 password=1zv92 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1hv98 password=1hv98 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1dd65 password=1dd65 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1gm47 password=1gm47 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1gk42 password=1gk42 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1ki72 password=1ki72 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1uf56 password=1uf56 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1jf87 password=1jf87 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1hm34 password=1hm34 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1sj95 password=1sj95 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1fi53 password=1fi53 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1dw34 password=1dw34 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1jr69 password=1jr69 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1kh45 password=1kh45 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1dy22 password=1dy22 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1ak55 password=1ak55 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1xi24 password=1xi24 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1he32 password=1he32 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1zy35 password=1zy35 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1vx58 password=1vx58 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1zu56 password=1zu56 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1ke28 password=1ke28 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1rd93 password=1rd93 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1ur47 password=1ur47 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1tn54 password=1tn54 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1vr57 password=1vr57 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1ez26 password=1ez26 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1zd67 password=1zd67 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1mj78 password=1mj78 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1nn32 password=1nn32 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1fu46 password=1fu46 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1fy83 password=1fy83 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1dw83 password=1dw83 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1ra94 password=1ra94 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1mp69 password=1mp69 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1ru65 password=1ru65 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1ds56 password=1ds56 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1xx98 password=1xx98 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1kn22 password=1kn22 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1ij87 password=1ij87 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1mw23 password=1mw23 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1uw98 password=1uw98 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1dv59 password=1dv59 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1tg37 password=1tg37 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1kv33 password=1kv33 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1rn49 password=1rn49 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1bf99 password=1bf99 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1mi66 password=1mi66 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1rk92 password=1rk92 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1wh88 password=1wh88 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1zi48 password=1zi48 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1hx94 password=1hx94 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1ft84 password=1ft84 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1ia58 password=1ia58 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1hc56 password=1hc56 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1xv37 password=1xv37 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1ur69 password=1ur69 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1fg22 password=1fg22 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1tv64 password=1tv64 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1vm36 password=1vm36 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1nm55 password=1nm55 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1mh49 password=1mh49 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1am94 password=1am94 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1at44 password=1at44 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1wh32 password=1wh32 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1hw95 password=1hw95 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1xg79 password=1xg79 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1yc82 password=1yc82 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1tv88 password=1tv88 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1hs33 password=1hs33 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1yp98 password=1yp98 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1fn79 password=1fn79 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1sf33 password=1sf33 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1nx97 password=1nx97 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1mg88 password=1mg88 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1er79 password=1er79 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1de23 password=1de23 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1bx22 password=1bx22 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1sd83 password=1sd83 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1en39 password=1en39 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1zh77 password=1zh77 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1gv95 password=1gv95 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1vd38 password=1vd38 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1tw72 password=1tw72 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1ya26 password=1ya26 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1kh25 password=1kh25 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1iv78 password=1iv78 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1pu86 password=1pu86 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1tt98 password=1tt98 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1ys25 password=1ys25 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1kj26 password=1kj26 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1nn36 password=1nn36 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1xj78 password=1xj78 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1mg39 password=1mg39 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1xe85 password=1xe85 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1tt28 password=1tt28 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1tm94 password=1tm94 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1dk48 password=1dk48 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1ib47 password=1ib47 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1av73 password=1av73 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1eb88 password=1eb88 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1sv28 password=1sv28 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1jr49 password=1jr49 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1un93 password=1un93 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1sr28 password=1sr28 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1tm75 password=1tm75 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1xv99 password=1xv99 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1aw76 password=1aw76 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1xc48 password=1xc48 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1mk57 password=1mk57 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1fv98 password=1fv98 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1hg93 password=1hg93 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1sv88 password=1sv88 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1xr62 password=1xr62 profile=Paket-1-jam
/ip hotspot user add comment=vc-165-05.31.25- limit-uptime=1h name=1mk95 password=1mk95 profile=Paket-1-jam
/ip hotspot user add comment=vc-236-06.09.25- limit-uptime=2h name=2vnwd password=2vnwd profile=Paket2jam
/ip hotspot user add comment=vc-236-06.09.25- limit-uptime=2h name=2k5ix password=2k5ix profile=Paket2jam
/ip hotspot user add comment=vc-236-06.09.25- limit-uptime=2h name=2ycfw password=2ycfw profile=Paket2jam
/ip hotspot user add comment=vc-236-06.09.25- limit-uptime=2h name=24k5b password=24k5b profile=Paket2jam
/ip hotspot user add comment=vc-236-06.09.25- limit-uptime=2h name=2396g password=2396g profile=Paket2jam
/ip hotspot user add comment=vc-323-06.09.25- limit-uptime=6h name=6z783 password=6z783 profile=Paket6jam
/ip hotspot user add comment=vc-323-06.09.25- limit-uptime=6h name=6tste password=6tste profile=Paket6jam
/ip hotspot user add comment=vc-323-06.09.25- limit-uptime=6h name=6k6ac password=6k6ac profile=Paket6jam
/ip hotspot user add comment=vc-323-06.09.25- limit-uptime=6h name=69t85 password=69t85 profile=Paket6jam
/ip hotspot user add comment=vc-323-06.09.25- limit-uptime=6h name=674hy password=674hy profile=Paket6jam
/ip hotspot user add comment=vc-323-06.09.25- limit-uptime=6h name=6bzjr password=6bzjr profile=Paket6jam
/ip hotspot user add comment=vc-323-06.09.25- limit-uptime=6h name=6h3sd password=6h3sd profile=Paket6jam
/ip hotspot user add comment=vc-323-06.09.25- limit-uptime=6h name=62ais password=62ais profile=Paket6jam
/ip hotspot user add comment=vc-323-06.09.25- limit-uptime=6h name=6cg9m password=6cg9m profile=Paket6jam
/ip hotspot user add comment=vc- name=AT86pcdiw2 password=AT86pcdiw2 profile=V-2000
/ip hotspot user add comment=vc- name=ATrhjwpvjn password=ATrhjwpvjn profile=V-3500
/ip hotspot user add comment=vc-314-06.29.25- limit-uptime=1h name=1tu56 password=1tu56 profile=Paket-1-jam
/ip hotspot user add comment=vc-314-06.29.25- limit-uptime=1h name=1kg22 password=1kg22 profile=Paket-1-jam
/ip hotspot user add comment=vc-314-06.29.25- limit-uptime=1h name=1ye47 password=1ye47 profile=Paket-1-jam
/ip hotspot user add comment=vc-314-06.29.25- limit-uptime=1h name=1sz24 password=1sz24 profile=Paket-1-jam
/ip hotspot user add comment=vc-314-06.29.25- limit-uptime=1h name=1yv36 password=1yv36 profile=Paket-1-jam
/ip hotspot user add comment=vc-314-06.29.25- limit-uptime=1h name=1im43 password=1im43 profile=Paket-1-jam
/ip hotspot user add comment=vc-314-06.29.25- limit-uptime=1h name=1ni25 password=1ni25 profile=Paket-1-jam
/ip hotspot user add comment=vc-696-07.12.25- limit-uptime=2h name=2fy92 password=2fy92 profile=Paket2jam
/ip hotspot user add comment=vc-696-07.12.25- limit-uptime=2h name=2xe79 password=2xe79 profile=Paket2jam
/ip hotspot user add comment=vc-696-07.12.25- limit-uptime=2h name=2re45 password=2re45 profile=Paket2jam
/ip hotspot user add comment=vc-696-07.12.25- limit-uptime=2h name=2bf85 password=2bf85 profile=Paket2jam
/ip hotspot user add comment=vc-696-07.12.25- limit-uptime=2h name=2ff76 password=2ff76 profile=Paket2jam
/ip hotspot user add comment=vc-696-07.12.25- limit-uptime=2h name=2ba23 password=2ba23 profile=Paket2jam
/ip hotspot user add comment=vc-696-07.12.25- limit-uptime=2h name=2ud34 password=2ud34 profile=Paket2jam
/ip hotspot user add comment=vc-936-07.12.25- limit-uptime=6h name=6wx96 password=6wx96 profile=Paket6jam
/ip hotspot user add comment=vc-936-07.12.25- limit-uptime=6h name=6zn78 password=6zn78 profile=Paket6jam
/ip hotspot user add comment=vc-936-07.12.25- limit-uptime=6h name=6vy38 password=6vy38 profile=Paket6jam
/ip hotspot user add comment=vc-936-07.12.25- limit-uptime=6h name=6it42 password=6it42 profile=Paket6jam
/ip hotspot user add comment=vc-936-07.12.25- limit-uptime=6h name=6yy45 password=6yy45 profile=Paket6jam
/ip hotspot user add comment=vc- name=ATjilfdgfr password=ATjilfdgfr profile=V-3500
/ip hotspot user add comment=vc-934-08.08.25- limit-uptime=1h name=1hx5m password=1hx5m profile=Paket-1-jam
/ip hotspot user add comment=vc-934-08.08.25- limit-uptime=1h name=1jskp password=1jskp profile=Paket-1-jam
/ip hotspot user add comment=vc-934-08.08.25- limit-uptime=1h name=1tait password=1tait profile=Paket-1-jam
/ip hotspot user add comment=vc-934-08.08.25- limit-uptime=1h name=1inzj password=1inzj profile=Paket-1-jam
/ip hotspot user add comment=vc-934-08.08.25- limit-uptime=1h name=1epyr password=1epyr profile=Paket-1-jam
/ip hotspot user add comment=vc-934-08.08.25- limit-uptime=1h name=18dxs password=18dxs profile=Paket-1-jam
/ip hotspot user add comment=vc-934-08.08.25- limit-uptime=1h name=1kmk4 password=1kmk4 profile=Paket-1-jam
/ip hotspot user add comment=vc-934-08.08.25- limit-uptime=1h name=198hg password=198hg profile=Paket-1-jam
/ip hotspot user add comment=vc-934-08.08.25- limit-uptime=1h name=1gng4 password=1gng4 profile=Paket-1-jam
/ip hotspot user add comment=vc-934-08.08.25- limit-uptime=1h name=1xss3 password=1xss3 profile=Paket-1-jam
/ip hotspot user add comment=vc-934-08.08.25- limit-uptime=1h name=1b8jj password=1b8jj profile=Paket-1-jam
/ip hotspot user add comment=vc-934-08.08.25- limit-uptime=1h name=1x8i8 password=1x8i8 profile=Paket-1-jam
/ip hotspot user add comment=vc-934-08.08.25- limit-uptime=1h name=125sf password=125sf profile=Paket-1-jam
/ip hotspot user add comment=vc-934-08.08.25- limit-uptime=1h name=1zebc password=1zebc profile=Paket-1-jam
/ip hotspot user add comment=vc-934-08.08.25- limit-uptime=1h name=15yub password=15yub profile=Paket-1-jam
/ip hotspot user add comment=vc-934-08.08.25- limit-uptime=1h name=1pkfy password=1pkfy profile=Paket-1-jam
/ip hotspot user add comment=vc-934-08.08.25- limit-uptime=1h name=182wh password=182wh profile=Paket-1-jam
/ip hotspot user add comment=vc-934-08.08.25- limit-uptime=1h name=1beev password=1beev profile=Paket-1-jam
/ip hotspot user add comment=vc-934-08.08.25- limit-uptime=1h name=1cz4h password=1cz4h profile=Paket-1-jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2y83m password=2y83m profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2naa9 password=2naa9 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2aesu password=2aesu profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2i5uh password=2i5uh profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2uc7b password=2uc7b profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=29z6m password=29z6m profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=227rn password=227rn profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2sv25 password=2sv25 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=27372 password=27372 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2jhep password=2jhep profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=28drk password=28drk profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=25hek password=25hek profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2nfmk password=2nfmk profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2rabb password=2rabb profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2bnvi password=2bnvi profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2pcx9 password=2pcx9 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2x8gw password=2x8gw profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2nuep password=2nuep profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2sgmz password=2sgmz profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2ampz password=2ampz profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2rrmr password=2rrmr profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2mb6y password=2mb6y profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2ez5j password=2ez5j profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2ypnw password=2ypnw profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2h3di password=2h3di profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=26ie7 password=26ie7 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=274sx password=274sx profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2trkc password=2trkc profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2b9ea password=2b9ea profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2zz88 password=2zz88 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2pjri password=2pjri profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2gbxf password=2gbxf profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=253fy password=253fy profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=29b7r password=29b7r profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=25pnu password=25pnu profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2ab32 password=2ab32 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=267f6 password=267f6 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2m6g6 password=2m6g6 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2kjws password=2kjws profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2axt3 password=2axt3 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2sefu password=2sefu profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2wf3n password=2wf3n profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2s8fm password=2s8fm profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2kihu password=2kihu profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=238ir password=238ir profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2tbsi password=2tbsi profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2uvgh password=2uvgh profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2y6wf password=2y6wf profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2rh5g password=2rh5g profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2tcgr password=2tcgr profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2ktsn password=2ktsn profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2zbwf password=2zbwf profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2wvv2 password=2wvv2 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2knw5 password=2knw5 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2p5fj password=2p5fj profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2ikws password=2ikws profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2h6in password=2h6in profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2yw6e password=2yw6e profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2jyjz password=2jyjz profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2u5rh password=2u5rh profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=25jtb password=25jtb profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2bdgy password=2bdgy profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2w5zz password=2w5zz profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2pdse password=2pdse profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2i877 password=2i877 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2djh6 password=2djh6 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2ysrs password=2ysrs profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2gsmn password=2gsmn profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2nd8c password=2nd8c profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2sbzg password=2sbzg profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2bg6e password=2bg6e profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2g23f password=2g23f profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=23wp4 password=23wp4 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2e922 password=2e922 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2pt89 password=2pt89 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2au7n password=2au7n profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=24jdt password=24jdt profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2spvf password=2spvf profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2jp4u password=2jp4u profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2g8fv password=2g8fv profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2xn4a password=2xn4a profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=23wbk password=23wbk profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2arvt password=2arvt profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2h54v password=2h54v profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2at4s password=2at4s profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2p6dh password=2p6dh profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2m3fu password=2m3fu profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2z7n8 password=2z7n8 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2s5dg password=2s5dg profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2r423 password=2r423 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2wwv7 password=2wwv7 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2w448 password=2w448 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2wp2w password=2wp2w profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2idee password=2idee profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=29wdk password=29wdk profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2bt8i password=2bt8i profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2gk7h password=2gk7h profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2gx4d password=2gx4d profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2a625 password=2a625 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2ert8 password=2ert8 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2vne7 password=2vne7 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=22aen password=22aen profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=26pat password=26pat profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2683f password=2683f profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2dgbc password=2dgbc profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2yewd password=2yewd profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=26ije password=26ije profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2swr8 password=2swr8 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2zzhm password=2zzhm profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2ubvh password=2ubvh profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=25vjf password=25vjf profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2gwzp password=2gwzp profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2i6g8 password=2i6g8 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2ii99 password=2ii99 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2i643 password=2i643 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2jyma password=2jyma profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2w2rs password=2w2rs profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2dm5g password=2dm5g profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2wkd7 password=2wkd7 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2amei password=2amei profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2jkut password=2jkut profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2j8ib password=2j8ib profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=25cp7 password=25cp7 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2bhzb password=2bhzb profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2ffrz password=2ffrz profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2h9fd password=2h9fd profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=29wtf password=29wtf profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2aniu password=2aniu profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=27eyj password=27eyj profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=27x3d password=27x3d profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2pndy password=2pndy profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=23473 password=23473 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=23hdk password=23hdk profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2yi3r password=2yi3r profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2krsv password=2krsv profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2875s password=2875s profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2s6jf password=2s6jf profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=23jud password=23jud profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=27pz6 password=27pz6 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=22zbm password=22zbm profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2fz4w password=2fz4w profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2kd3j password=2kd3j profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2yug7 password=2yug7 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=24zpv password=24zpv profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=22yct password=22yct profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2duw4 password=2duw4 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=25r7u password=25r7u profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=26yj2 password=26yj2 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2gpu9 password=2gpu9 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2herb password=2herb profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2ztcr password=2ztcr profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=29pt4 password=29pt4 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2vxjr password=2vxjr profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2cijy password=2cijy profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=25bn8 password=25bn8 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2cwyg password=2cwyg profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=256wc password=256wc profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=28kie password=28kie profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2vn74 password=2vn74 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2xduc password=2xduc profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=24ksw password=24ksw profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2m4ce password=2m4ce profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2h5kr password=2h5kr profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2xj7n password=2xj7n profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2sa38 password=2sa38 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2k8tc password=2k8tc profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2t5tc password=2t5tc profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2d969 password=2d969 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2gin6 password=2gin6 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2e8pc password=2e8pc profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2vsg8 password=2vsg8 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=22kk4 password=22kk4 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2b2xs password=2b2xs profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2y6sw password=2y6sw profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2297t password=2297t profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2zrmu password=2zrmu profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2kans password=2kans profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=27krb password=27krb profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2w8jh password=2w8jh profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2p4fi password=2p4fi profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2aa6d password=2aa6d profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2756h password=2756h profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2y7p6 password=2y7p6 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2zt4m password=2zt4m profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2a46j password=2a46j profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2k3u8 password=2k3u8 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=23b2j password=23b2j profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=292ex password=292ex profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2t279 password=2t279 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2e7xs password=2e7xs profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2j3rt password=2j3rt profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=23g8y password=23g8y profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2w3ub password=2w3ub profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2g286 password=2g286 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=22gsn password=22gsn profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2mpc2 password=2mpc2 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2w37g password=2w37g profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=27dbe password=27dbe profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2893k password=2893k profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=267yc password=267yc profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=232rg password=232rg profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2yd6f password=2yd6f profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2ngn8 password=2ngn8 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2ajgg password=2ajgg profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=25a5p password=25a5p profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2mycy password=2mycy profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2w45z password=2w45z profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2act3 password=2act3 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2acb9 password=2acb9 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2pxci password=2pxci profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2ihgb password=2ihgb profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=29d68 password=29d68 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=24k53 password=24k53 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=25pvj password=25pvj profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2amwu password=2amwu profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=248xy password=248xy profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2d9ay password=2d9ay profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=27nau password=27nau profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=27h4f password=27h4f profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2udb6 password=2udb6 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2f26c password=2f26c profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2y9y6 password=2y9y6 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2uppw password=2uppw profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2ujm9 password=2ujm9 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2c272 password=2c272 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2e52d password=2e52d profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2zj5j password=2zj5j profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2h756 password=2h756 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2nny8 password=2nny8 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2bu2s password=2bu2s profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2t7w2 password=2t7w2 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2i243 password=2i243 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=29rir password=29rir profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2jkrm password=2jkrm profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2bx8j password=2bx8j profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2huy6 password=2huy6 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=286j7 password=286j7 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2suj5 password=2suj5 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2ud2b password=2ud2b profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2unjr password=2unjr profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=28whc password=28whc profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2d63e password=2d63e profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2ww4v password=2ww4v profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2svr8 password=2svr8 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2zpyh password=2zpyh profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=28zwa password=28zwa profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2ptfr password=2ptfr profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2jtga password=2jtga profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2ukb5 password=2ukb5 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2dkj4 password=2dkj4 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=22t5s password=22t5s profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2yrpn password=2yrpn profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2m9e4 password=2m9e4 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=24pnn password=24pnn profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2x9vk password=2x9vk profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=24fpu password=24fpu profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2cjes password=2cjes profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=23d8u password=23d8u profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2x7rn password=2x7rn profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=29pwk password=29pwk profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2aan3 password=2aan3 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=23db9 password=23db9 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2kzv8 password=2kzv8 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2n6by password=2n6by profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2ub2d password=2ub2d profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2spib password=2spib profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2m47i password=2m47i profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=25p99 password=25p99 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2nx22 password=2nx22 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2tcgx password=2tcgx profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=246ae password=246ae profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2wg6y password=2wg6y profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2htdy password=2htdy profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=25r35 password=25r35 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2sb42 password=2sb42 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2tg7n password=2tg7n profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=25sib password=25sib profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=28jpw password=28jpw profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2wivy password=2wivy profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2b7xc password=2b7xc profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2cyti password=2cyti profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2cwjd password=2cwjd profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2i6jk password=2i6jk profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2hw77 password=2hw77 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=29bys password=29bys profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2vdfz password=2vdfz profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2z772 password=2z772 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=253t8 password=253t8 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2ci23 password=2ci23 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=22hrt password=22hrt profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2umxh password=2umxh profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2pgvx password=2pgvx profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=22ymj password=22ymj profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2tjag password=2tjag profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2uep6 password=2uep6 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2z3c9 password=2z3c9 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2pkh6 password=2pkh6 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=23eec password=23eec profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2tzui password=2tzui profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2pddk password=2pddk profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2hnw6 password=2hnw6 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=28mjw password=28mjw profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2w4sn password=2w4sn profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2k958 password=2k958 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2ty8v password=2ty8v profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=26y3v password=26y3v profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2k8xp password=2k8xp profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2ksdj password=2ksdj profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2kadc password=2kadc profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2j4si password=2j4si profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=22wmj password=22wmj profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2zxut password=2zxut profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=28gzh password=28gzh profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2b2p5 password=2b2p5 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2rf8j password=2rf8j profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2s3vb password=2s3vb profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2m8pr password=2m8pr profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2duba password=2duba profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=26zm4 password=26zm4 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2umpx password=2umpx profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2thym password=2thym profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2ah2z password=2ah2z profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2tzag password=2tzag profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=264fe password=264fe profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2nt55 password=2nt55 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2hfkc password=2hfkc profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=22vt9 password=22vt9 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=26fpz password=26fpz profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2zs9j password=2zs9j profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=2tbr4 password=2tbr4 profile=Paket2jam
/ip hotspot user add comment=vc-281-08.08.25- limit-uptime=2h name=25r2h password=25r2h profile=Paket2jam
/ip hotspot user add comment=vc-436-08.08.25- limit-uptime=6h name=65zpt password=65zpt profile=Paket6jam
/ip hotspot user add comment=vc-436-08.08.25- limit-uptime=6h name=6tyeg password=6tyeg profile=Paket6jam
/ip hotspot user add comment=vc-436-08.08.25- limit-uptime=6h name=6v5pg password=6v5pg profile=Paket6jam
/ip hotspot user add comment=vc- name=ATjg3smi3h password=ATjg3smi3h profile=V-2000
/ip hotspot user add comment=vc-507-08.31.25- limit-uptime=2h name=2ne55 password=2ne55 profile=Paket2jam
/ip hotspot user add comment=vc-507-08.31.25- limit-uptime=2h name=2pz56 password=2pz56 profile=Paket2jam
/ip hotspot user add comment=vc-507-08.31.25- limit-uptime=2h name=2si42 password=2si42 profile=Paket2jam
/ip hotspot user add comment=vc-507-08.31.25- limit-uptime=2h name=2rd69 password=2rd69 profile=Paket2jam
/ip hotspot user add comment=vc-507-08.31.25- limit-uptime=2h name=2in37 password=2in37 profile=Paket2jam
/ip hotspot user add comment=vc-507-08.31.25- limit-uptime=2h name=2yb47 password=2yb47 profile=Paket2jam
/ip hotspot user add comment=vc-507-08.31.25- limit-uptime=2h name=2ec78 password=2ec78 profile=Paket2jam
/ip hotspot user add comment=vc-507-08.31.25- limit-uptime=2h name=2ti79 password=2ti79 profile=Paket2jam
/ip hotspot user add comment=vc-507-08.31.25- limit-uptime=2h name=2sa58 password=2sa58 profile=Paket2jam
/ip hotspot user add comment=vc-507-08.31.25- limit-uptime=2h name=2re46 password=2re46 profile=Paket2jam
/ip hotspot user add comment=vc-507-08.31.25- limit-uptime=2h name=2kh96 password=2kh96 profile=Paket2jam
/ip hotspot user add comment=vc-507-08.31.25- limit-uptime=2h name=2ex64 password=2ex64 profile=Paket2jam
/ip hotspot user add comment=vc-507-08.31.25- limit-uptime=2h name=2wp38 password=2wp38 profile=Paket2jam
/ip hotspot user add comment=vc-507-08.31.25- limit-uptime=2h name=2ez38 password=2ez38 profile=Paket2jam
/ip hotspot user add comment=vc-507-08.31.25- limit-uptime=2h name=2gz66 password=2gz66 profile=Paket2jam
/ip hotspot user add comment=vc-507-08.31.25- limit-uptime=2h name=2hr52 password=2hr52 profile=Paket2jam
/ip hotspot user add comment=vc-507-08.31.25- limit-uptime=2h name=2zj84 password=2zj84 profile=Paket2jam
/ip hotspot user add comment=vc-507-08.31.25- limit-uptime=2h name=2me97 password=2me97 profile=Paket2jam
/ip hotspot user add comment=vc-507-08.31.25- limit-uptime=2h name=2ik54 password=2ik54 profile=Paket2jam
/ip hotspot user add comment=vc-507-08.31.25- limit-uptime=2h name=2gf26 password=2gf26 profile=Paket2jam
/ip hotspot user add comment=vc-507-08.31.25- limit-uptime=2h name=2xb63 password=2xb63 profile=Paket2jam
/ip hotspot user add comment=vc-507-08.31.25- limit-uptime=2h name=2ij52 password=2ij52 profile=Paket2jam
/ip hotspot user add comment=vc-334-09.08.25- limit-uptime=6h name=6b6dt password=6b6dt profile=Paket6jam
/ip hotspot user add comment=vc-334-09.08.25- limit-uptime=6h name=67d9g password=67d9g profile=Paket6jam
/ip hotspot user add comment=vc-334-09.08.25- limit-uptime=6h name=6wdhs password=6wdhs profile=Paket6jam
/ip hotspot user add comment=vc-334-09.08.25- limit-uptime=6h name=625y6 password=625y6 profile=Paket6jam
/ip hotspot user add comment=vc-334-09.08.25- limit-uptime=6h name=6if6j password=6if6j profile=Paket6jam
/ip hotspot user add comment=vc-334-09.08.25- limit-uptime=6h name=67sux password=67sux profile=Paket6jam
/ip hotspot user add comment=vc-334-09.08.25- limit-uptime=6h name=6xf9f password=6xf9f profile=Paket6jam
/ip hotspot user add comment=vc-237-09.08.25- limit-uptime=1h name=1i528 password=1i528 profile=Paket-1-jam
/ip hotspot user add comment=vc-237-09.08.25- limit-uptime=1h name=18ybv password=18ybv profile=Paket-1-jam
/ip hotspot user add comment=vc-237-09.08.25- limit-uptime=1h name=14gf5 password=14gf5 profile=Paket-1-jam
/ip hotspot user add comment=vc-237-09.08.25- limit-uptime=1h name=1pbzw password=1pbzw profile=Paket-1-jam
/ip hotspot user add comment=vc-237-09.08.25- limit-uptime=1h name=12h9w password=12h9w profile=Paket-1-jam
/ip hotspot user add comment=vc-237-09.08.25- limit-uptime=1h name=1c9xi password=1c9xi profile=Paket-1-jam
/ip hotspot user add comment=vc-237-09.08.25- limit-uptime=1h name=1sjyw password=1sjyw profile=Paket-1-jam
/ip hotspot user add comment=vc-237-09.08.25- limit-uptime=1h name=1w2iz password=1w2iz profile=Paket-1-jam
/ip hotspot user add comment=vc-237-09.08.25- limit-uptime=1h name=1fcbh password=1fcbh profile=Paket-1-jam
/ip hotspot user add comment=vc- name=ATh26rk82l password=ATh26rk82l profile=V-3500
/ip hotspot user add comment=vc-275-10.03.25- limit-uptime=2h name=2vh93 password=2vh93 profile=Paket2jam
/ip hotspot user add comment=vc-275-10.03.25- limit-uptime=2h name=2vv89 password=2vv89 profile=Paket2jam
/ip hotspot user add comment=vc-275-10.03.25- limit-uptime=2h name=2xu57 password=2xu57 profile=Paket2jam
/ip hotspot user add comment=vc-275-10.03.25- limit-uptime=2h name=2da48 password=2da48 profile=Paket2jam
/ip hotspot user add comment=vc-275-10.03.25- limit-uptime=2h name=2fb86 password=2fb86 profile=Paket2jam
/ip hotspot user add comment=vc-275-10.03.25- limit-uptime=2h name=2uu32 password=2uu32 profile=Paket2jam
/ip hotspot user add comment=vc-275-10.03.25- limit-uptime=2h name=2kx98 password=2kx98 profile=Paket2jam
/ip hotspot user add comment=vc-275-10.03.25- limit-uptime=2h name=2mr22 password=2mr22 profile=Paket2jam
/ip hotspot user add comment=vc-275-10.03.25- limit-uptime=2h name=2jf36 password=2jf36 profile=Paket2jam
/ip hotspot user add comment=vc-275-10.03.25- limit-uptime=2h name=2bu78 password=2bu78 profile=Paket2jam
/ip hotspot user add comment=vc-275-10.03.25- limit-uptime=2h name=2tg55 password=2tg55 profile=Paket2jam
/ip hotspot user add comment=vc-275-10.03.25- limit-uptime=2h name=2fa68 password=2fa68 profile=Paket2jam
/ip hotspot user add comment=vc-275-10.03.25- limit-uptime=2h name=2ft63 password=2ft63 profile=Paket2jam
/ip hotspot user add comment=vc-275-10.03.25- limit-uptime=2h name=2wz86 password=2wz86 profile=Paket2jam
/ip hotspot user add comment=vc-275-10.03.25- limit-uptime=2h name=2sn29 password=2sn29 profile=Paket2jam
/ip hotspot user add comment=vc-275-10.03.25- limit-uptime=2h name=2xr72 password=2xr72 profile=Paket2jam
/ip hotspot user add comment=vc-275-10.03.25- limit-uptime=2h name=2yd57 password=2yd57 profile=Paket2jam
/ip hotspot user add comment=vc-275-10.03.25- limit-uptime=2h name=2gf45 password=2gf45 profile=Paket2jam
/ip hotspot user add comment=vc-275-10.03.25- limit-uptime=2h name=2gh33 password=2gh33 profile=Paket2jam
/ip hotspot user add comment=vc-275-10.03.25- limit-uptime=2h name=2ka37 password=2ka37 profile=Paket2jam
/ip hotspot user add comment=vc-275-10.03.25- limit-uptime=2h name=2wc97 password=2wc97 profile=Paket2jam
/ip hotspot user add comment=vc-275-10.03.25- limit-uptime=2h name=2me23 password=2me23 profile=Paket2jam
/ip hotspot user add comment=vc-275-10.03.25- limit-uptime=2h name=2ra34 password=2ra34 profile=Paket2jam
/ip hotspot user add comment=vc-608-10.03.25- limit-uptime=6h name=6fn48 password=6fn48 profile=Paket6jam
/ip hotspot user add comment=vc-608-10.03.25- limit-uptime=6h name=6ap69 password=6ap69 profile=Paket6jam
/ip hotspot user add comment=vc-608-10.03.25- limit-uptime=6h name=6cx76 password=6cx76 profile=Paket6jam
/ip hotspot user add comment=vc-608-10.03.25- limit-uptime=6h name=6zz95 password=6zz95 profile=Paket6jam
/ip hotspot user add comment=vc-608-10.03.25- limit-uptime=6h name=6an58 password=6an58 profile=Paket6jam
/ip hotspot user add comment=vc-608-10.03.25- limit-uptime=6h name=6ry28 password=6ry28 profile=Paket6jam
/ip hotspot user add comment=vc-608-10.03.25- limit-uptime=6h name=6ip65 password=6ip65 profile=Paket6jam
/ip hotspot user add comment=vc-608-10.03.25- limit-uptime=6h name=6yv25 password=6yv25 profile=Paket6jam
/ip hotspot user add comment=vc-608-10.03.25- limit-uptime=6h name=6ft27 password=6ft27 profile=Paket6jam
/ip hotspot user add comment=vc-608-10.03.25- limit-uptime=6h name=6ha49 password=6ha49 profile=Paket6jam
/ip hotspot user add comment=vc-608-10.03.25- limit-uptime=6h name=6wk88 password=6wk88 profile=Paket6jam
/ip hotspot user add comment=vc-608-10.03.25- limit-uptime=6h name=6ht24 password=6ht24 profile=Paket6jam
/ip hotspot user add comment=vc-608-10.03.25- limit-uptime=6h name=6sr44 password=6sr44 profile=Paket6jam
/ip hotspot user add comment=vc-608-10.03.25- limit-uptime=6h name=6ge68 password=6ge68 profile=Paket6jam
/ip hotspot user add comment=vc-608-10.03.25- limit-uptime=6h name=6ds92 password=6ds92 profile=Paket6jam
/ip hotspot user add comment=vc-608-10.03.25- limit-uptime=6h name=6ie83 password=6ie83 profile=Paket6jam
/ip hotspot user add comment=vc-608-10.03.25- limit-uptime=6h name=6zi24 password=6zi24 profile=Paket6jam
/ip hotspot user add comment=vc-608-10.03.25- limit-uptime=6h name=6pg24 password=6pg24 profile=Paket6jam
/ip hotspot user add comment=vc-608-10.03.25- limit-uptime=6h name=6tf68 password=6tf68 profile=Paket6jam
/ip hotspot user add comment=vc-608-10.03.25- limit-uptime=6h name=6nj68 password=6nj68 profile=Paket6jam
/ip hotspot user add comment=vc-608-10.03.25- limit-uptime=6h name=6fg49 password=6fg49 profile=Paket6jam
/ip hotspot user add comment=vc-608-10.03.25- limit-uptime=6h name=6tv62 password=6tv62 profile=Paket6jam
/ip hotspot user add comment=vc-608-10.03.25- limit-uptime=6h name=6hb63 password=6hb63 profile=Paket6jam
/ip hotspot user add comment=vc-608-10.03.25- limit-uptime=6h name=6te67 password=6te67 profile=Paket6jam
/ip hotspot user add comment=vc-608-10.03.25- limit-uptime=6h name=6xc96 password=6xc96 profile=Paket6jam
/ip hotspot user add comment=vc-608-10.03.25- limit-uptime=6h name=6zf37 password=6zf37 profile=Paket6jam
/ip hotspot user add comment=vc-608-10.03.25- limit-uptime=6h name=6cu62 password=6cu62 profile=Paket6jam
/ip hotspot user add comment=vc-608-10.03.25- limit-uptime=6h name=6mz62 password=6mz62 profile=Paket6jam
/ip hotspot user add comment=vc-608-10.03.25- limit-uptime=6h name=6xv45 password=6xv45 profile=Paket6jam
/ip hotspot user add comment=vc-608-10.03.25- limit-uptime=6h name=6gg87 password=6gg87 profile=Paket6jam
/ip hotspot user add comment=vc-608-10.03.25- limit-uptime=6h name=6vc52 password=6vc52 profile=Paket6jam
/ip hotspot user add comment=vc-608-10.03.25- limit-uptime=6h name=6xy56 password=6xy56 profile=Paket6jam
/ip hotspot user add comment=vc-608-10.03.25- limit-uptime=6h name=6vx63 password=6vx63 profile=Paket6jam
/ip hotspot user add comment=vc-608-10.03.25- limit-uptime=6h name=6kf44 password=6kf44 profile=Paket6jam
/ip hotspot user add comment=vc-608-10.03.25- limit-uptime=6h name=6ss57 password=6ss57 profile=Paket6jam
/ip hotspot user add comment=vc-608-10.03.25- limit-uptime=6h name=6iv94 password=6iv94 profile=Paket6jam
/ip hotspot user add comment=vc-608-10.03.25- limit-uptime=6h name=6az96 password=6az96 profile=Paket6jam
/ip hotspot user add comment=vc-608-10.03.25- limit-uptime=6h name=6ks39 password=6ks39 profile=Paket6jam
/ip hotspot user add comment=vc-608-10.03.25- limit-uptime=6h name=6ee25 password=6ee25 profile=Paket6jam
/ip hotspot user add comment=vc-608-10.03.25- limit-uptime=6h name=6rb25 password=6rb25 profile=Paket6jam
/ip hotspot user add comment=vc-608-10.03.25- limit-uptime=6h name=6hx92 password=6hx92 profile=Paket6jam
/ip hotspot user add comment=vc-608-10.03.25- limit-uptime=6h name=6ac53 password=6ac53 profile=Paket6jam
/ip hotspot user add comment=vc-608-10.03.25- limit-uptime=6h name=6bc36 password=6bc36 profile=Paket6jam
/ip hotspot user add comment=vc-608-10.03.25- limit-uptime=6h name=6yp79 password=6yp79 profile=Paket6jam
/ip hotspot user add comment=vc-608-10.03.25- limit-uptime=6h name=6ma45 password=6ma45 profile=Paket6jam
/ip hotspot user add comment=vc-608-10.03.25- limit-uptime=6h name=6vf96 password=6vf96 profile=Paket6jam
/ip hotspot user add comment=vc-608-10.03.25- limit-uptime=6h name=6hv57 password=6hv57 profile=Paket6jam
/ip hotspot user add comment=vc-608-10.03.25- limit-uptime=6h name=6jj39 password=6jj39 profile=Paket6jam
/ip hotspot user add disabled=yes name=tedi password="tedi\$888" profile=KONTRAKAN
/ip hotspot user add comment=vc- name=ATs0fa6eyq password=ATs0fa6eyq profile=V-2000
/ip hotspot user add comment=vc-702-10.26.25- limit-uptime=1h name=1s4n7 password=1s4n7 profile=Paket-1-jam
/ip hotspot user add comment=vc-702-10.26.25- limit-uptime=1h name=1ufg2 password=1ufg2 profile=Paket-1-jam
/ip hotspot user add comment=vc-702-10.26.25- limit-uptime=1h name=12vkm password=12vkm profile=Paket-1-jam
/ip hotspot user add comment=vc-702-10.26.25- limit-uptime=1h name=1d5sb password=1d5sb profile=Paket-1-jam
/ip hotspot user add comment=vc-702-10.26.25- limit-uptime=1h name=1zvte password=1zvte profile=Paket-1-jam
/ip hotspot user add comment=vc-702-10.26.25- limit-uptime=1h name=18rzz password=18rzz profile=Paket-1-jam
/ip hotspot user add comment=vc-702-10.26.25- limit-uptime=1h name=159kf password=159kf profile=Paket-1-jam
/ip hotspot user add comment=vc-702-10.26.25- limit-uptime=1h name=1yekx password=1yekx profile=Paket-1-jam
/ip hotspot user add comment=vc-702-10.26.25- limit-uptime=1h name=1ezei password=1ezei profile=Paket-1-jam
/ip hotspot user add comment=vc-702-10.26.25- limit-uptime=1h name=1r89i password=1r89i profile=Paket-1-jam
/ip hotspot user add comment=vc-702-10.26.25- limit-uptime=1h name=1hm2b password=1hm2b profile=Paket-1-jam
/ip hotspot user add comment=vc-702-10.26.25- limit-uptime=1h name=176ax password=176ax profile=Paket-1-jam
/ip hotspot user add comment=vc-702-10.26.25- limit-uptime=1h name=129g7 password=129g7 profile=Paket-1-jam
/ip hotspot user add comment=vc-702-10.26.25- limit-uptime=1h name=1p5s3 password=1p5s3 profile=Paket-1-jam
/ip hotspot user add comment=vc-702-10.26.25- limit-uptime=1h name=1putk password=1putk profile=Paket-1-jam
/ip hotspot user add comment=vc-702-10.26.25- limit-uptime=1h name=1kf7h password=1kf7h profile=Paket-1-jam
/ip hotspot user add comment=vc-702-10.26.25- limit-uptime=1h name=1xzdm password=1xzdm profile=Paket-1-jam
/ip hotspot user add comment=vc-702-10.26.25- limit-uptime=1h name=14ew4 password=14ew4 profile=Paket-1-jam
/ip hotspot user add comment=vc-702-10.26.25- limit-uptime=1h name=1h9h6 password=1h9h6 profile=Paket-1-jam
/ip hotspot user add comment=vc-702-10.26.25- limit-uptime=1h name=1ffud password=1ffud profile=Paket-1-jam
/ip hotspot user add comment=vc-702-10.26.25- limit-uptime=1h name=1ih6h password=1ih6h profile=Paket-1-jam
/ip hotspot user add comment=vc-702-10.26.25- limit-uptime=1h name=1j77c password=1j77c profile=Paket-1-jam
/ip hotspot user add comment=vc-702-10.26.25- limit-uptime=1h name=12wyk password=12wyk profile=Paket-1-jam
/ip hotspot user add comment=vc-702-10.26.25- limit-uptime=1h name=1hpad password=1hpad profile=Paket-1-jam
/ip hotspot user add comment=vc-702-10.26.25- limit-uptime=1h name=1zmb7 password=1zmb7 profile=Paket-1-jam
/ip hotspot user add comment=vc-702-10.26.25- limit-uptime=1h name=1wuw5 password=1wuw5 profile=Paket-1-jam
/ip hotspot user add comment=vc-702-10.26.25- limit-uptime=1h name=14bj6 password=14bj6 profile=Paket-1-jam
/ip hotspot user add comment=vc-702-10.26.25- limit-uptime=1h name=1b6jf password=1b6jf profile=Paket-1-jam
/ip hotspot user add comment=vc-702-10.26.25- limit-uptime=1h name=1fncs password=1fncs profile=Paket-1-jam
/ip hotspot user add comment=vc-702-10.26.25- limit-uptime=1h name=1rm4c password=1rm4c profile=Paket-1-jam
/ip hotspot user add comment=vc-702-10.26.25- limit-uptime=1h name=1pbt5 password=1pbt5 profile=Paket-1-jam
/ip hotspot user add comment=vc-702-10.26.25- limit-uptime=1h name=1h93w password=1h93w profile=Paket-1-jam
/ip hotspot user add comment=vc-702-10.26.25- limit-uptime=1h name=1b9d6 password=1b9d6 profile=Paket-1-jam
/ip hotspot user add comment=vc- name=ATugs5accn password=ATugs5accn profile=V-6000
/ip hotspot user add comment=up-414-11.07.25- name=utrj password=2968
/ip hotspot user add comment=vc-432-11.07.25- limit-uptime=6h name=6pe33 password=6pe33 profile=Paket6jam
/ip hotspot user add comment=vc-432-11.07.25- limit-uptime=6h name=6na92 password=6na92 profile=Paket6jam
/ip hotspot user add comment=vc-432-11.07.25- limit-uptime=6h name=6aj67 password=6aj67 profile=Paket6jam
/ip hotspot user add comment=vc-432-11.07.25- limit-uptime=6h name=6fz43 password=6fz43 profile=Paket6jam
/ip hotspot user add comment=vc-432-11.07.25- limit-uptime=6h name=6ih77 password=6ih77 profile=Paket6jam
/ip hotspot user add comment=vc-432-11.07.25- limit-uptime=6h name=6ge49 password=6ge49 profile=Paket6jam
/ip hotspot user add comment=vc-292-11.07.25- limit-uptime=2h name=2ei84 password=2ei84 profile=Paket2jam
/ip hotspot user add comment=vc-292-11.07.25- limit-uptime=2h name=2xh74 password=2xh74 profile=Paket2jam
/ip hotspot user add comment=vc-292-11.07.25- limit-uptime=2h name=2rx98 password=2rx98 profile=Paket2jam
/ip hotspot user add comment=vc-292-11.07.25- limit-uptime=2h name=2xi27 password=2xi27 profile=Paket2jam
/ip hotspot user add comment=vc-292-11.07.25- limit-uptime=2h name=2gt86 password=2gt86 profile=Paket2jam
/ip hotspot user add comment=vc-292-11.07.25- limit-uptime=2h name=2yv47 password=2yv47 profile=Paket2jam
/ip hotspot user add comment=vc-292-11.07.25- limit-uptime=2h name=2di74 password=2di74 profile=Paket2jam
/ip hotspot user add comment=vc-292-11.07.25- limit-uptime=2h name=2vy34 password=2vy34 profile=Paket2jam
/ip hotspot user add comment=vc-292-11.07.25- limit-uptime=2h name=2hg22 password=2hg22 profile=Paket2jam
/ip hotspot user add comment=vc-292-11.07.25- limit-uptime=2h name=2vr63 password=2vr63 profile=Paket2jam
/ip hotspot user add comment=vc-292-11.07.25- limit-uptime=2h name=2tb43 password=2tb43 profile=Paket2jam
/ip hotspot user add comment=vc-292-11.07.25- limit-uptime=2h name=2xa92 password=2xa92 profile=Paket2jam
/ip hotspot user add comment=vc-292-11.07.25- limit-uptime=2h name=2nz86 password=2nz86 profile=Paket2jam
/ip hotspot user add comment=vc-292-11.07.25- limit-uptime=2h name=2fb59 password=2fb59 profile=Paket2jam
/ip hotspot user add comment=vc-292-11.07.25- limit-uptime=2h name=2wa22 password=2wa22 profile=Paket2jam
/ip hotspot user add comment=vc-292-11.07.25- limit-uptime=2h name=2fs42 password=2fs42 profile=Paket2jam
/ip hotspot user add comment=vc-292-11.07.25- limit-uptime=2h name=2ux42 password=2ux42 profile=Paket2jam
/ip hotspot user add comment=vc-292-11.07.25- limit-uptime=2h name=2zj94 password=2zj94 profile=Paket2jam
/ip hotspot user add comment=vc-292-11.07.25- limit-uptime=2h name=2bg56 password=2bg56 profile=Paket2jam
/ip hotspot user add comment=vc-292-11.07.25- limit-uptime=2h name=2vk94 password=2vk94 profile=Paket2jam
/ip hotspot user add comment=vc-292-11.07.25- limit-uptime=2h name=2km65 password=2km65 profile=Paket2jam
/ip hotspot user add comment=vc-292-11.07.25- limit-uptime=2h name=2ji98 password=2ji98 profile=Paket2jam
/ip hotspot user add comment=vc-292-11.07.25- limit-uptime=2h name=2ak82 password=2ak82 profile=Paket2jam
/ip hotspot user add comment=vc-292-11.07.25- limit-uptime=2h name=2vd66 password=2vd66 profile=Paket2jam
/ip hotspot user add comment=vc-292-11.07.25- limit-uptime=2h name=2xm45 password=2xm45 profile=Paket2jam
/ip hotspot user add comment=vc-292-11.07.25- limit-uptime=2h name=2jg63 password=2jg63 profile=Paket2jam
/ip hotspot user add comment=vc-292-11.07.25- limit-uptime=2h name=2tr56 password=2tr56 profile=Paket2jam
/ip hotspot user add comment=vc-292-11.07.25- limit-uptime=2h name=2bb22 password=2bb22 profile=Paket2jam
/ip hotspot user add comment=vc-292-11.07.25- limit-uptime=2h name=2zr53 password=2zr53 profile=Paket2jam
/ip hotspot user add comment=vc-292-11.07.25- limit-uptime=2h name=2rd24 password=2rd24 profile=Paket2jam
/ip hotspot user add comment=vc-292-11.07.25- limit-uptime=2h name=2fm67 password=2fm67 profile=Paket2jam
/ip hotspot user add comment=vc-292-11.07.25- limit-uptime=2h name=2vd68 password=2vd68 profile=Paket2jam
/ip hotspot user add comment=vc-292-11.07.25- limit-uptime=2h name=2xz53 password=2xz53 profile=Paket2jam
/ip hotspot user add comment=vc-292-11.07.25- limit-uptime=2h name=2bt55 password=2bt55 profile=Paket2jam
/ip hotspot user add comment=vc-292-11.07.25- limit-uptime=2h name=2tk99 password=2tk99 profile=Paket2jam
/ip hotspot user add comment=vc-292-11.07.25- limit-uptime=2h name=2rn57 password=2rn57 profile=Paket2jam
/ip hotspot user add comment=vc-292-11.07.25- limit-uptime=2h name=2zb27 password=2zb27 profile=Paket2jam
/ip hotspot user add comment=vc-292-11.07.25- limit-uptime=2h name=2az54 password=2az54 profile=Paket2jam
/ip hotspot user add comment=vc-292-11.07.25- limit-uptime=2h name=2it74 password=2it74 profile=Paket2jam
/ip hotspot user add comment=vc-292-11.07.25- limit-uptime=2h name=2wh37 password=2wh37 profile=Paket2jam
/ip hotspot user add name=RENDY password="888\$rendy" profile="1BULAN 1ORANG" server=hs-MASTER
/ip hotspot user add comment=vc- name=ATmzbfgsob password=ATmzbfgsob profile=V-2000
/ip hotspot user add comment=vc- name=ATuvevxb8q password=ATuvevxb8q profile=V-2000
/ip hotspot user add comment=up-424-12.04.25- name=jikp password=4887
/ip hotspot user add comment=up-525-12.04.25- name=zgjj password=9442
/ip hotspot user add comment=vc-383-12.04.25- limit-uptime=1h name=1f3c9 password=1f3c9 profile=Paket-1-jam
/ip hotspot user add comment=vc-383-12.04.25- limit-uptime=1h name=1zbih password=1zbih profile=Paket-1-jam
/ip hotspot user add comment=vc-383-12.04.25- limit-uptime=1h name=1imb6 password=1imb6 profile=Paket-1-jam
/ip hotspot user add comment=vc-383-12.04.25- limit-uptime=1h name=1emuu password=1emuu profile=Paket-1-jam
/ip hotspot user add comment=vc-383-12.04.25- limit-uptime=1h name=1gsey password=1gsey profile=Paket-1-jam
/ip hotspot user add comment=vc-383-12.04.25- limit-uptime=1h name=1esbz password=1esbz profile=Paket-1-jam
/ip hotspot user add comment=vc-383-12.04.25- limit-uptime=1h name=1kmgb password=1kmgb profile=Paket-1-jam
/ip hotspot user add comment=vc-383-12.04.25- limit-uptime=1h name=1i5ey password=1i5ey profile=Paket-1-jam
/ip hotspot user add comment=vc-383-12.04.25- limit-uptime=1h name=1a2d9 password=1a2d9 profile=Paket-1-jam
/ip hotspot user add comment=vc-383-12.04.25- limit-uptime=1h name=18pbp password=18pbp profile=Paket-1-jam
/ip hotspot user add comment=vc-383-12.04.25- limit-uptime=1h name=1afw8 password=1afw8 profile=Paket-1-jam
/ip hotspot user add comment=vc-383-12.04.25- limit-uptime=1h name=1rc6h password=1rc6h profile=Paket-1-jam
/ip hotspot user add comment=vc-383-12.04.25- limit-uptime=1h name=1ac4s password=1ac4s profile=Paket-1-jam
/ip hotspot user add comment=vc-383-12.04.25- limit-uptime=1h name=1db4f password=1db4f profile=Paket-1-jam
/ip hotspot user add comment=vc-383-12.04.25- limit-uptime=1h name=1tek7 password=1tek7 profile=Paket-1-jam
/ip hotspot user add comment=vc-383-12.04.25- limit-uptime=1h name=19pzv password=19pzv profile=Paket-1-jam
/ip hotspot user add comment=vc-383-12.04.25- limit-uptime=1h name=12bkp password=12bkp profile=Paket-1-jam
/ip hotspot user add comment=vc-383-12.04.25- limit-uptime=1h name=14gi7 password=14gi7 profile=Paket-1-jam
/ip hotspot user add comment=vc-383-12.04.25- limit-uptime=1h name=1yemy password=1yemy profile=Paket-1-jam
/ip hotspot user add comment=vc-383-12.04.25- limit-uptime=1h name=1htwi password=1htwi profile=Paket-1-jam
/ip hotspot user add comment=up-426-12.04.25- name=bzcv password=7345
/ip hotspot user add comment=vc-348-12.04.25- limit-uptime=2h name=2cvzv password=2cvzv profile=Paket2jam
/ip hotspot user add comment=vc-348-12.04.25- limit-uptime=2h name=2au8e password=2au8e profile=Paket2jam
/ip hotspot user add comment=vc-348-12.04.25- limit-uptime=2h name=2245p password=2245p profile=Paket2jam
/ip hotspot user add comment=vc-348-12.04.25- limit-uptime=2h name=25j8f password=25j8f profile=Paket2jam
/ip hotspot user add comment=vc-348-12.04.25- limit-uptime=2h name=285cr password=285cr profile=Paket2jam
/ip hotspot user add comment=vc-348-12.04.25- limit-uptime=2h name=2ifti password=2ifti profile=Paket2jam
/ip hotspot user add comment=vc-348-12.04.25- limit-uptime=2h name=2xxdr password=2xxdr profile=Paket2jam
/ip hotspot user add comment=vc-348-12.04.25- limit-uptime=2h name=22e72 password=22e72 profile=Paket2jam
/ip hotspot user add comment=vc-348-12.04.25- limit-uptime=2h name=2ubdg password=2ubdg profile=Paket2jam
/ip hotspot user add comment=vc-348-12.04.25- limit-uptime=2h name=2ynu2 password=2ynu2 profile=Paket2jam
/ip hotspot user add comment=vc-348-12.04.25- limit-uptime=2h name=2c24g password=2c24g profile=Paket2jam
/ip hotspot user add comment=vc-348-12.04.25- limit-uptime=2h name=2b7zw password=2b7zw profile=Paket2jam
/ip hotspot user add comment=vc-348-12.04.25- limit-uptime=2h name=2ecd3 password=2ecd3 profile=Paket2jam
/ip hotspot user add comment=vc-348-12.04.25- limit-uptime=2h name=27bcf password=27bcf profile=Paket2jam
/ip hotspot user add comment=vc-348-12.04.25- limit-uptime=2h name=2wjte password=2wjte profile=Paket2jam
/ip hotspot user add comment=vc-348-12.04.25- limit-uptime=2h name=2f4k9 password=2f4k9 profile=Paket2jam
/ip hotspot user add comment=vc-193-12.04.25- limit-uptime=6h name=6gvcg password=6gvcg profile=Paket6jam
/ip hotspot user add comment=vc-193-12.04.25- limit-uptime=6h name=6z7b2 password=6z7b2 profile=Paket6jam
/ip hotspot user add comment=vc-193-12.04.25- limit-uptime=6h name=6azwi password=6azwi profile=Paket6jam
/ip hotspot user add comment=vc-193-12.04.25- limit-uptime=6h name=6es3x password=6es3x profile=Paket6jam
/ip hotspot user add comment=vc-193-12.04.25- limit-uptime=6h name=6rc4x password=6rc4x profile=Paket6jam
/ip hotspot user add comment=vc-193-12.04.25- limit-uptime=6h name=6u6m5 password=6u6m5 profile=Paket6jam
/ip hotspot user add comment=vc-193-12.04.25- limit-uptime=6h name=66gxj password=66gxj profile=Paket6jam
/ip hotspot user add comment=vc-193-12.04.25- limit-uptime=6h name=6778u password=6778u profile=Paket6jam
/ip hotspot user add comment=vc-193-12.04.25- limit-uptime=6h name=6rjyu password=6rjyu profile=Paket6jam
/ip hotspot user add comment=vc-193-12.04.25- limit-uptime=6h name=67w97 password=67w97 profile=Paket6jam
/ip hotspot user add comment=vc-193-12.04.25- limit-uptime=6h name=6zfba password=6zfba profile=Paket6jam
/ip hotspot user add comment=vc- name=ATzk6vyiie password=ATzk6vyiie profile=V-2000
/ip hotspot user add disabled=yes name=AJI password="888\$AJI" profile="1BULAN 1ORANG"
/ip hotspot user add comment=vc- name=AThalz2pfi password=AThalz2pfi profile=V-6000
/ip hotspot user add comment=vc- name=AT6ipr6lla password=AT6ipr6lla profile=V-6000
/ip hotspot user add comment=vc- name=ATzs1sszq5 password=ATzs1sszq5 profile=V-2000
/ip hotspot user add comment=vc- name=ATslk7vbbn password=ATslk7vbbn profile=V-2000
/ip hotspot user add comment=vc- name=AT4p61zv4a password=AT4p61zv4a profile=V-2000
/ip hotspot user add comment=vc- name=ATkjaruenf password=ATkjaruenf profile=V-3500
/ip hotspot user add comment=vc-954-01.09.26- limit-uptime=6h name=6neb8 password=6neb8 profile=Paket6jam
/ip hotspot user add comment=vc-954-01.09.26- limit-uptime=6h name=6h347 password=6h347 profile=Paket6jam
/ip hotspot user add comment=vc-954-01.09.26- limit-uptime=6h name=6xskz password=6xskz profile=Paket6jam
/ip hotspot user add comment=vc-954-01.09.26- limit-uptime=6h name=6d85v password=6d85v profile=Paket6jam
/ip hotspot user add comment=vc-954-01.09.26- limit-uptime=6h name=6speb password=6speb profile=Paket6jam
/ip hotspot user add comment=vc-954-01.09.26- limit-uptime=6h name=6bmd7 password=6bmd7 profile=Paket6jam
/ip hotspot user add comment=vc-954-01.09.26- limit-uptime=6h name=63988 password=63988 profile=Paket6jam
/ip hotspot user add comment=vc-954-01.09.26- limit-uptime=6h name=6eerr password=6eerr profile=Paket6jam
/ip hotspot user add comment=vc-954-01.09.26- limit-uptime=6h name=68b6m password=68b6m profile=Paket6jam
/ip hotspot user add comment=vc-954-01.09.26- limit-uptime=6h name=6chyr password=6chyr profile=Paket6jam
/ip hotspot user add comment=vc-954-01.09.26- limit-uptime=6h name=6icbp password=6icbp profile=Paket6jam
/ip hotspot user add comment=vc-954-01.09.26- limit-uptime=6h name=6rfmf password=6rfmf profile=Paket6jam
/ip hotspot user add comment=vc-954-01.09.26- limit-uptime=6h name=6u3hu password=6u3hu profile=Paket6jam
/ip hotspot user add comment=vc-954-01.09.26- limit-uptime=6h name=6psai password=6psai profile=Paket6jam
/ip hotspot user add comment=vc-954-01.09.26- limit-uptime=6h name=6dng9 password=6dng9 profile=Paket6jam
/ip hotspot user add comment=vc-954-01.09.26- limit-uptime=6h name=6htn7 password=6htn7 profile=Paket6jam
/ip hotspot user add comment=vc-954-01.09.26- limit-uptime=6h name=6k4u6 password=6k4u6 profile=Paket6jam
/ip hotspot user add comment=vc-954-01.09.26- limit-uptime=6h name=6xy24 password=6xy24 profile=Paket6jam
/ip hotspot user add comment=vc-954-01.09.26- limit-uptime=6h name=6pge7 password=6pge7 profile=Paket6jam
/ip hotspot user add comment=vc-954-01.09.26- limit-uptime=6h name=6x555 password=6x555 profile=Paket6jam
/ip hotspot user add comment=vc-954-01.09.26- limit-uptime=6h name=6uieb password=6uieb profile=Paket6jam
/ip hotspot user add comment=vc-954-01.09.26- limit-uptime=6h name=6pd4y password=6pd4y profile=Paket6jam
/ip hotspot user add comment=vc-954-01.09.26- limit-uptime=6h name=632df password=632df profile=Paket6jam
/ip hotspot user add comment=vc-954-01.09.26- limit-uptime=6h name=6tucr password=6tucr profile=Paket6jam
/ip hotspot user add comment=vc-954-01.09.26- limit-uptime=6h name=6ra9m password=6ra9m profile=Paket6jam
/ip hotspot user add comment=vc-954-01.09.26- limit-uptime=6h name=6hprk password=6hprk profile=Paket6jam
/ip hotspot user add comment=vc-140-01.09.26- limit-uptime=2h name=26y6r password=26y6r profile=Paket2jam
/ip hotspot user add comment=vc-140-01.09.26- limit-uptime=2h name=2wite password=2wite profile=Paket2jam
/ip hotspot user add comment=vc-140-01.09.26- limit-uptime=2h name=2rnnv password=2rnnv profile=Paket2jam
/ip hotspot user add comment=vc-140-01.09.26- limit-uptime=2h name=2u8ng password=2u8ng profile=Paket2jam
/ip hotspot user add comment=vc-140-01.09.26- limit-uptime=2h name=2yev2 password=2yev2 profile=Paket2jam
/ip hotspot user add comment=vc-140-01.09.26- limit-uptime=2h name=2eskh password=2eskh profile=Paket2jam
/ip hotspot user add comment=vc-140-01.09.26- limit-uptime=2h name=2gnif password=2gnif profile=Paket2jam
/ip hotspot user add comment=vc-140-01.09.26- limit-uptime=2h name=2rnzj password=2rnzj profile=Paket2jam
/ip hotspot user add comment=vc-140-01.09.26- limit-uptime=2h name=27xhp password=27xhp profile=Paket2jam
/ip hotspot user add comment=vc-140-01.09.26- limit-uptime=2h name=2z6dx password=2z6dx profile=Paket2jam
/ip hotspot user add comment=vc-140-01.09.26- limit-uptime=2h name=2y6ck password=2y6ck profile=Paket2jam
/ip hotspot user add comment=vc-140-01.09.26- limit-uptime=2h name=25sba password=25sba profile=Paket2jam
/ip hotspot user add comment=vc-140-01.09.26- limit-uptime=2h name=2zx9g password=2zx9g profile=Paket2jam
/ip hotspot user add comment=vc-140-01.09.26- limit-uptime=2h name=2yjxh password=2yjxh profile=Paket2jam
/ip hotspot user add comment=vc-140-01.09.26- limit-uptime=2h name=28knc password=28knc profile=Paket2jam
/ip hotspot user add comment=vc-140-01.09.26- limit-uptime=2h name=2ia3k password=2ia3k profile=Paket2jam
/ip hotspot user add comment=vc-140-01.09.26- limit-uptime=2h name=2mej4 password=2mej4 profile=Paket2jam
/ip hotspot user add comment=vc-140-01.09.26- limit-uptime=2h name=2nued password=2nued profile=Paket2jam
/ip hotspot user add comment=vc-140-01.09.26- limit-uptime=2h name=2y46b password=2y46b profile=Paket2jam
/ip hotspot user add comment=vc-140-01.09.26- limit-uptime=2h name=2adjg password=2adjg profile=Paket2jam
/ip hotspot user add comment=vc-140-01.09.26- limit-uptime=2h name=286vx password=286vx profile=Paket2jam
/ip hotspot user add comment=vc-140-01.09.26- limit-uptime=2h name=2wycp password=2wycp profile=Paket2jam
/ip hotspot user add comment=vc-140-01.09.26- limit-uptime=2h name=2ypjd password=2ypjd profile=Paket2jam
/ip hotspot user add comment=vc-140-01.09.26- limit-uptime=2h name=2zrb4 password=2zrb4 profile=Paket2jam
/ip hotspot user add comment=vc-140-01.09.26- limit-uptime=2h name=2x2uw password=2x2uw profile=Paket2jam
/ip hotspot user add comment=vc-140-01.09.26- limit-uptime=2h name=2hh3p password=2hh3p profile=Paket2jam
/ip hotspot user add comment=vc-140-01.09.26- limit-uptime=2h name=25vsh password=25vsh profile=Paket2jam
/ip hotspot user add comment=vc-140-01.09.26- limit-uptime=2h name=297yp password=297yp profile=Paket2jam
/ip hotspot user add comment=vc- name=AT5vievs3i password=AT5vievs3i profile=V-3500
/ip hotspot user add disabled=yes name=888marwiyah password=888marwiyah profile="1BULAN 1ORANG" server=hs-MASTER
/ip hotspot user add comment=vc- name=ATiipqf60r password=ATiipqf60r profile=V-2000
/ip hotspot user add comment=vc- name=AT68xdqj34 password=AT68xdqj34 profile=V-2000
/ip hotspot user add disabled=yes name=888arsil password=888arsil profile=KONTRAKAN server=hs-MASTER
/ip hotspot user add comment=vc-311-02.01.26- limit-uptime=2h name=2ns24 password=2ns24 profile=Paket2jam
/ip hotspot user add comment=vc-311-02.01.26- limit-uptime=2h name=2zu76 password=2zu76 profile=Paket2jam
/ip hotspot user add comment=vc-311-02.01.26- limit-uptime=2h name=2xg66 password=2xg66 profile=Paket2jam
/ip hotspot user add comment=vc-311-02.01.26- limit-uptime=2h name=2ve67 password=2ve67 profile=Paket2jam
/ip hotspot user add comment=vc-311-02.01.26- limit-uptime=2h name=2ga48 password=2ga48 profile=Paket2jam
/ip hotspot user add comment=vc-311-02.01.26- limit-uptime=2h name=2ja77 password=2ja77 profile=Paket2jam
/ip hotspot user add comment=vc-311-02.01.26- limit-uptime=2h name=2wx43 password=2wx43 profile=Paket2jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1vr59 password=1vr59 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1xs75 password=1xs75 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1wh94 password=1wh94 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1gs79 password=1gs79 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ev28 password=1ev28 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1js56 password=1js56 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1su95 password=1su95 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1sv77 password=1sv77 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1um68 password=1um68 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1xw82 password=1xw82 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ed85 password=1ed85 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ru85 password=1ru85 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1mt26 password=1mt26 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1mm88 password=1mm88 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1jt37 password=1jt37 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1be39 password=1be39 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1im88 password=1im88 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1jf29 password=1jf29 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1yy65 password=1yy65 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1bc44 password=1bc44 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1kv65 password=1kv65 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1wr82 password=1wr82 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ah29 password=1ah29 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1im48 password=1im48 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1xg77 password=1xg77 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1pt27 password=1pt27 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ax77 password=1ax77 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ad95 password=1ad95 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1sx54 password=1sx54 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1vy82 password=1vy82 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1mu76 password=1mu76 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1cc49 password=1cc49 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1jv46 password=1jv46 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1hs27 password=1hs27 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1av62 password=1av62 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1uf48 password=1uf48 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1wg49 password=1wg49 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1sj84 password=1sj84 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1rg83 password=1rg83 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1cw93 password=1cw93 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1rg36 password=1rg36 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1iu84 password=1iu84 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1tb35 password=1tb35 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1cr23 password=1cr23 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1hv44 password=1hv44 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1fv86 password=1fv86 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1bt56 password=1bt56 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ha32 password=1ha32 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1us39 password=1us39 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1vi66 password=1vi66 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1js46 password=1js46 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1pf98 password=1pf98 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ic87 password=1ic87 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1xf43 password=1xf43 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1tm97 password=1tm97 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ph23 password=1ph23 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1zr84 password=1zr84 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ce59 password=1ce59 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1af45 password=1af45 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1vh96 password=1vh96 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1vm96 password=1vm96 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ub93 password=1ub93 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ab95 password=1ab95 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1wi96 password=1wi96 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1sb75 password=1sb75 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1cc38 password=1cc38 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1dh86 password=1dh86 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1mx92 password=1mx92 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1pg29 password=1pg29 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1zz36 password=1zz36 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ip24 password=1ip24 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1dm34 password=1dm34 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1wx53 password=1wx53 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1wh66 password=1wh66 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1kz34 password=1kz34 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ux75 password=1ux75 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1xw64 password=1xw64 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1mr38 password=1mr38 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ea82 password=1ea82 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ss89 password=1ss89 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1yv65 password=1yv65 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1xv64 password=1xv64 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1vc78 password=1vc78 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1pm79 password=1pm79 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1zn88 password=1zn88 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1xc97 password=1xc97 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1cb22 password=1cb22 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1tp25 password=1tp25 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1my85 password=1my85 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1hp79 password=1hp79 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1hi37 password=1hi37 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1sr87 password=1sr87 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ms97 password=1ms97 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1er86 password=1er86 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1rv33 password=1rv33 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ep48 password=1ep48 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1yw56 password=1yw56 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ru47 password=1ru47 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1zb58 password=1zb58 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1th97 password=1th97 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1yu44 password=1yu44 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ji22 password=1ji22 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ka39 password=1ka39 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1dy42 password=1dy42 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1sc45 password=1sc45 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1hf27 password=1hf27 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1fe45 password=1fe45 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1wy52 password=1wy52 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1yy89 password=1yy89 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1fj98 password=1fj98 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1xx84 password=1xx84 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1kr34 password=1kr34 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1df68 password=1df68 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1eh58 password=1eh58 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ud82 password=1ud82 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ne33 password=1ne33 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1tp96 password=1tp96 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1in65 password=1in65 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1js58 password=1js58 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1tx36 password=1tx36 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1dd63 password=1dd63 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1xv24 password=1xv24 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1wp87 password=1wp87 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1jh83 password=1jh83 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1mj37 password=1mj37 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ai34 password=1ai34 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1wn26 password=1wn26 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1kp95 password=1kp95 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1dn69 password=1dn69 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1sh48 password=1sh48 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1zw28 password=1zw28 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1nm82 password=1nm82 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1xk97 password=1xk97 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1iz82 password=1iz82 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1nb23 password=1nb23 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1vb27 password=1vb27 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1xb89 password=1xb89 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1tg64 password=1tg64 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ih27 password=1ih27 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1zg53 password=1zg53 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1nf25 password=1nf25 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1if48 password=1if48 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1xx74 password=1xx74 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1cn72 password=1cn72 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1xm57 password=1xm57 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1uk94 password=1uk94 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1cs78 password=1cs78 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1hd84 password=1hd84 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1wj95 password=1wj95 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1it98 password=1it98 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1tu52 password=1tu52 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1wd47 password=1wd47 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ud83 password=1ud83 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1bi28 password=1bi28 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1fn29 password=1fn29 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1cf29 password=1cf29 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1fr83 password=1fr83 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1pr34 password=1pr34 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1yw76 password=1yw76 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1xj26 password=1xj26 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1xx82 password=1xx82 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ry33 password=1ry33 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1uu62 password=1uu62 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1wb49 password=1wb49 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1vm25 password=1vm25 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1yz34 password=1yz34 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ik99 password=1ik99 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1hi96 password=1hi96 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1kd39 password=1kd39 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1zk86 password=1zk86 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ex27 password=1ex27 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ew28 password=1ew28 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1br73 password=1br73 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1nr32 password=1nr32 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1xc69 password=1xc69 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1vj95 password=1vj95 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1hn83 password=1hn83 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1iw46 password=1iw46 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1nc67 password=1nc67 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1wp75 password=1wp75 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1gy69 password=1gy69 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1xd34 password=1xd34 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1cb66 password=1cb66 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1bh73 password=1bh73 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1pd84 password=1pd84 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1wr74 password=1wr74 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1vz58 password=1vz58 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ga53 password=1ga53 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1pn88 password=1pn88 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ss43 password=1ss43 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1gy97 password=1gy97 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ps49 password=1ps49 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1gs54 password=1gs54 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1is64 password=1is64 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1as56 password=1as56 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1hd73 password=1hd73 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1na23 password=1na23 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1de73 password=1de73 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ip84 password=1ip84 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1eg86 password=1eg86 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1iz68 password=1iz68 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1rt76 password=1rt76 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1hk77 password=1hk77 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ra37 password=1ra37 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1nv57 password=1nv57 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1db28 password=1db28 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1gj56 password=1gj56 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ib67 password=1ib67 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1wk74 password=1wk74 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1vt66 password=1vt66 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ee35 password=1ee35 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1tm82 password=1tm82 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1sv68 password=1sv68 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1my47 password=1my47 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1wy87 password=1wy87 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1yk49 password=1yk49 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1eb64 password=1eb64 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1zd66 password=1zd66 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1tj79 password=1tj79 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1cn38 password=1cn38 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1xm66 password=1xm66 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1gr35 password=1gr35 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1iy22 password=1iy22 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1wy96 password=1wy96 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ic73 password=1ic73 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1uz56 password=1uz56 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1cp23 password=1cp23 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1uj56 password=1uj56 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1kw58 password=1kw58 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1sy36 password=1sy36 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1gg56 password=1gg56 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1pr27 password=1pr27 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1aj36 password=1aj36 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1zz79 password=1zz79 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1yh24 password=1yh24 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1dv34 password=1dv34 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1jc29 password=1jc29 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1rx85 password=1rx85 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1jt42 password=1jt42 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1kk44 password=1kk44 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1nc32 password=1nc32 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1pp69 password=1pp69 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1hn52 password=1hn52 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ui99 password=1ui99 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1tg56 password=1tg56 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1zu48 password=1zu48 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1nz39 password=1nz39 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ce83 password=1ce83 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ci95 password=1ci95 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ft83 password=1ft83 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1di47 password=1di47 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1jv49 password=1jv49 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1cn79 password=1cn79 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1mt64 password=1mt64 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1xn25 password=1xn25 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1me44 password=1me44 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1xk77 password=1xk77 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1pa99 password=1pa99 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1et66 password=1et66 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1vw83 password=1vw83 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1wz97 password=1wz97 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ey22 password=1ey22 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1xg57 password=1xg57 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1pt84 password=1pt84 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1tp23 password=1tp23 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1sb46 password=1sb46 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1bj58 password=1bj58 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1rc67 password=1rc67 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ep27 password=1ep27 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1dh44 password=1dh44 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1yj88 password=1yj88 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1sj78 password=1sj78 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1yj73 password=1yj73 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1aj39 password=1aj39 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ia46 password=1ia46 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ui64 password=1ui64 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1bu99 password=1bu99 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1aj83 password=1aj83 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1fy26 password=1fy26 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1wu86 password=1wu86 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ud62 password=1ud62 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1em32 password=1em32 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1as85 password=1as85 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ah82 password=1ah82 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1kz46 password=1kz46 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ud37 password=1ud37 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1kd24 password=1kd24 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ri32 password=1ri32 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1yu27 password=1yu27 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1gr39 password=1gr39 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1be92 password=1be92 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1dt44 password=1dt44 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1sh22 password=1sh22 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1di64 password=1di64 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1yh88 password=1yh88 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1pa96 password=1pa96 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ig74 password=1ig74 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ci98 password=1ci98 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ig26 password=1ig26 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1uy55 password=1uy55 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1hi48 password=1hi48 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ib26 password=1ib26 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1mw88 password=1mw88 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1mn57 password=1mn57 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1cs66 password=1cs66 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1un62 password=1un62 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1eg99 password=1eg99 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1em85 password=1em85 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1xr26 password=1xr26 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1tk69 password=1tk69 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1da95 password=1da95 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1vh25 password=1vh25 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1rc95 password=1rc95 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1nr69 password=1nr69 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ac78 password=1ac78 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1it34 password=1it34 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1wy47 password=1wy47 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1fx53 password=1fx53 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ak25 password=1ak25 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1hm23 password=1hm23 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1rk37 password=1rk37 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ic39 password=1ic39 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1tf88 password=1tf88 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1tg32 password=1tg32 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1vk35 password=1vk35 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ij34 password=1ij34 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1sr66 password=1sr66 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1bj72 password=1bj72 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1td54 password=1td54 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1wz56 password=1wz56 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1bx43 password=1bx43 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1wm93 password=1wm93 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1zt45 password=1zt45 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1sd55 password=1sd55 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1hs83 password=1hs83 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1gh68 password=1gh68 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1fw72 password=1fw72 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1uf43 password=1uf43 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1it99 password=1it99 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1az93 password=1az93 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1mc52 password=1mc52 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ud65 password=1ud65 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1zt55 password=1zt55 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1mp49 password=1mp49 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1rp67 password=1rp67 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1vn46 password=1vn46 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1nh79 password=1nh79 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1eu35 password=1eu35 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1xd82 password=1xd82 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ht57 password=1ht57 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1dm84 password=1dm84 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1uy62 password=1uy62 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1aa48 password=1aa48 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1eb57 password=1eb57 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1pb65 password=1pb65 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1rt78 password=1rt78 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1se89 password=1se89 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1dv25 password=1dv25 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1fw67 password=1fw67 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1wf94 password=1wf94 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1am68 password=1am68 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1wt92 password=1wt92 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1wk83 password=1wk83 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1xs32 password=1xs32 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1gb89 password=1gb89 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1sw47 password=1sw47 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1jm88 password=1jm88 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1sz96 password=1sz96 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1gv62 password=1gv62 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1hn87 password=1hn87 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1rn63 password=1rn63 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1rb84 password=1rb84 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1hx59 password=1hx59 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1es87 password=1es87 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1vc49 password=1vc49 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1mc98 password=1mc98 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1xt52 password=1xt52 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1xf44 password=1xf44 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1up22 password=1up22 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1yj57 password=1yj57 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1wd92 password=1wd92 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1rc74 password=1rc74 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1tc69 password=1tc69 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1dn36 password=1dn36 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1vw77 password=1vw77 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1tc77 password=1tc77 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1bt38 password=1bt38 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1gv76 password=1gv76 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1wm77 password=1wm77 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1st74 password=1st74 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1au77 password=1au77 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1kv69 password=1kv69 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1xe54 password=1xe54 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1vz53 password=1vz53 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1xc72 password=1xc72 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1tw68 password=1tw68 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ee49 password=1ee49 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1xh93 password=1xh93 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ka69 password=1ka69 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1nm83 password=1nm83 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1pp42 password=1pp42 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ka85 password=1ka85 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1jg39 password=1jg39 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1tc64 password=1tc64 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1zm74 password=1zm74 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1dt77 password=1dt77 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1zv36 password=1zv36 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1at46 password=1at46 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ex33 password=1ex33 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1xz35 password=1xz35 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1td59 password=1td59 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1gc43 password=1gc43 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1nc94 password=1nc94 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1gt34 password=1gt34 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1iu83 password=1iu83 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1am97 password=1am97 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1mm74 password=1mm74 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1yc87 password=1yc87 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ec69 password=1ec69 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1tm47 password=1tm47 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1mf99 password=1mf99 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1ym79 password=1ym79 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1zd89 password=1zd89 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1wh93 password=1wh93 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1nt99 password=1nt99 profile=Paket-1-jam
/ip hotspot user add comment=vc-554-02.09.26- limit-uptime=1h name=1pj52 password=1pj52 profile=Paket-1-jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4fa98 password=4fa98 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4rx92 password=4rx92 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4xb42 password=4xb42 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4ps86 password=4ps86 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4cw69 password=4cw69 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4zh28 password=4zh28 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4sy53 password=4sy53 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4bf74 password=4bf74 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4tk44 password=4tk44 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4gg92 password=4gg92 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4tb22 password=4tb22 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4ci79 password=4ci79 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4ux29 password=4ux29 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4yw97 password=4yw97 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4jc58 password=4jc58 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4ec94 password=4ec94 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4as72 password=4as72 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4em33 password=4em33 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4nb92 password=4nb92 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4tf57 password=4tf57 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4nk74 password=4nk74 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4wh93 password=4wh93 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4ks96 password=4ks96 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4kf85 password=4kf85 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4zt48 password=4zt48 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4sc73 password=4sc73 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4et62 password=4et62 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4nz69 password=4nz69 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4ed35 password=4ed35 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4rx24 password=4rx24 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4di33 password=4di33 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4wg86 password=4wg86 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4vj26 password=4vj26 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4fi79 password=4fi79 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4yv87 password=4yv87 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4jf49 password=4jf49 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4fm89 password=4fm89 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4nk49 password=4nk49 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4nb54 password=4nb54 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4fe48 password=4fe48 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4nr74 password=4nr74 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4yj44 password=4yj44 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4dg66 password=4dg66 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4mw93 password=4mw93 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4ka87 password=4ka87 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4ij93 password=4ij93 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4db48 password=4db48 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4ku95 password=4ku95 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4hj43 password=4hj43 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4yz43 password=4yz43 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4en62 password=4en62 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4ge98 password=4ge98 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4gk54 password=4gk54 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4ja57 password=4ja57 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4eg79 password=4eg79 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4ee78 password=4ee78 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4jk93 password=4jk93 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4sa44 password=4sa44 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4gh34 password=4gh34 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4zt37 password=4zt37 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4ep46 password=4ep46 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4ii42 password=4ii42 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4uc33 password=4uc33 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4zu64 password=4zu64 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4dk69 password=4dk69 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4vi64 password=4vi64 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4yf66 password=4yf66 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4nk82 password=4nk82 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4wi99 password=4wi99 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4rb82 password=4rb82 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4mz38 password=4mz38 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4sh88 password=4sh88 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4cv79 password=4cv79 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4ir24 password=4ir24 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4du55 password=4du55 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4sj85 password=4sj85 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4xz62 password=4xz62 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4fn93 password=4fn93 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4tu53 password=4tu53 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4ws67 password=4ws67 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4fi54 password=4fi54 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4ku93 password=4ku93 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4yh33 password=4yh33 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4xi64 password=4xi64 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4yz93 password=4yz93 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4dw52 password=4dw52 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4xz43 password=4xz43 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4rw59 password=4rw59 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4ct68 password=4ct68 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4fy58 password=4fy58 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4fw72 password=4fw72 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4hn75 password=4hn75 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4zp28 password=4zp28 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4jg63 password=4jg63 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4aj85 password=4aj85 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4vj63 password=4vj63 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4ij42 password=4ij42 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4ar49 password=4ar49 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4fc39 password=4fc39 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4wj48 password=4wj48 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4jf85 password=4jf85 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4ba67 password=4ba67 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4fg54 password=4fg54 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4yu84 password=4yu84 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4ri78 password=4ri78 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4wf25 password=4wf25 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4vr23 password=4vr23 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4ix92 password=4ix92 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4xr22 password=4xr22 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4xp82 password=4xp82 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4np67 password=4np67 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4ua97 password=4ua97 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4hp28 password=4hp28 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4kp98 password=4kp98 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4zg95 password=4zg95 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4tp77 password=4tp77 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4ph48 password=4ph48 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4ba26 password=4ba26 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4vp68 password=4vp68 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4xy66 password=4xy66 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4yh25 password=4yh25 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4xu33 password=4xu33 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4fp97 password=4fp97 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4fw82 password=4fw82 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4dd28 password=4dd28 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4ac26 password=4ac26 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4wf32 password=4wf32 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4ur87 password=4ur87 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4tc33 password=4tc33 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4uj25 password=4uj25 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4yc82 password=4yc82 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4pu23 password=4pu23 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4uf57 password=4uf57 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4ur93 password=4ur93 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4bw59 password=4bw59 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4rp73 password=4rp73 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4sp47 password=4sp47 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4hd68 password=4hd68 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4ub56 password=4ub56 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4hz43 password=4hz43 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4hk32 password=4hk32 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4ku97 password=4ku97 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4dm22 password=4dm22 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4wm59 password=4wm59 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4ik36 password=4ik36 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4dx59 password=4dx59 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4xg59 password=4xg59 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4if39 password=4if39 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4mt67 password=4mt67 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4ej89 password=4ej89 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4jb84 password=4jb84 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4hz24 password=4hz24 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4je42 password=4je42 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4xx53 password=4xx53 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4wk77 password=4wk77 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4nt54 password=4nt54 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4bf22 password=4bf22 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4ww24 password=4ww24 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4tr66 password=4tr66 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4td84 password=4td84 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4bn47 password=4bn47 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4hy98 password=4hy98 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4ab78 password=4ab78 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4bp34 password=4bp34 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4xh85 password=4xh85 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4du94 password=4du94 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4ag63 password=4ag63 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4cf37 password=4cf37 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4in76 password=4in76 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4tv64 password=4tv64 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4ty82 password=4ty82 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4wt94 password=4wt94 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4yr88 password=4yr88 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4ws54 password=4ws54 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4jn26 password=4jn26 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4dy82 password=4dy82 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4iv48 password=4iv48 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4te35 password=4te35 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4jm57 password=4jm57 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4dr25 password=4dr25 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4bk59 password=4bk59 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4dj37 password=4dj37 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4gk36 password=4gk36 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4ja72 password=4ja72 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4mm55 password=4mm55 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4dz72 password=4dz72 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4wd32 password=4wd32 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4mv95 password=4mv95 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4nk63 password=4nk63 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4yi66 password=4yi66 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4wk59 password=4wk59 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4ga87 password=4ga87 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4uc58 password=4uc58 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4pz93 password=4pz93 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4nj56 password=4nj56 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4ri35 password=4ri35 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4zv87 password=4zv87 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4um48 password=4um48 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4na34 password=4na34 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4dg93 password=4dg93 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4bf94 password=4bf94 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4da52 password=4da52 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4ak97 password=4ak97 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4dk33 password=4dk33 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4ne26 password=4ne26 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4gb28 password=4gb28 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4bd43 password=4bd43 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4iz52 password=4iz52 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4mn46 password=4mn46 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4am95 password=4am95 profile=Paket6jam
/ip hotspot user add comment=vc-295-02.09.26- limit-uptime=6h name=4ei23 password=4ei23 profile=Paket6jam
/ip hotspot user add comment=vc- name=ATv86ntiek password=ATv86ntiek profile=V-2000
/ip hotspot user add comment=vc-545-03.15.26- limit-uptime=2h name=2ry92 password=2ry92 profile=Paket2jam
/ip hotspot user add comment=vc-545-03.15.26- limit-uptime=2h name=2cw26 password=2cw26 profile=Paket2jam
/ip hotspot user add comment=vc-545-03.15.26- limit-uptime=2h name=2tv28 password=2tv28 profile=Paket2jam
/ip hotspot user add comment=vc-545-03.15.26- limit-uptime=2h name=2bf89 password=2bf89 profile=Paket2jam
/ip hotspot user add comment=vc-545-03.15.26- limit-uptime=2h name=2kk82 password=2kk82 profile=Paket2jam
/ip hotspot user add comment=vc-545-03.15.26- limit-uptime=2h name=2yb72 password=2yb72 profile=Paket2jam
/ip hotspot user add comment=vc-545-03.15.26- limit-uptime=2h name=2vd28 password=2vd28 profile=Paket2jam
/ip hotspot user add comment=vc-545-03.15.26- limit-uptime=2h name=2fz67 password=2fz67 profile=Paket2jam
/ip hotspot user add comment=vc-545-03.15.26- limit-uptime=2h name=2wt23 password=2wt23 profile=Paket2jam
/ip hotspot user add comment=vc-545-03.15.26- limit-uptime=2h name=2um44 password=2um44 profile=Paket2jam
/ip hotspot user add comment=vc-545-03.15.26- limit-uptime=2h name=2xp93 password=2xp93 profile=Paket2jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6ch89 password=6ch89 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6vh23 password=6vh23 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6ek68 password=6ek68 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6ef67 password=6ef67 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6dx78 password=6dx78 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6rt53 password=6rt53 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6bp79 password=6bp79 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6ce49 password=6ce49 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6gr69 password=6gr69 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6yf69 password=6yf69 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6cy62 password=6cy62 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6ps94 password=6ps94 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6sr97 password=6sr97 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6wz76 password=6wz76 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6bm66 password=6bm66 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6ut88 password=6ut88 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6eu36 password=6eu36 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6kv22 password=6kv22 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6uy85 password=6uy85 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6pj75 password=6pj75 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6ec53 password=6ec53 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6nf22 password=6nf22 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6zp29 password=6zp29 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6wg45 password=6wg45 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6pd82 password=6pd82 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6sj24 password=6sj24 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6jp25 password=6jp25 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6fi83 password=6fi83 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6wn78 password=6wn78 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6fx86 password=6fx86 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6cx47 password=6cx47 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6br35 password=6br35 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6ap25 password=6ap25 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6gf26 password=6gf26 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6zh29 password=6zh29 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6ij45 password=6ij45 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6ya67 password=6ya67 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6sb77 password=6sb77 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6sn36 password=6sn36 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6wk23 password=6wk23 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6wm39 password=6wm39 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6ny33 password=6ny33 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6sw68 password=6sw68 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6fs83 password=6fs83 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6kb44 password=6kb44 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6cg26 password=6cg26 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6sm26 password=6sm26 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6ke23 password=6ke23 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6xw86 password=6xw86 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6tk39 password=6tk39 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6zx58 password=6zx58 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6gt32 password=6gt32 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6jw77 password=6jw77 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6sf79 password=6sf79 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6pd99 password=6pd99 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6ap92 password=6ap92 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6wm85 password=6wm85 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6rk48 password=6rk48 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6xc63 password=6xc63 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6xw59 password=6xw59 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6zr38 password=6zr38 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6dv87 password=6dv87 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6jh99 password=6jh99 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6eu45 password=6eu45 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6hf62 password=6hf62 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6hf45 password=6hf45 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6di45 password=6di45 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6nm53 password=6nm53 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6tb69 password=6tb69 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6vi42 password=6vi42 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6pm74 password=6pm74 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6dk59 password=6dk59 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6ay26 password=6ay26 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6je45 password=6je45 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6xx73 password=6xx73 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6aj63 password=6aj63 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6uv57 password=6uv57 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6rv49 password=6rv49 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6wn22 password=6wn22 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6wc65 password=6wc65 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6rh59 password=6rh59 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6xc74 password=6xc74 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6ue53 password=6ue53 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6zg36 password=6zg36 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6if48 password=6if48 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6pd22 password=6pd22 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6ws69 password=6ws69 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6ha86 password=6ha86 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6uk69 password=6uk69 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6ju63 password=6ju63 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6wa58 password=6wa58 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6et44 password=6et44 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6mv59 password=6mv59 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6tw52 password=6tw52 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6dg63 password=6dg63 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6zr42 password=6zr42 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6zt93 password=6zt93 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6ms44 password=6ms44 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6pj38 password=6pj38 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6ix86 password=6ix86 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6ay62 password=6ay62 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6ji99 password=6ji99 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6gg86 password=6gg86 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6kk56 password=6kk56 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6ju64 password=6ju64 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6ig76 password=6ig76 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6rs27 password=6rs27 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6eg62 password=6eg62 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6na37 password=6na37 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6cd74 password=6cd74 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6cc36 password=6cc36 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6kw26 password=6kw26 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6wp24 password=6wp24 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6hm75 password=6hm75 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6gn57 password=6gn57 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6ts67 password=6ts67 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6jc38 password=6jc38 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6dy22 password=6dy22 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6yv22 password=6yv22 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6ik85 password=6ik85 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6hf94 password=6hf94 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6eh53 password=6eh53 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6gx34 password=6gx34 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6bn35 password=6bn35 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6dv23 password=6dv23 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6fp74 password=6fp74 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6ck94 password=6ck94 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6wj49 password=6wj49 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6nk37 password=6nk37 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6gs47 password=6gs47 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6fi84 password=6fi84 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6cp46 password=6cp46 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6vz74 password=6vz74 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6tz27 password=6tz27 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6dx62 password=6dx62 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6hd84 password=6hd84 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6vk97 password=6vk97 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6vv68 password=6vv68 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6sr54 password=6sr54 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6ep39 password=6ep39 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6eh59 password=6eh59 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6mp58 password=6mp58 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6zu26 password=6zu26 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6xg78 password=6xg78 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6nv97 password=6nv97 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6zb78 password=6zb78 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6cc38 password=6cc38 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6ae69 password=6ae69 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6fb22 password=6fb22 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6vt57 password=6vt57 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6vg44 password=6vg44 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6vm38 password=6vm38 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6ds49 password=6ds49 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6xb66 password=6xb66 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6ir74 password=6ir74 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6sj55 password=6sj55 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6hf95 password=6hf95 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6sn77 password=6sn77 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6rv25 password=6rv25 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6mz73 password=6mz73 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6dh44 password=6dh44 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6vz96 password=6vz96 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6pz33 password=6pz33 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6cz92 password=6cz92 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6sn59 password=6sn59 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6yy75 password=6yy75 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6bz86 password=6bz86 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6bu66 password=6bu66 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6bg47 password=6bg47 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6hf79 password=6hf79 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6bp25 password=6bp25 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6fz27 password=6fz27 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6fe67 password=6fe67 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6xb37 password=6xb37 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6zb53 password=6zb53 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6ix25 password=6ix25 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6mm33 password=6mm33 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6xc98 password=6xc98 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6gx47 password=6gx47 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6ma49 password=6ma49 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6vk83 password=6vk83 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6ra95 password=6ra95 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6nz46 password=6nz46 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6pc24 password=6pc24 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6tu44 password=6tu44 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6yv28 password=6yv28 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6fk89 password=6fk89 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6ti82 password=6ti82 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6ds65 password=6ds65 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6aj28 password=6aj28 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6pn46 password=6pn46 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6hg62 password=6hg62 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6mv39 password=6mv39 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6xu72 password=6xu72 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6ae25 password=6ae25 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6sc48 password=6sc48 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6np96 password=6np96 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6eb92 password=6eb92 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6zc68 password=6zc68 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6nt34 password=6nt34 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6na68 password=6na68 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6ba23 password=6ba23 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6jg38 password=6jg38 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6ar56 password=6ar56 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6zn34 password=6zn34 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6zi85 password=6zi85 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6uh77 password=6uh77 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6bp26 password=6bp26 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6iy42 password=6iy42 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6xc45 password=6xc45 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6rr75 password=6rr75 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6kt82 password=6kt82 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6dk95 password=6dk95 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6ic82 password=6ic82 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6jd72 password=6jd72 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6wj47 password=6wj47 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6xv37 password=6xv37 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6ty39 password=6ty39 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6sr46 password=6sr46 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6nw98 password=6nw98 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6bu62 password=6bu62 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6fa53 password=6fa53 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6vi53 password=6vi53 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6rn56 password=6rn56 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6cv35 password=6cv35 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6rw39 password=6rw39 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6py58 password=6py58 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6rt58 password=6rt58 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6mv23 password=6mv23 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6ce26 password=6ce26 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6mh22 password=6mh22 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6aa83 password=6aa83 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6ii94 password=6ii94 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6pu65 password=6pu65 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6ck36 password=6ck36 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6tg59 password=6tg59 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6nv86 password=6nv86 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6uc33 password=6uc33 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6rn58 password=6rn58 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6zr53 password=6zr53 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6gn79 password=6gn79 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6vr83 password=6vr83 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6xm65 password=6xm65 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6ja59 password=6ja59 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6us86 password=6us86 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6iu76 password=6iu76 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6kf48 password=6kf48 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6xr65 password=6xr65 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6vm32 password=6vm32 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6sv28 password=6sv28 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6ab49 password=6ab49 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6px89 password=6px89 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6zy25 password=6zy25 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6px26 password=6px26 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6cu64 password=6cu64 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6hd28 password=6hd28 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6aw57 password=6aw57 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6wh79 password=6wh79 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6en66 password=6en66 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6cg46 password=6cg46 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6wx33 password=6wx33 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6wc96 password=6wc96 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6yu68 password=6yu68 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6rs24 password=6rs24 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6sd26 password=6sd26 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6cy28 password=6cy28 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6ec74 password=6ec74 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6wy34 password=6wy34 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6zh99 password=6zh99 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6ge67 password=6ge67 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6ud54 password=6ud54 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6kk92 password=6kk92 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6ia28 password=6ia28 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6mx63 password=6mx63 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6dy39 password=6dy39 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6ma28 password=6ma28 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6kr33 password=6kr33 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6rf36 password=6rf36 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6tt38 password=6tt38 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6wm92 password=6wm92 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6bc58 password=6bc58 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6he87 password=6he87 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6mn54 password=6mn54 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6nb34 password=6nb34 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6ut47 password=6ut47 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6vp56 password=6vp56 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6kg76 password=6kg76 profile=Paket6jam
/ip hotspot user add comment=vc-810-03.15.26- limit-uptime=6h name=6ww75 password=6ww75 profile=Paket6jam
/ip hotspot user add comment=vc- name=ATa6z8bxep password=ATa6z8bxep profile=V-3500
/ip hotspot user add comment=vc-630-03.30.26- limit-uptime=2h name=2vc66 password=2vc66 profile=Paket2jam
/ip hotspot user add comment=vc-630-03.30.26- limit-uptime=2h name=2tb96 password=2tb96 profile=Paket2jam
/ip hotspot user add comment=vc-630-03.30.26- limit-uptime=2h name=2jy84 password=2jy84 profile=Paket2jam
/ip hotspot user add comment=vc-630-03.30.26- limit-uptime=2h name=2ma87 password=2ma87 profile=Paket2jam
/ip hotspot user add comment=vc-630-03.30.26- limit-uptime=2h name=2vt92 password=2vt92 profile=Paket2jam
/ip hotspot user add comment=vc-630-03.30.26- limit-uptime=2h name=2ka77 password=2ka77 profile=Paket2jam
/ip hotspot user add comment=vc-630-03.30.26- limit-uptime=2h name=2kd38 password=2kd38 profile=Paket2jam
/ip hotspot user add comment=vc-630-03.30.26- limit-uptime=2h name=2vm59 password=2vm59 profile=Paket2jam
/ip hotspot user add comment=vc-630-03.30.26- limit-uptime=2h name=2ic47 password=2ic47 profile=Paket2jam
/ip hotspot user add comment=vc-630-03.30.26- limit-uptime=2h name=2aj37 password=2aj37 profile=Paket2jam
/ip hotspot user add comment=vc-630-03.30.26- limit-uptime=2h name=2px29 password=2px29 profile=Paket2jam
/ip hotspot user add comment=vc-630-03.30.26- limit-uptime=2h name=2jc49 password=2jc49 profile=Paket2jam
/ip hotspot user add comment=vc-630-03.30.26- limit-uptime=2h name=2gb45 password=2gb45 profile=Paket2jam
/ip hotspot user add comment=vc-630-03.30.26- limit-uptime=2h name=2vw89 password=2vw89 profile=Paket2jam
/ip hotspot user add comment=vc-630-03.30.26- limit-uptime=2h name=2cd45 password=2cd45 profile=Paket2jam
/ip hotspot user add comment=vc-630-03.30.26- limit-uptime=2h name=2jg48 password=2jg48 profile=Paket2jam
/ip hotspot user add comment=vc-630-03.30.26- limit-uptime=2h name=2pe35 password=2pe35 profile=Paket2jam
/ip hotspot user add comment=vc-630-03.30.26- limit-uptime=2h name=2id89 password=2id89 profile=Paket2jam
/ip hotspot user add comment=vc-630-03.30.26- limit-uptime=2h name=2cj59 password=2cj59 profile=Paket2jam
/ip hotspot user add comment=vc-630-03.30.26- limit-uptime=2h name=2gk57 password=2gk57 profile=Paket2jam
/ip hotspot user add comment=vc-630-03.30.26- limit-uptime=2h name=2dh56 password=2dh56 profile=Paket2jam
/ip hotspot user add comment=vc-630-03.30.26- limit-uptime=2h name=2zp34 password=2zp34 profile=Paket2jam
/ip hotspot user add comment=vc-630-03.30.26- limit-uptime=2h name=2et65 password=2et65 profile=Paket2jam
/ip hotspot user add comment=vc-630-03.30.26- limit-uptime=2h name=2vf32 password=2vf32 profile=Paket2jam
/ip hotspot user add comment=vc-630-03.30.26- limit-uptime=2h name=2zu42 password=2zu42 profile=Paket2jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6nm28 password=6nm28 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6pu88 password=6pu88 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6rj86 password=6rj86 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6nf48 password=6nf48 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6mv76 password=6mv76 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6cw89 password=6cw89 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6mw45 password=6mw45 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6sf99 password=6sf99 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6er22 password=6er22 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6yj57 password=6yj57 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ce24 password=6ce24 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6nh52 password=6nh52 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6jc75 password=6jc75 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6hm52 password=6hm52 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ef74 password=6ef74 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6dw55 password=6dw55 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6pa87 password=6pa87 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6sh39 password=6sh39 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6gm24 password=6gm24 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6dv84 password=6dv84 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6mi88 password=6mi88 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ym69 password=6ym69 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6gy86 password=6gy86 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6he56 password=6he56 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6cz29 password=6cz29 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ft66 password=6ft66 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6pm97 password=6pm97 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6nd38 password=6nd38 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6kx59 password=6kx59 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6wx27 password=6wx27 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6sb54 password=6sb54 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6kc47 password=6kc47 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6cd83 password=6cd83 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ct88 password=6ct88 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6vk87 password=6vk87 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ye33 password=6ye33 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6dc83 password=6dc83 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ci75 password=6ci75 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6se25 password=6se25 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ei42 password=6ei42 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6iw83 password=6iw83 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6it29 password=6it29 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6pw89 password=6pw89 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ep93 password=6ep93 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6wn98 password=6wn98 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6zh24 password=6zh24 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6cz97 password=6cz97 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6pj59 password=6pj59 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6hw27 password=6hw27 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ce79 password=6ce79 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ha88 password=6ha88 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ub32 password=6ub32 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6uz27 password=6uz27 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6sm66 password=6sm66 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6kh24 password=6kh24 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6zu69 password=6zu69 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6av76 password=6av76 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6me46 password=6me46 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6us95 password=6us95 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6dz34 password=6dz34 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6va58 password=6va58 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6md42 password=6md42 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6vv49 password=6vv49 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6dc86 password=6dc86 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6kh68 password=6kh68 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ki52 password=6ki52 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6cw59 password=6cw59 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6za44 password=6za44 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ay85 password=6ay85 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6be84 password=6be84 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6an22 password=6an22 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ha35 password=6ha35 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6xv43 password=6xv43 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6kr24 password=6kr24 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6vw62 password=6vw62 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6vy23 password=6vy23 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6af89 password=6af89 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ya34 password=6ya34 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6hs45 password=6hs45 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6cw92 password=6cw92 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6si65 password=6si65 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ma86 password=6ma86 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6rm67 password=6rm67 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6jm34 password=6jm34 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6yt53 password=6yt53 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6cj76 password=6cj76 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ww52 password=6ww52 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6wn42 password=6wn42 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6yy62 password=6yy62 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ms33 password=6ms33 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ej64 password=6ej64 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ef72 password=6ef72 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ie73 password=6ie73 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ie95 password=6ie95 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6gp58 password=6gp58 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6db38 password=6db38 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6hs34 password=6hs34 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6mb64 password=6mb64 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6zd53 password=6zd53 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6km35 password=6km35 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6yg36 password=6yg36 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6cv78 password=6cv78 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6dr52 password=6dr52 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6kw35 password=6kw35 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ij49 password=6ij49 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6xz83 password=6xz83 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6re98 password=6re98 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6an65 password=6an65 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ag94 password=6ag94 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6wx62 password=6wx62 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ct89 password=6ct89 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6vv36 password=6vv36 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6tw26 password=6tw26 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6em59 password=6em59 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6eb96 password=6eb96 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ca34 password=6ca34 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6gy76 password=6gy76 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6kc58 password=6kc58 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6aw82 password=6aw82 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ne39 password=6ne39 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6yn27 password=6yn27 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6cw86 password=6cw86 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6kz35 password=6kz35 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6pt69 password=6pt69 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6mx34 password=6mx34 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6nw44 password=6nw44 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6gh58 password=6gh58 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6sf27 password=6sf27 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6yp26 password=6yp26 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6sf63 password=6sf63 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6yg53 password=6yg53 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6wn94 password=6wn94 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6rk57 password=6rk57 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6hz89 password=6hz89 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6zd69 password=6zd69 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6pj49 password=6pj49 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6iw28 password=6iw28 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6zs28 password=6zs28 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6xv83 password=6xv83 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ji87 password=6ji87 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6vr26 password=6vr26 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6mu98 password=6mu98 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6mh43 password=6mh43 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6wb32 password=6wb32 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ym43 password=6ym43 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6xv67 password=6xv67 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6dp22 password=6dp22 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6au22 password=6au22 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6jz88 password=6jz88 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ij82 password=6ij82 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6jt74 password=6jt74 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6wp58 password=6wp58 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6sa73 password=6sa73 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6pw43 password=6pw43 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6fi23 password=6fi23 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6sn75 password=6sn75 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6hp26 password=6hp26 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6py64 password=6py64 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6zu92 password=6zu92 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6px42 password=6px42 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6pi94 password=6pi94 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6kn37 password=6kn37 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6zb47 password=6zb47 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6rc88 password=6rc88 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6yy94 password=6yy94 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6pj78 password=6pj78 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6zi65 password=6zi65 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6um42 password=6um42 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6re29 password=6re29 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6zm37 password=6zm37 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6bj27 password=6bj27 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6kp32 password=6kp32 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6xh23 password=6xh23 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6sd39 password=6sd39 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6gd95 password=6gd95 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6rg37 password=6rg37 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ut94 password=6ut94 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6sn92 password=6sn92 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ss54 password=6ss54 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6uz39 password=6uz39 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6hj58 password=6hj58 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6wi93 password=6wi93 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6xb46 password=6xb46 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6xn64 password=6xn64 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6cj96 password=6cj96 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6id79 password=6id79 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6cy43 password=6cy43 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6mv96 password=6mv96 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6sh96 password=6sh96 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6cr46 password=6cr46 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6dr32 password=6dr32 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6vw63 password=6vw63 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ac73 password=6ac73 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6bi69 password=6bi69 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6jb36 password=6jb36 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6zw83 password=6zw83 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ym44 password=6ym44 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6cp64 password=6cp64 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6uf82 password=6uf82 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6zz45 password=6zz45 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6zf35 password=6zf35 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ga83 password=6ga83 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ef22 password=6ef22 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6fc48 password=6fc48 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ug67 password=6ug67 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ri87 password=6ri87 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ht97 password=6ht97 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6dy36 password=6dy36 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ia55 password=6ia55 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6jk23 password=6jk23 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ij38 password=6ij38 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6cp53 password=6cp53 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6mb75 password=6mb75 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ta88 password=6ta88 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6di44 password=6di44 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6sm69 password=6sm69 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6wi76 password=6wi76 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6wk68 password=6wk68 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6kd44 password=6kd44 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6eg87 password=6eg87 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6fs95 password=6fs95 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6eb56 password=6eb56 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6xt29 password=6xt29 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ky77 password=6ky77 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6fd97 password=6fd97 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ku92 password=6ku92 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6pz87 password=6pz87 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6yx38 password=6yx38 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ic97 password=6ic97 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6vv73 password=6vv73 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6vz78 password=6vz78 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ub48 password=6ub48 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ze86 password=6ze86 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6wt93 password=6wt93 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6km29 password=6km29 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6am55 password=6am55 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6vx23 password=6vx23 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ks32 password=6ks32 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6bi76 password=6bi76 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6dk25 password=6dk25 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ta28 password=6ta28 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6in47 password=6in47 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6je26 password=6je26 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6kd55 password=6kd55 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6wk54 password=6wk54 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6be96 password=6be96 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6jk99 password=6jk99 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6tv69 password=6tv69 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ie69 password=6ie69 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6hb99 password=6hb99 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6rx42 password=6rx42 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ku69 password=6ku69 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6xk29 password=6xk29 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6jn98 password=6jn98 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6iz58 password=6iz58 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6zh52 password=6zh52 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6wt77 password=6wt77 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6mx47 password=6mx47 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6uz88 password=6uz88 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6zx63 password=6zx63 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ks29 password=6ks29 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6hp27 password=6hp27 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6zy63 password=6zy63 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6va55 password=6va55 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ku58 password=6ku58 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ka55 password=6ka55 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6rp32 password=6rp32 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ib34 password=6ib34 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6yk27 password=6yk27 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6js53 password=6js53 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6sy52 password=6sy52 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6bk38 password=6bk38 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6zv39 password=6zv39 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6cg42 password=6cg42 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6zv94 password=6zv94 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6vu92 password=6vu92 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ns26 password=6ns26 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6pu79 password=6pu79 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6we66 password=6we66 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6nn59 password=6nn59 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6uu92 password=6uu92 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ik22 password=6ik22 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6nu23 password=6nu23 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6us77 password=6us77 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6mt33 password=6mt33 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6kz56 password=6kz56 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ju59 password=6ju59 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6jv59 password=6jv59 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6nn48 password=6nn48 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6nj65 password=6nj65 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6sw45 password=6sw45 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6pu68 password=6pu68 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6pu82 password=6pu82 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6nn97 password=6nn97 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6yk94 password=6yk94 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6bu25 password=6bu25 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ju58 password=6ju58 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ss99 password=6ss99 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6xt83 password=6xt83 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6wx55 password=6wx55 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6nz69 password=6nz69 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6wt29 password=6wt29 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ts78 password=6ts78 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6nb99 password=6nb99 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6zy28 password=6zy28 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6st46 password=6st46 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6kt96 password=6kt96 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6kz67 password=6kz67 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6yg35 password=6yg35 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ur74 password=6ur74 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6vk93 password=6vk93 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6bm69 password=6bm69 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6sy37 password=6sy37 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6bb38 password=6bb38 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6vv55 password=6vv55 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6rc69 password=6rc69 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6rp79 password=6rp79 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6rx38 password=6rx38 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6yp74 password=6yp74 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6kk24 password=6kk24 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6iu75 password=6iu75 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6re97 password=6re97 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6sw56 password=6sw56 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ze46 password=6ze46 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6bk46 password=6bk46 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6kx97 password=6kx97 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ib32 password=6ib32 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6sr77 password=6sr77 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6yu23 password=6yu23 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6hn54 password=6hn54 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ju39 password=6ju39 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6nk66 password=6nk66 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6gp45 password=6gp45 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ip72 password=6ip72 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ex27 password=6ex27 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6yk45 password=6yk45 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6yi56 password=6yi56 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6iu49 password=6iu49 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6gr22 password=6gr22 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6md35 password=6md35 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ay36 password=6ay36 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6uf87 password=6uf87 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6nr22 password=6nr22 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6sh95 password=6sh95 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ya54 password=6ya54 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6zu66 password=6zu66 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6fv59 password=6fv59 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6xf76 password=6xf76 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6wc94 password=6wc94 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6rr72 password=6rr72 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6wb42 password=6wb42 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6vg59 password=6vg59 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6rb85 password=6rb85 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6xx45 password=6xx45 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6iw25 password=6iw25 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6pu73 password=6pu73 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6nm25 password=6nm25 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ca49 password=6ca49 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6iu44 password=6iu44 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6cb58 password=6cb58 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6bv24 password=6bv24 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6wp99 password=6wp99 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6up46 password=6up46 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ih75 password=6ih75 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6rb46 password=6rb46 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6xz95 password=6xz95 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6up43 password=6up43 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6um54 password=6um54 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6yr68 password=6yr68 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6av27 password=6av27 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6zj75 password=6zj75 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6zn37 password=6zn37 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6dc23 password=6dc23 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6yu84 password=6yu84 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6mz68 password=6mz68 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6us76 password=6us76 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ha95 password=6ha95 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ky67 password=6ky67 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6de82 password=6de82 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6vz47 password=6vz47 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6sh22 password=6sh22 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6yw24 password=6yw24 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6yb32 password=6yb32 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6wm35 password=6wm35 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6rs38 password=6rs38 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6em77 password=6em77 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6rp45 password=6rp45 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6rz88 password=6rz88 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6ey72 password=6ey72 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6dt48 password=6dt48 profile=Paket6jam
/ip hotspot user add comment=vc-880-03.30.26- limit-uptime=6h name=6hc85 password=6hc85 profile=Paket6jam
/ip hotspot user add comment=vc-496-03.30.26- limit-uptime=6h name=6nz36 password=6nz36 profile=Paket6jam
/ip hotspot user add comment=vc-496-03.30.26- limit-uptime=6h name=6hm86 password=6hm86 profile=Paket6jam
/ip hotspot user add comment=vc-496-03.30.26- limit-uptime=6h name=6wu67 password=6wu67 profile=Paket6jam
/ip hotspot user add comment=vc-496-03.30.26- limit-uptime=6h name=6dv34 password=6dv34 profile=Paket6jam
/ip hotspot user add comment=vc-496-03.30.26- limit-uptime=6h name=6ug59 password=6ug59 profile=Paket6jam
/ip hotspot user add comment=vc-496-03.30.26- limit-uptime=6h name=6gp73 password=6gp73 profile=Paket6jam
/ip hotspot user add comment=vc-496-03.30.26- limit-uptime=6h name=6zh35 password=6zh35 profile=Paket6jam
/ip hotspot user add comment=vc-496-03.30.26- limit-uptime=6h name=6bw45 password=6bw45 profile=Paket6jam
/ip hotspot user add comment=vc-496-03.30.26- limit-uptime=6h name=6ur55 password=6ur55 profile=Paket6jam
/ip hotspot user add comment=vc-496-03.30.26- limit-uptime=6h name=6mu99 password=6mu99 profile=Paket6jam
/ip hotspot user add comment=vc-496-03.30.26- limit-uptime=6h name=6dg34 password=6dg34 profile=Paket6jam
/ip hotspot user add comment=vc-496-03.30.26- limit-uptime=6h name=6gr39 password=6gr39 profile=Paket6jam
/ip hotspot user add comment=vc-496-03.30.26- limit-uptime=6h name=6tc63 password=6tc63 profile=Paket6jam
/ip hotspot user add comment=vc-496-03.30.26- limit-uptime=6h name=6tb38 password=6tb38 profile=Paket6jam
/ip hotspot user add comment=vc-496-03.30.26- limit-uptime=6h name=6vh25 password=6vh25 profile=Paket6jam
/ip hotspot user add comment=vc-496-03.30.26- limit-uptime=6h name=6xc53 password=6xc53 profile=Paket6jam
/ip hotspot user add comment=vc-496-03.30.26- limit-uptime=6h name=6ww73 password=6ww73 profile=Paket6jam
/ip hotspot user add comment=vc-817-04.16.26- limit-uptime=6h name=6rw36 password=6rw36 profile=Paket6jam
/ip hotspot user add comment=vc-817-04.16.26- limit-uptime=6h name=6tx68 password=6tx68 profile=Paket6jam
/ip hotspot user add comment=vc-817-04.16.26- limit-uptime=6h name=6ec77 password=6ec77 profile=Paket6jam
/ip hotspot user add comment=vc-817-04.16.26- limit-uptime=6h name=6kz23 password=6kz23 profile=Paket6jam
/ip hotspot user add comment=vc-817-04.16.26- limit-uptime=6h name=6dv75 password=6dv75 profile=Paket6jam
/ip hotspot user add comment=vc-817-04.16.26- limit-uptime=6h name=6cf96 password=6cf96 profile=Paket6jam
/ip hotspot user add comment=vc-817-04.16.26- limit-uptime=6h name=6pj67 password=6pj67 profile=Paket6jam
/ip hotspot user add comment=vc-817-04.16.26- limit-uptime=6h name=6dw36 password=6dw36 profile=Paket6jam
/ip hotspot user add comment=vc-817-04.16.26- limit-uptime=6h name=6ww62 password=6ww62 profile=Paket6jam
/ip hotspot user add comment=vc-817-04.16.26- limit-uptime=6h name=6fu32 password=6fu32 profile=Paket6jam
/ip hotspot user add comment=vc-817-04.16.26- limit-uptime=6h name=6rf29 password=6rf29 profile=Paket6jam
/ip hotspot user add comment=vc-817-04.16.26- limit-uptime=6h name=6ir83 password=6ir83 profile=Paket6jam
/ip hotspot user add comment=vc-817-04.16.26- limit-uptime=6h name=6kn79 password=6kn79 profile=Paket6jam
/ip hotspot user add comment=vc-817-04.16.26- limit-uptime=6h name=6dn97 password=6dn97 profile=Paket6jam
/ip hotspot user add comment=vc-817-04.16.26- limit-uptime=6h name=6sv67 password=6sv67 profile=Paket6jam
/ip hotspot user add comment=vc-817-04.16.26- limit-uptime=6h name=6dt43 password=6dt43 profile=Paket6jam
/ip hotspot user add comment=vc-817-04.16.26- limit-uptime=6h name=6fa99 password=6fa99 profile=Paket6jam
/ip hotspot user add comment=vc-817-04.16.26- limit-uptime=6h name=6at95 password=6at95 profile=Paket6jam
/ip hotspot user add comment=vc-817-04.16.26- limit-uptime=6h name=6wz34 password=6wz34 profile=Paket6jam
/ip hotspot user add comment=vc-817-04.16.26- limit-uptime=6h name=6pn66 password=6pn66 profile=Paket6jam
/ip hotspot user add comment=vc-817-04.16.26- limit-uptime=6h name=6jz33 password=6jz33 profile=Paket6jam
/ip hotspot user add comment=vc-817-04.16.26- limit-uptime=6h name=6rc35 password=6rc35 profile=Paket6jam
/ip hotspot user add comment=vc-817-04.16.26- limit-uptime=6h name=6pa55 password=6pa55 profile=Paket6jam
/ip hotspot user add comment=vc-817-04.16.26- limit-uptime=6h name=6hd98 password=6hd98 profile=Paket6jam
/ip hotspot user add comment=vc-817-04.16.26- limit-uptime=6h name=6cc58 password=6cc58 profile=Paket6jam
/ip hotspot user add comment=vc-817-04.16.26- limit-uptime=6h name=6px96 password=6px96 profile=Paket6jam
/ip hotspot user add comment=vc-817-04.16.26- limit-uptime=6h name=6yj34 password=6yj34 profile=Paket6jam
/ip hotspot user add comment=vc-817-04.16.26- limit-uptime=6h name=6wf25 password=6wf25 profile=Paket6jam
/ip hotspot user add comment=vc-817-04.16.26- limit-uptime=6h name=6uk53 password=6uk53 profile=Paket6jam
/ip hotspot user add comment=vc-817-04.16.26- limit-uptime=6h name=6ss59 password=6ss59 profile=Paket6jam
/ip hotspot user add comment=vc-817-04.16.26- limit-uptime=6h name=6ry23 password=6ry23 profile=Paket6jam
/ip hotspot user add comment=vc-817-04.16.26- limit-uptime=6h name=6fj33 password=6fj33 profile=Paket6jam
/ip hotspot user add comment=vc-817-04.16.26- limit-uptime=6h name=6bu42 password=6bu42 profile=Paket6jam
/ip hotspot user add comment=vc-817-04.16.26- limit-uptime=6h name=6jb67 password=6jb67 profile=Paket6jam
/ip hotspot user add comment=vc-817-04.16.26- limit-uptime=6h name=6fi85 password=6fi85 profile=Paket6jam
/ip hotspot user add comment=vc-817-04.16.26- limit-uptime=6h name=6ah68 password=6ah68 profile=Paket6jam
/ip hotspot user add comment=vc-817-04.16.26- limit-uptime=6h name=6sj48 password=6sj48 profile=Paket6jam
/ip hotspot user add comment=vc-817-04.16.26- limit-uptime=6h name=6xu78 password=6xu78 profile=Paket6jam
/ip hotspot user add comment=vc- name=ATfas6fbfk password=ATfas6fbfk profile=V-3500
/ip hotspot user add comment=vc- name=AT6tiujmiy password=AT6tiujmiy profile=V-2000
/ip hotspot user add comment=vc- name=ATirxxa9y2 password=ATirxxa9y2 profile=V-6000
/ip hotspot user add comment="MARWIYAH - 55rb - Bojong Suren" name=260124095750-MARWIYAH password=260124095750-MARWIYAH profile="1BULAN 1ORANG"
/ip hotspot user add comment=vc- name=ATozpxbbai password=ATozpxbbai profile=V-2000
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2wj44 password=2wj44 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2nj75 password=2nj75 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2mp52 password=2mp52 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2im54 password=2im54 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2vm73 password=2vm73 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2dz62 password=2dz62 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2ha74 password=2ha74 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2et32 password=2et32 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2gi63 password=2gi63 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2xz25 password=2xz25 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2nh88 password=2nh88 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2kb76 password=2kb76 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2xp28 password=2xp28 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2bs72 password=2bs72 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2cn52 password=2cn52 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2kb54 password=2kb54 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2ej24 password=2ej24 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2gw73 password=2gw73 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2fu98 password=2fu98 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2fk46 password=2fk46 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2ya48 password=2ya48 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2gk99 password=2gk99 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2xv34 password=2xv34 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2vd65 password=2vd65 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2ct53 password=2ct53 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2bz95 password=2bz95 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2mx24 password=2mx24 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2ff95 password=2ff95 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2vc37 password=2vc37 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2ix48 password=2ix48 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2tj62 password=2tj62 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2vr36 password=2vr36 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2zj42 password=2zj42 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2td24 password=2td24 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2jc33 password=2jc33 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2fe59 password=2fe59 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2fb74 password=2fb74 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2yv77 password=2yv77 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2nd36 password=2nd36 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2ce68 password=2ce68 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2vc87 password=2vc87 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2rs85 password=2rs85 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2xy98 password=2xy98 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2uh76 password=2uh76 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2ae46 password=2ae46 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2is95 password=2is95 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2zr76 password=2zr76 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2jy37 password=2jy37 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2ey49 password=2ey49 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2tw97 password=2tw97 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2mn42 password=2mn42 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2en52 password=2en52 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2nk27 password=2nk27 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2ys58 password=2ys58 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2hu27 password=2hu27 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2au22 password=2au22 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2nb57 password=2nb57 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2cx45 password=2cx45 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2hn87 password=2hn87 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2xe45 password=2xe45 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2ak47 password=2ak47 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2fk75 password=2fk75 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2zm45 password=2zm45 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2wx46 password=2wx46 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2cj82 password=2cj82 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2zc53 password=2zc53 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2hi42 password=2hi42 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2mk33 password=2mk33 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2av38 password=2av38 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2xk69 password=2xk69 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2cf98 password=2cf98 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2tp32 password=2tp32 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2dj82 password=2dj82 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2hx38 password=2hx38 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2ee85 password=2ee85 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2hp54 password=2hp54 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2vr32 password=2vr32 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2zn98 password=2zn98 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2in63 password=2in63 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2iw99 password=2iw99 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2fa96 password=2fa96 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2pi79 password=2pi79 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2pu64 password=2pu64 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2sp28 password=2sp28 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2ac52 password=2ac52 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2su26 password=2su26 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2hg99 password=2hg99 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2ak53 password=2ak53 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2bh75 password=2bh75 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2pp33 password=2pp33 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2ru86 password=2ru86 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2zb86 password=2zb86 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2bf26 password=2bf26 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2jv74 password=2jv74 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2vk99 password=2vk99 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2de69 password=2de69 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2vy83 password=2vy83 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2px56 password=2px56 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2cu34 password=2cu34 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2kd27 password=2kd27 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2xr74 password=2xr74 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2nn67 password=2nn67 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2jz56 password=2jz56 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2rv99 password=2rv99 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2dh66 password=2dh66 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2ja98 password=2ja98 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2uf63 password=2uf63 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2fx54 password=2fx54 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2vm34 password=2vm34 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2kb25 password=2kb25 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2jb23 password=2jb23 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2ph38 password=2ph38 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2fu89 password=2fu89 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2xx45 password=2xx45 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2fa59 password=2fa59 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2uk47 password=2uk47 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2fu76 password=2fu76 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2xk45 password=2xk45 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2wh42 password=2wh42 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2ay84 password=2ay84 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2cs99 password=2cs99 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2iv69 password=2iv69 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2sp22 password=2sp22 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2kn36 password=2kn36 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2sd23 password=2sd23 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2ka42 password=2ka42 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2hf46 password=2hf46 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2ev74 password=2ev74 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2eu82 password=2eu82 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2ei73 password=2ei73 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2pg57 password=2pg57 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2bu44 password=2bu44 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2jk82 password=2jk82 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2uc94 password=2uc94 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2yh42 password=2yh42 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2wg88 password=2wg88 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2ka64 password=2ka64 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2vp48 password=2vp48 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2wp47 password=2wp47 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2mm79 password=2mm79 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2ww43 password=2ww43 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2kw52 password=2kw52 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2zt72 password=2zt72 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2jh75 password=2jh75 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2pf47 password=2pf47 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2kz43 password=2kz43 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2uj32 password=2uj32 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2nf24 password=2nf24 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2kv69 password=2kv69 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2fw53 password=2fw53 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2de88 password=2de88 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2dp84 password=2dp84 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2dp55 password=2dp55 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2bz93 password=2bz93 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2cz55 password=2cz55 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2yz26 password=2yz26 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2jw34 password=2jw34 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2gp75 password=2gp75 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2bb73 password=2bb73 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2gy36 password=2gy36 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2cc58 password=2cc58 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2xs98 password=2xs98 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2me94 password=2me94 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2fm74 password=2fm74 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2te89 password=2te89 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2sr66 password=2sr66 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2nu62 password=2nu62 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2tb89 password=2tb89 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2xf32 password=2xf32 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2yv34 password=2yv34 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2yf87 password=2yf87 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2in94 password=2in94 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2rd23 password=2rd23 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2rt54 password=2rt54 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2fv84 password=2fv84 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2vc68 password=2vc68 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2nb98 password=2nb98 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2wd29 password=2wd29 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2tn68 password=2tn68 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2xe27 password=2xe27 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2wn72 password=2wn72 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2ie22 password=2ie22 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2mi77 password=2mi77 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2iv96 password=2iv96 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2eb59 password=2eb59 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2cr69 password=2cr69 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2du65 password=2du65 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2td62 password=2td62 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2vh33 password=2vh33 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2cg45 password=2cg45 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2ia38 password=2ia38 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2ds57 password=2ds57 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2cz33 password=2cz33 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2zh62 password=2zh62 profile=Paket2jam
/ip hotspot user add comment="aug/03/2026 06:28:01" limit-uptime=2h name=2vw48 password=2vw48 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2bw75 password=2bw75 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2ri94 password=2ri94 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2aj83 password=2aj83 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2jf52 password=2jf52 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2tc45 password=2tc45 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2aa79 password=2aa79 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2jy62 password=2jy62 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2sh57 password=2sh57 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2uw63 password=2uw63 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2if96 password=2if96 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2fk76 password=2fk76 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2bw29 password=2bw29 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2yb48 password=2yb48 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2kk76 password=2kk76 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2bg55 password=2bg55 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2vh63 password=2vh63 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2ix63 password=2ix63 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2sx43 password=2sx43 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2gb79 password=2gb79 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2ig47 password=2ig47 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2fw92 password=2fw92 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2tz94 password=2tz94 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2ty62 password=2ty62 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2ag32 password=2ag32 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2mc96 password=2mc96 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2he27 password=2he27 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2ee46 password=2ee46 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2ri74 password=2ri74 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2bi36 password=2bi36 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2wa57 password=2wa57 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2yp27 password=2yp27 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2at94 password=2at94 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2an77 password=2an77 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2sy69 password=2sy69 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2vv97 password=2vv97 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2kz79 password=2kz79 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2ba39 password=2ba39 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2xf99 password=2xf99 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2dz29 password=2dz29 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2vs25 password=2vs25 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2kc75 password=2kc75 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2bz48 password=2bz48 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2rh48 password=2rh48 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2iz58 password=2iz58 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2md59 password=2md59 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2dg88 password=2dg88 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2kp45 password=2kp45 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2ze92 password=2ze92 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2ps58 password=2ps58 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2zk39 password=2zk39 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2ki99 password=2ki99 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2br72 password=2br72 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2ta36 password=2ta36 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2df96 password=2df96 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2fy58 password=2fy58 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2ex89 password=2ex89 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2gh63 password=2gh63 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2vc77 password=2vc77 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2dz49 password=2dz49 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2tw58 password=2tw58 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2fw76 password=2fw76 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2dp36 password=2dp36 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2hc92 password=2hc92 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2jd46 password=2jd46 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2gu99 password=2gu99 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2dk82 password=2dk82 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2td78 password=2td78 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2jy29 password=2jy29 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2dz75 password=2dz75 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2jv43 password=2jv43 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2ev93 password=2ev93 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2jh97 password=2jh97 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2ud53 password=2ud53 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2at28 password=2at28 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2jr46 password=2jr46 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2tt92 password=2tt92 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2pc35 password=2pc35 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2dz47 password=2dz47 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2ym86 password=2ym86 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2fu54 password=2fu54 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2fn57 password=2fn57 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2tf25 password=2tf25 profile=Paket2jam
/ip hotspot user add comment=vc-116-06.24.26- limit-uptime=2h name=2mu75 password=2mu75 profile=Paket2jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6hy46 password=6hy46 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6eg56 password=6eg56 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6eu52 password=6eu52 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6mk76 password=6mk76 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6gm67 password=6gm67 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6sc35 password=6sc35 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6in29 password=6in29 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6ha23 password=6ha23 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6ic33 password=6ic33 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6jh68 password=6jh68 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6ws68 password=6ws68 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6jc53 password=6jc53 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6hf89 password=6hf89 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6js95 password=6js95 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6tj97 password=6tj97 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6te28 password=6te28 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6nd45 password=6nd45 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6cp79 password=6cp79 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6va78 password=6va78 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6kn88 password=6kn88 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6cd73 password=6cd73 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6ad56 password=6ad56 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6ky66 password=6ky66 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6sk55 password=6sk55 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6xa87 password=6xa87 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6ka46 password=6ka46 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6rc44 password=6rc44 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6ug47 password=6ug47 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6gb38 password=6gb38 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6en27 password=6en27 profile=Paket6jam
/ip hotspot user add comment="aug/03/2026 02:19:16" limit-uptime=6h name=6zj92 password=6zj92 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6dw39 password=6dw39 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6nr93 password=6nr93 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6fd45 password=6fd45 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6us82 password=6us82 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6ct55 password=6ct55 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6pt42 password=6pt42 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6xu22 password=6xu22 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6nx86 password=6nx86 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6ws97 password=6ws97 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6zv44 password=6zv44 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6bu78 password=6bu78 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6pp53 password=6pp53 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6fd75 password=6fd75 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6pm56 password=6pm56 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6yp83 password=6yp83 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6kd48 password=6kd48 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6wp65 password=6wp65 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6pj47 password=6pj47 profile=Paket6jam
/ip hotspot user add comment="aug/03/2026 06:32:56" limit-uptime=6h name=6kf86 password=6kf86 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6sx38 password=6sx38 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6ex34 password=6ex34 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6vk67 password=6vk67 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6mp34 password=6mp34 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6by23 password=6by23 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6hu57 password=6hu57 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6fp55 password=6fp55 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6fn68 password=6fn68 profile=Paket6jam
/ip hotspot user add comment="aug/03/2026 03:20:13" limit-uptime=6h name=6ji33 password=6ji33 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6em53 password=6em53 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6kn46 password=6kn46 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6pc87 password=6pc87 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6eg68 password=6eg68 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6ik59 password=6ik59 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6iv42 password=6iv42 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6cm29 password=6cm29 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6yb39 password=6yb39 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6uv65 password=6uv65 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6yz74 password=6yz74 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6hp33 password=6hp33 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6ym94 password=6ym94 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6fw32 password=6fw32 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6mt34 password=6mt34 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6cw85 password=6cw85 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6ih55 password=6ih55 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6ey69 password=6ey69 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6dh97 password=6dh97 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6vu69 password=6vu69 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6tw46 password=6tw46 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6te25 password=6te25 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6it57 password=6it57 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6yj89 password=6yj89 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6th24 password=6th24 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6de46 password=6de46 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6xg37 password=6xg37 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6ud52 password=6ud52 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6ey54 password=6ey54 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6fu25 password=6fu25 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6he98 password=6he98 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6ya93 password=6ya93 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6iz95 password=6iz95 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6rz56 password=6rz56 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6wn84 password=6wn84 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6hg79 password=6hg79 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6dj98 password=6dj98 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6ex77 password=6ex77 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6ur96 password=6ur96 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6xi25 password=6xi25 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6jj48 password=6jj48 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6xc68 password=6xc68 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6su79 password=6su79 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6kt36 password=6kt36 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6kc95 password=6kc95 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6bi47 password=6bi47 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6ye35 password=6ye35 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6iu38 password=6iu38 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6cf57 password=6cf57 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6zy62 password=6zy62 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6jh73 password=6jh73 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6vh66 password=6vh66 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6uh49 password=6uh49 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6cr39 password=6cr39 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6se99 password=6se99 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6pf49 password=6pf49 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6jn62 password=6jn62 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6eh82 password=6eh82 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6wd72 password=6wd72 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6cd52 password=6cd52 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6hh89 password=6hh89 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6tx85 password=6tx85 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6ex24 password=6ex24 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6dk73 password=6dk73 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6bx23 password=6bx23 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6ac57 password=6ac57 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6ag28 password=6ag28 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6xg34 password=6xg34 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6gy83 password=6gy83 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6fu99 password=6fu99 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6zg89 password=6zg89 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6ar93 password=6ar93 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6dc36 password=6dc36 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6cx66 password=6cx66 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6dw77 password=6dw77 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6hm79 password=6hm79 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6tt42 password=6tt42 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6nv84 password=6nv84 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6su57 password=6su57 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6pc94 password=6pc94 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6jc99 password=6jc99 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6us28 password=6us28 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6xm87 password=6xm87 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6ku29 password=6ku29 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6cy82 password=6cy82 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6sb28 password=6sb28 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6rm49 password=6rm49 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6nt42 password=6nt42 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6sz73 password=6sz73 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6zu23 password=6zu23 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6dw84 password=6dw84 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6ru28 password=6ru28 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6mw65 password=6mw65 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6am58 password=6am58 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6jh93 password=6jh93 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6dr87 password=6dr87 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6td33 password=6td33 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6ux84 password=6ux84 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6mt38 password=6mt38 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6ws82 password=6ws82 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6ut83 password=6ut83 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6dr93 password=6dr93 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6wu37 password=6wu37 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6hb94 password=6hb94 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6vf97 password=6vf97 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6wy55 password=6wy55 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6zg29 password=6zg29 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6tj82 password=6tj82 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6mv34 password=6mv34 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6yi49 password=6yi49 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6vp73 password=6vp73 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6jb83 password=6jb83 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6fu22 password=6fu22 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6an44 password=6an44 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6xb92 password=6xb92 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6ax86 password=6ax86 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6gb86 password=6gb86 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6hu22 password=6hu22 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6ta74 password=6ta74 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6nr25 password=6nr25 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6vg54 password=6vg54 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6vg83 password=6vg83 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6ph67 password=6ph67 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6bv97 password=6bv97 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6mk64 password=6mk64 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6mp28 password=6mp28 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6sa22 password=6sa22 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6jj43 password=6jj43 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6vv78 password=6vv78 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6iw43 password=6iw43 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6fc88 password=6fc88 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6fi46 password=6fi46 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6gy39 password=6gy39 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6dz72 password=6dz72 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6re63 password=6re63 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6ep22 password=6ep22 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6ec99 password=6ec99 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6vu74 password=6vu74 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6vt63 password=6vt63 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6xm38 password=6xm38 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6wj56 password=6wj56 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6nv54 password=6nv54 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6dg75 password=6dg75 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6fd25 password=6fd25 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6vu55 password=6vu55 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6bx77 password=6bx77 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6cw37 password=6cw37 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6ka42 password=6ka42 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6dr72 password=6dr72 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6wh55 password=6wh55 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6rc62 password=6rc62 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6zb39 password=6zb39 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6jm27 password=6jm27 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6ai34 password=6ai34 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6na35 password=6na35 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6em87 password=6em87 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6bb36 password=6bb36 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6zg24 password=6zg24 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6bs32 password=6bs32 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6hv66 password=6hv66 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6fe39 password=6fe39 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6yc43 password=6yc43 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6vw26 password=6vw26 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6kf26 password=6kf26 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6rj45 password=6rj45 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6fa98 password=6fa98 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6mb55 password=6mb55 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6ys68 password=6ys68 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6cg93 password=6cg93 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6de36 password=6de36 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6sm52 password=6sm52 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6de42 password=6de42 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6gt33 password=6gt33 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6jd38 password=6jd38 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6cj48 password=6cj48 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6dj83 password=6dj83 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6wc37 password=6wc37 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6mh78 password=6mh78 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6gw99 password=6gw99 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6ba49 password=6ba49 profile=Paket6jam
/ip hotspot user add comment=vc-852-06.24.26- limit-uptime=6h name=6rv37 password=6rv37 profile=Paket6jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2cm36 password=2cm36 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2kd88 password=2kd88 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2zf47 password=2zf47 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ai53 password=2ai53 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2yz87 password=2yz87 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2az26 password=2az26 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2vv63 password=2vv63 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2wr63 password=2wr63 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ty33 password=2ty33 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2rx99 password=2rx99 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ae43 password=2ae43 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2jk54 password=2jk54 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2hd63 password=2hd63 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2zt23 password=2zt23 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2pk44 password=2pk44 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2xj69 password=2xj69 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2pf37 password=2pf37 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ah57 password=2ah57 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ev39 password=2ev39 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2rx63 password=2rx63 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2tp45 password=2tp45 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2fn53 password=2fn53 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2dz66 password=2dz66 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2sm56 password=2sm56 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2su92 password=2su92 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2xe54 password=2xe54 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2bh43 password=2bh43 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2tg79 password=2tg79 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2eh48 password=2eh48 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2wn25 password=2wn25 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2hj95 password=2hj95 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2zw48 password=2zw48 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2sx93 password=2sx93 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ey96 password=2ey96 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2uw37 password=2uw37 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2as52 password=2as52 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2wp92 password=2wp92 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2bb67 password=2bb67 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2tk39 password=2tk39 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ju45 password=2ju45 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2xr23 password=2xr23 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ff54 password=2ff54 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2dn44 password=2dn44 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2up72 password=2up72 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ms86 password=2ms86 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2cw29 password=2cw29 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2fc62 password=2fc62 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ww76 password=2ww76 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2di43 password=2di43 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ed39 password=2ed39 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2kg85 password=2kg85 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2za62 password=2za62 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ph53 password=2ph53 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ik75 password=2ik75 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2zd76 password=2zd76 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2bd77 password=2bd77 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2xy96 password=2xy96 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2zf59 password=2zf59 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2nr65 password=2nr65 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ze64 password=2ze64 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2uv27 password=2uv27 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2im67 password=2im67 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2iw27 password=2iw27 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2zm58 password=2zm58 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2bj77 password=2bj77 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2tv47 password=2tv47 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2xz99 password=2xz99 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2vv66 password=2vv66 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2tm88 password=2tm88 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2vx52 password=2vx52 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2pr65 password=2pr65 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ui64 password=2ui64 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2yv66 password=2yv66 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2hg98 password=2hg98 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2jy49 password=2jy49 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2jb87 password=2jb87 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2yj62 password=2yj62 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2rt46 password=2rt46 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2hy89 password=2hy89 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2tu94 password=2tu94 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2tu35 password=2tu35 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2xr27 password=2xr27 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2sw66 password=2sw66 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2rc86 password=2rc86 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2rk87 password=2rk87 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2vp74 password=2vp74 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2hf68 password=2hf68 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2xm88 password=2xm88 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2yv98 password=2yv98 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2gp46 password=2gp46 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2xk38 password=2xk38 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2kw94 password=2kw94 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2yk22 password=2yk22 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2xz74 password=2xz74 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2jg62 password=2jg62 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2km79 password=2km79 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2xx99 password=2xx99 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2fi54 password=2fi54 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2yc78 password=2yc78 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2zk85 password=2zk85 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2zp25 password=2zp25 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2bf27 password=2bf27 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2bz33 password=2bz33 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2bx88 password=2bx88 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2hj83 password=2hj83 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2av63 password=2av63 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2vg29 password=2vg29 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2wc39 password=2wc39 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2uy98 password=2uy98 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2yt73 password=2yt73 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2hy34 password=2hy34 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2tu25 password=2tu25 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2rk93 password=2rk93 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2fc53 password=2fc53 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2sp49 password=2sp49 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ks56 password=2ks56 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2kc43 password=2kc43 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ga35 password=2ga35 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2cs49 password=2cs49 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ze98 password=2ze98 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2rk35 password=2rk35 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ft32 password=2ft32 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2gw56 password=2gw56 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ty23 password=2ty23 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ip67 password=2ip67 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2uu73 password=2uu73 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2gk97 password=2gk97 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ej62 password=2ej62 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2mp57 password=2mp57 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2gg83 password=2gg83 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2yv29 password=2yv29 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2vk53 password=2vk53 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2wv67 password=2wv67 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2wr35 password=2wr35 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2bh33 password=2bh33 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ar32 password=2ar32 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2yx74 password=2yx74 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ur49 password=2ur49 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ha87 password=2ha87 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ks79 password=2ks79 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2da66 password=2da66 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2if37 password=2if37 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2vb28 password=2vb28 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2xx53 password=2xx53 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2fh93 password=2fh93 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ed38 password=2ed38 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ji94 password=2ji94 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2pg72 password=2pg72 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2dy92 password=2dy92 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2tm24 password=2tm24 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2mz88 password=2mz88 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2by95 password=2by95 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2zc28 password=2zc28 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ds99 password=2ds99 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ca22 password=2ca22 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2je49 password=2je49 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2kk84 password=2kk84 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2jv67 password=2jv67 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2yn79 password=2yn79 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2pg78 password=2pg78 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ww94 password=2ww94 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2az48 password=2az48 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2sy67 password=2sy67 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2cy69 password=2cy69 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2aj42 password=2aj42 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2pf94 password=2pf94 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2nj37 password=2nj37 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ud66 password=2ud66 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2xt98 password=2xt98 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2vj56 password=2vj56 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2hn46 password=2hn46 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2xg35 password=2xg35 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2pz95 password=2pz95 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2id72 password=2id72 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2yh73 password=2yh73 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2kn98 password=2kn98 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2nm68 password=2nm68 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2kc25 password=2kc25 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2xj24 password=2xj24 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2jz23 password=2jz23 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2au47 password=2au47 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2kb35 password=2kb35 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2di96 password=2di96 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2an59 password=2an59 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ps23 password=2ps23 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ki33 password=2ki33 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2cj75 password=2cj75 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ne43 password=2ne43 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2vg72 password=2vg72 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2zu52 password=2zu52 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2wb79 password=2wb79 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2wt86 password=2wt86 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2kf93 password=2kf93 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2dy33 password=2dy33 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2xh76 password=2xh76 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2hu58 password=2hu58 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ut96 password=2ut96 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ek99 password=2ek99 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ru84 password=2ru84 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2pk47 password=2pk47 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2km57 password=2km57 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2bu55 password=2bu55 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2fy66 password=2fy66 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2if32 password=2if32 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2th33 password=2th33 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2xz78 password=2xz78 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2pt42 password=2pt42 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2tr63 password=2tr63 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2me48 password=2me48 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2cb93 password=2cb93 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2vp56 password=2vp56 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2pe56 password=2pe56 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2gb39 password=2gb39 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2rv27 password=2rv27 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2kn37 password=2kn37 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2rk89 password=2rk89 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2pr69 password=2pr69 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2kg93 password=2kg93 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2nr73 password=2nr73 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2kb69 password=2kb69 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2wx39 password=2wx39 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2cc45 password=2cc45 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ia62 password=2ia62 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2mc69 password=2mc69 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2mz67 password=2mz67 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2he85 password=2he85 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2zi92 password=2zi92 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2nh46 password=2nh46 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2vi92 password=2vi92 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2wu58 password=2wu58 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2wf98 password=2wf98 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2zr82 password=2zr82 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2na38 password=2na38 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ps48 password=2ps48 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2tv53 password=2tv53 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2bh57 password=2bh57 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2xn46 password=2xn46 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2im52 password=2im52 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2bc34 password=2bc34 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2uv68 password=2uv68 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2kc82 password=2kc82 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ki93 password=2ki93 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2vt78 password=2vt78 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2gy53 password=2gy53 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ju75 password=2ju75 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ah95 password=2ah95 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2kc93 password=2kc93 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ng93 password=2ng93 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2kx83 password=2kx83 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2pw46 password=2pw46 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2bw88 password=2bw88 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ai56 password=2ai56 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2mt68 password=2mt68 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ig79 password=2ig79 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2bu33 password=2bu33 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2rk98 password=2rk98 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2fv85 password=2fv85 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2kf34 password=2kf34 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2np35 password=2np35 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2tc29 password=2tc29 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ds36 password=2ds36 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2vv36 password=2vv36 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2mj26 password=2mj26 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2kc69 password=2kc69 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2iv35 password=2iv35 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2gc65 password=2gc65 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2bu87 password=2bu87 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2uf97 password=2uf97 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2du32 password=2du32 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ph74 password=2ph74 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2zr93 password=2zr93 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2cs89 password=2cs89 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2hi89 password=2hi89 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2cx54 password=2cx54 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2gu33 password=2gu33 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2mz26 password=2mz26 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2tp52 password=2tp52 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2bp94 password=2bp94 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2pz24 password=2pz24 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ck39 password=2ck39 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2gb62 password=2gb62 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2hh96 password=2hh96 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2vy33 password=2vy33 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2zk45 password=2zk45 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2eb64 password=2eb64 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2bx67 password=2bx67 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2fb43 password=2fb43 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2mv56 password=2mv56 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2cu98 password=2cu98 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2fu88 password=2fu88 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2tt38 password=2tt38 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2kc68 password=2kc68 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2yi59 password=2yi59 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ht39 password=2ht39 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2bj22 password=2bj22 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ps64 password=2ps64 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2jg32 password=2jg32 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2at89 password=2at89 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2mx62 password=2mx62 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ft37 password=2ft37 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2bc24 password=2bc24 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2yg36 password=2yg36 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2bm24 password=2bm24 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2yu93 password=2yu93 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2xk48 password=2xk48 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2mj73 password=2mj73 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2sg65 password=2sg65 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2zc96 password=2zc96 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2cc47 password=2cc47 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ae78 password=2ae78 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2aw86 password=2aw86 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2fj36 password=2fj36 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2au45 password=2au45 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2vn67 password=2vn67 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2fz78 password=2fz78 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2nm44 password=2nm44 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2cs76 password=2cs76 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2wb47 password=2wb47 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2yt98 password=2yt98 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2sr99 password=2sr99 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2sw43 password=2sw43 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2jh83 password=2jh83 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2af22 password=2af22 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2fe33 password=2fe33 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2kg59 password=2kg59 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2wx42 password=2wx42 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2vc42 password=2vc42 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2pn72 password=2pn72 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2gj42 password=2gj42 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2bg28 password=2bg28 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2gw58 password=2gw58 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2gi72 password=2gi72 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2cm59 password=2cm59 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2az35 password=2az35 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2em69 password=2em69 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ga43 password=2ga43 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2pc65 password=2pc65 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2hu43 password=2hu43 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2de95 password=2de95 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2bu53 password=2bu53 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2jk43 password=2jk43 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2zt74 password=2zt74 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2px25 password=2px25 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2bt33 password=2bt33 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ve82 password=2ve82 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2kx28 password=2kx28 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2tc98 password=2tc98 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ue88 password=2ue88 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2jc89 password=2jc89 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2xd94 password=2xd94 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2yg63 password=2yg63 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2jp24 password=2jp24 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2fr68 password=2fr68 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2na33 password=2na33 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2du43 password=2du43 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ia54 password=2ia54 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2rb95 password=2rb95 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2nx68 password=2nx68 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2mw95 password=2mw95 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ir49 password=2ir49 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2gs44 password=2gs44 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2uj86 password=2uj86 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2pn58 password=2pn58 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ww64 password=2ww64 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2wk93 password=2wk93 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2at82 password=2at82 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2df37 password=2df37 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ma93 password=2ma93 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2tm38 password=2tm38 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2mv27 password=2mv27 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ap64 password=2ap64 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2rt29 password=2rt29 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ag39 password=2ag39 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ne25 password=2ne25 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ut53 password=2ut53 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ew96 password=2ew96 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2yz47 password=2yz47 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2sm33 password=2sm33 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2pn87 password=2pn87 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2er93 password=2er93 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2sc86 password=2sc86 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2wz59 password=2wz59 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2yw65 password=2yw65 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2cg98 password=2cg98 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2pt32 password=2pt32 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2pk58 password=2pk58 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2sf73 password=2sf73 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2pp48 password=2pp48 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2tf73 password=2tf73 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2sh48 password=2sh48 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2pp55 password=2pp55 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2kk95 password=2kk95 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2fi85 password=2fi85 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2pf24 password=2pf24 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2re54 password=2re54 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2yu67 password=2yu67 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2cc46 password=2cc46 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2uf25 password=2uf25 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ee77 password=2ee77 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ja92 password=2ja92 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2am57 password=2am57 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2pw48 password=2pw48 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2yv46 password=2yv46 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2et96 password=2et96 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2wz27 password=2wz27 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2kh39 password=2kh39 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2bh47 password=2bh47 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2yh74 password=2yh74 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ix94 password=2ix94 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ga55 password=2ga55 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2tw62 password=2tw62 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2wv25 password=2wv25 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2rv43 password=2rv43 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2nr55 password=2nr55 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2et67 password=2et67 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2xr34 password=2xr34 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ex28 password=2ex28 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ie32 password=2ie32 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2jz78 password=2jz78 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2sb28 password=2sb28 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2yw59 password=2yw59 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2mv97 password=2mv97 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2py32 password=2py32 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2gn38 password=2gn38 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2br97 password=2br97 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2wn33 password=2wn33 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ka86 password=2ka86 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2kg79 password=2kg79 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ad59 password=2ad59 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2if46 password=2if46 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2pw26 password=2pw26 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2bd24 password=2bd24 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2wz54 password=2wz54 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2jz62 password=2jz62 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2km86 password=2km86 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2uw22 password=2uw22 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2rf69 password=2rf69 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2as35 password=2as35 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2vh85 password=2vh85 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2cc95 password=2cc95 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2cv77 password=2cv77 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2kj28 password=2kj28 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2mn99 password=2mn99 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ss82 password=2ss82 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2iz59 password=2iz59 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2yj79 password=2yj79 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ag88 password=2ag88 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2xe83 password=2xe83 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2bd48 password=2bd48 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2in67 password=2in67 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2jm34 password=2jm34 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2mw53 password=2mw53 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2en99 password=2en99 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2hg29 password=2hg29 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2cc43 password=2cc43 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2za45 password=2za45 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2fd25 password=2fd25 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2bw53 password=2bw53 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2dj36 password=2dj36 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2gz67 password=2gz67 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2gr98 password=2gr98 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2mh87 password=2mh87 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ub43 password=2ub43 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2zd83 password=2zd83 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ch37 password=2ch37 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2hh48 password=2hh48 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2xe57 password=2xe57 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2vm85 password=2vm85 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2pc85 password=2pc85 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2tk82 password=2tk82 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2pu66 password=2pu66 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ch88 password=2ch88 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2kw95 password=2kw95 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2nx93 password=2nx93 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2xc99 password=2xc99 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2mj74 password=2mj74 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2wv66 password=2wv66 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2it92 password=2it92 profile=Paket2jam
/ip hotspot user add comment=vc-722-07.02.26- limit-uptime=2h name=2ex48 password=2ex48 profile=Paket2jam
/ip hotspot walled-garden add comment="place hotspot rules here" disabled=yes
/ip hotspot walled-garden add comment="bypass teknorak" dst-host=*teknologirakyat.online/portal server=hs-MASTER
/ip hotspot walled-garden add comment="bypass teknorak" dst-host=*portal.tekra.my.id server=hs-MASTER
/ip hotspot walled-garden add comment=myqrcode dst-host=*laksa19.github.io/myqr server=*1
/ip hotspot walled-garden add dst-host=*tekra.mymikhmon.my.id
/ip hotspot walled-garden add dst-host=*tripay.co.id
/ip hotspot walled-garden add dst-host=*cdnjs.cloudflare.com
/ip hotspot walled-garden add dst-host=*stackpath.bootstrapcdn.com
/ip hotspot walled-garden add dst-host=*cdn.jsdelivr.net
/ip hotspot walled-garden ip add action=accept disabled=no !dst-address !dst-address-list dst-host=*laksa19.github.io/myqr !dst-port !protocol server=*1 !src-address !src-address-list
/ip hotspot walled-garden ip add action=accept disabled=no !dst-address !dst-address-list dst-host=*teknologirakyat.online/portal !dst-port !protocol server=*1 !src-address !src-address-list
/ip hotspot walled-garden ip add action=accept comment="Mikhmon QR Code Scanner" disabled=no dst-host=laksa19.github.io
/ip hotspot walled-garden ip add action=accept comment="Mikhmon QR Code Scanner" disabled=no dst-host=teknologirakyat.online
/ip hotspot walled-garden ip add action=accept comment="Mikhmon QR Code Scanner" disabled=no dst-host=intergram.xyz
/ip hotspot walled-garden ip add action=accept comment="Mikhmon QR Code Scanner" disabled=no dst-host=telegram.org
/ip hotspot walled-garden ip add action=accept comment="Mikhmon QR Code Scanner" disabled=no dst-host=api.telegram.org
/ip hotspot walled-garden ip add action=accept comment="Mikhmon QR Code Scanner" disabled=no dst-host=t.me
/ip hotspot walled-garden ip add action=accept comment="Mikhmon QR Code Scanner" disabled=no dst-host=telesco.pe
/ip hotspot walled-garden ip add action=accept comment="Mikhmon QR Code Scanner" disabled=no dst-host=web.telegram.org
/ip hotspot walled-garden ip add action=accept comment="Mikhmon QR Code Scanner" disabled=no dst-host=core.telegram.org
/ip hotspot walled-garden ip add action=accept comment="Mikhmon QR Code Scanner" disabled=no dst-host=91.108.4.0/22
/ip hotspot walled-garden ip add action=accept comment="Mikhmon QR Code Scanner" disabled=no dst-host=91.108.4.0/22
/ip hotspot walled-garden ip add action=accept comment=telegram disabled=no dst-address=149.154.160.0/20
/ip hotspot walled-garden ip add action=accept comment=telegram disabled=no dst-address=149.154.164.0/22
/ip hotspot walled-garden ip add action=accept comment=telegram disabled=no dst-address=91.108.4.0/22
/ip hotspot walled-garden ip add action=accept comment=telegram disabled=no dst-address=91.108.56.0/22
/ip hotspot walled-garden ip add action=accept comment=telegram disabled=no dst-address=91.108.8.0/22
/ip hotspot walled-garden ip add action=accept comment=DANA disabled=no !dst-address !dst-address-list dst-host=dana.id !dst-port !protocol !src-address !src-address-list
/ip hotspot walled-garden ip add action=accept comment=DANA disabled=no !dst-address !dst-address-list dst-host=m.dana.id !dst-port !protocol !src-address !src-address-list
/ip hotspot walled-garden ip add action=accept comment=DANA disabled=no !dst-address !dst-address-list dst-host=a.m.dana.id !dst-port !protocol !src-address !src-address-list
/ip route add distance=1 gateway=8.8.8.8 routing-mark=FASTAMA target-scope=30
/ip route add check-gateway=ping distance=1 gateway=8.8.4.4 routing-mark=MYREP target-scope=30
/ip route add comment=WA-SIMAYA distance=1 gateway=115.178.49.185 routing-mark=VIA-SIMAYA
/ip route add check-gateway=ping comment="recrisive isp1" distance=1 gateway=8.8.8.8 target-scope=30
/ip route add check-gateway=ping distance=1 dst-address=8.8.4.4/32 gateway=192.168.123.1
/ip route add check-gateway=ping distance=1 dst-address=8.8.8.8/32 gateway=115.178.49.185
/ip route add comment="acs route too x86" distance=1 dst-address=10.1.0.0/21 gateway=172.80.10.100
/ip route add comment="acs route too x86" distance=1 dst-address=10.2.0.0/21 gateway=172.80.10.100
/ip route add comment="acs route too x86" distance=1 dst-address=10.2.2.148/32 gateway=172.80.10.100
/ip route add comment="acs route too x86" distance=1 dst-address=10.10.10.9/32 gateway=172.80.10.100
/ip route add comment="acs route too x86" distance=1 dst-address=10.10.10.10/32 gateway=172.80.10.100
/ip route add comment="acs route too x86" distance=1 dst-address=10.10.10.205/32 gateway=172.80.10.100
/ip route add comment="acs route too x86" distance=1 dst-address=10.10.10.207/32 gateway=172.80.10.100
/ip route add comment="acs route too x86" distance=1 dst-address=10.10.10.209/32 gateway=172.80.10.100
/ip route add comment="acs route too x86" distance=1 dst-address=10.10.12.0/24 gateway=172.80.10.100
/ip route add comment="acs route too x86" distance=1 dst-address=10.10.13.0/24 gateway=172.80.10.100
/ip route add comment="acs route too x86" distance=1 dst-address=10.10.14.0/24 gateway=172.80.10.100
/ip route add comment="acs route too x86" distance=1 dst-address=10.10.15.0/24 gateway=172.80.10.100
/ip route add comment="acs route too x86" distance=1 dst-address=10.100.0.0/21 gateway=172.80.10.100
/ip service set telnet disabled=yes
/ip service set ftp disabled=yes
/ip service set www disabled=yes
/ip service set ssh port=18
/ip service set api address=10.10.10.0/24,172.80.10.0/24,192.168.44.0/24
/ip service set api-ssl disabled=yes
/lcd set color-scheme=dark time-interval=weekly
/lcd interface pages set 0 interfaces=sfp-HYPER,ether1-SIMAYA,ether2,ether3,ether4-TO-X86,ether5-pfsense,ether6,ether7
/ppp secret add local-address=10.6.0.1 name=DAGO password=DAGO profile=TUNNEL-PROFILE remote-address=10.6.0.2 service=ovpn
/ppp secret add local-address=192.168.33.1 name=SELAMET remote-address=192.168.33.33 service=pppoe
/ppp secret add local-address=11.2.0.1 name=YOFI profile=PAKET2 remote-address=10.2.0.79 service=pppoe
/ppp secret add name=CILISUNG profile=PAKET1 service=pppoe
/ppp secret add local-address=10.6.0.1 name=AVA password=AVA remote-address=10.6.0.3 service=l2tp
/ppp secret add local-address=10.6.0.1 name=CILISUNGGX password=CILISUNGGX profile=TUNNEL-SINGLE remote-address=10.6.0.5 service=l2tp
/ppp secret add local-address=10.6.0.1 name=CILISUNGGR password=CILISUNGGR remote-address=10.6.0.6 service=l2tp
/ppp secret add local-address=10.6.0.1 name=hotware password=hotware profile=TUNNEL-SINGLE remote-address=10.6.0.7 service=l2tp
/ppp secret add name=DAVID-SETRADUTA password=david@tekra profile=TUNNEL-PROFILE remote-address=10.7.0.2 service=ovpn
/ppp secret add name=RICKY-SETRADUTA password=ricky@tekra profile=TUNNEL-PROFILE remote-address=10.7.0.3 service=ovpn
/ppp secret add name=TONY-KOTABARU password=tony@tekra profile=TUNNEL-PROFILE remote-address=10.7.0.4 service=ovpn
/ppp secret add name=HANDY-SETRADUTA password=handy@tekra profile=TUNNEL-PROFILE remote-address=10.7.0.5 service=ovpn
/ppp secret add name=NILA-JATINANGOR-A password=nila-a@tekra profile=TUNNEL-PROFILE remote-address=10.7.0.6 service=ovpn
/ppp secret add name=NILA-JATINANGOR-B password=nila-b@tekra profile=TUNNEL-PROFILE remote-address=10.7.0.7 service=ovpn
/ppp secret add name=CILISUNG password=CILISUNG profile=TUNNEL-PROFILE remote-address=10.7.0.8 service=ovpn
/ppp secret add name=KATAPANG password=KATAPANG profile=TUNNEL-PROFILE remote-address=10.7.0.9 service=ovpn
/ppp secret add name=sdd password=sdd profile=default-encryption
/radius add address=192.168.55.1 secret=12345 service=ppp,hotspot
/routing bgp network add disabled=yes network=10.10.10.0/24
/routing bgp peer add disabled=yes name=cilisung remote-address=10.6.0.5 remote-as=65530
/routing bgp peer add disabled=yes name=dago remote-address=10.6.0.2 remote-as=65530
/snmp set enabled=yes trap-generators=start-trap trap-version=2
/system clock set time-zone-name=Asia/Jakarta
/system logging add action=disk prefix=-> topics=hotspot,info,debug
/system ntp client set enabled=yes primary-ntp=119.2.43.91 secondary-ntp=221.240.96.9 server-dns-names=asia.pool.ntp.org
/system package update set channel=long-term
/system scheduler add comment="Monitor Profile Paket6jam" interval=2m39s name=Paket6jam on-event=":local dateint do={:local montharray ( \"jan\",\"feb\",\"mar\",\"apr\",\"may\",\"jun\",\"jul\",\"aug\",\"sep\",\"oct\",\"nov\",\"dec\" );:local days [ :pick \$d 4 6 ];:local month [ :pick \$d 0 3 ];:local year [ :pick \$d 7 11 ];:local monthint ([ :find \$montharray \$month]);:local month (\$monthint + 1);:if ( [len \$month] = 1) do={:local zero (\"0\");:return [:tonum (\"\$year\$zero\$month\$days\")];} else={:return [:tonum (\"\$year\$month\$days\")];}}; :local timeint do={ :local hours [ :pick \$t 0 2 ]; :local minutes [ :pick \$t 3 5 ]; :return (\$hours * 60 + \$minutes) ; }; :local date [ /system clock get date ]; :local time [ /system clock get time ]; :local today [\$dateint d=\$date] ; :local curtime [\$timeint t=\$time] ; :foreach i in [ /ip hotspot user find where profile=\"Paket6jam\" ] do={ :local comment [ /ip hotspot user get \$i comment]; :local name [ /ip hotspot user get \$i name]; :local gettime [:pic \$comment 12 20]; :if ([:pic \$comment 3] = \"/\" and [:pic \$comment 6] = \"/\") do={:local expd [\$dateint d=\$comment] ; :local expt [\$timeint t=\$gettime] ; :if ((\$expd < \$today and \$expt < \$curtime) or (\$expd < \$today and \$expt > \$curtime) or (\$expd = \$today and \$expt < \$curtime)) do={ [ /ip hotspot user remove \$i ]; [ /ip hotspot active remove [find where user=\$name] ];}}}" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=apr/18/2020 start-time=05:13:36
/system scheduler add comment="Monitor Profile Paket2jam" interval=2m37s name=Paket2jam on-event=":local dateint do={:local montharray ( \"jan\",\"feb\",\"mar\",\"apr\",\"may\",\"jun\",\"jul\",\"aug\",\"sep\",\"oct\",\"nov\",\"dec\" );:local days [ :pick \$d 4 6 ];:local month [ :pick \$d 0 3 ];:local year [ :pick \$d 7 11 ];:local monthint ([ :find \$montharray \$month]);:local month (\$monthint + 1);:if ( [len \$month] = 1) do={:local zero (\"0\");:return [:tonum (\"\$year\$zero\$month\$days\")];} else={:return [:tonum (\"\$year\$month\$days\")];}}; :local timeint do={ :local hours [ :pick \$t 0 2 ]; :local minutes [ :pick \$t 3 5 ]; :return (\$hours * 60 + \$minutes) ; }; :local date [ /system clock get date ]; :local time [ /system clock get time ]; :local today [\$dateint d=\$date] ; :local curtime [\$timeint t=\$time] ; :foreach i in [ /ip hotspot user find where profile=\"Paket2jam\" ] do={ :local comment [ /ip hotspot user get \$i comment]; :local name [ /ip hotspot user get \$i name]; :local gettime [:pic \$comment 12 20]; :if ([:pic \$comment 3] = \"/\" and [:pic \$comment 6] = \"/\") do={:local expd [\$dateint d=\$comment] ; :local expt [\$timeint t=\$gettime] ; :if ((\$expd < \$today and \$expt < \$curtime) or (\$expd < \$today and \$expt > \$curtime) or (\$expd = \$today and \$expt < \$curtime)) do={ [ /ip hotspot user remove \$i ]; [ /ip hotspot active remove [find where user=\$name] ];}}}" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=apr/18/2020 start-time=02:39:19
/system scheduler add comment="Monitor Profile gold" interval=2m10s name=gold on-event=":local dateint do={:local montharray ( \"jan\",\"feb\",\"mar\",\"apr\",\"may\",\"jun\",\"jul\",\"aug\",\"sep\",\"oct\",\"nov\",\"dec\" );:local days [ :pick \$d 4 6 ];:local month [ :pick \$d 0 3 ];:local year [ :pick \$d 7 11 ];:local monthint ([ :find \$montharray \$month]);:local month (\$monthint + 1);:if ( [len \$month] = 1) do={:local zero (\"0\");:return [:tonum (\"\$year\$zero\$month\$days\")];} else={:return [:tonum (\"\$year\$month\$days\")];}}; :local timeint do={ :local hours [ :pick \$t 0 2 ]; :local minutes [ :pick \$t 3 5 ]; :return (\$hours * 60 + \$minutes) ; }; :local date [ /system clock get date ]; :local time [ /system clock get time ]; :local today [\$dateint d=\$date] ; :local curtime [\$timeint t=\$time] ; :foreach i in [ /ip hotspot user find where profile=\"gold\" ] do={ :local comment [ /ip hotspot user get \$i comment]; :local name [ /ip hotspot user get \$i name]; :local gettime [:pic \$comment 12 20]; :if ([:pic \$comment 3] = \"/\" and [:pic \$comment 6] = \"/\") do={:local expd [\$dateint d=\$comment] ; :local expt [\$timeint t=\$gettime] ; :if ((\$expd < \$today and \$expt < \$curtime) or (\$expd < \$today and \$expt > \$curtime) or (\$expd = \$today and \$expt < \$curtime)) do={ [ /ip hotspot user remove \$i ]; [ /ip hotspot active remove [find where user=\$name] ];}}}" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=apr/23/2020 start-time=03:14:44
/system scheduler add comment="Monitor Profile Paket12jam" interval=2m47s name=Paket12jam on-event=":local dateint do={:local montharray ( \"jan\",\"feb\",\"mar\",\"apr\",\"may\",\"jun\",\"jul\",\"aug\",\"sep\",\"oct\",\"nov\",\"dec\" );:local days [ :pick \$d 4 6 ];:local month [ :pick \$d 0 3 ];:local year [ :pick \$d 7 11 ];:local monthint ([ :find \$montharray \$month]);:local month (\$monthint + 1);:if ( [len \$month] = 1) do={:local zero (\"0\");:return [:tonum (\"\$year\$zero\$month\$days\")];} else={:return [:tonum (\"\$year\$month\$days\")];}}; :local timeint do={ :local hours [ :pick \$t 0 2 ]; :local minutes [ :pick \$t 3 5 ]; :return (\$hours * 60 + \$minutes) ; }; :local date [ /system clock get date ]; :local time [ /system clock get time ]; :local today [\$dateint d=\$date] ; :local curtime [\$timeint t=\$time] ; :foreach i in [ /ip hotspot user find where profile=\"Paket12jam\" ] do={ :local comment [ /ip hotspot user get \$i comment]; :local name [ /ip hotspot user get \$i name]; :local gettime [:pic \$comment 12 20]; :if ([:pic \$comment 3] = \"/\" and [:pic \$comment 6] = \"/\") do={:local expd [\$dateint d=\$comment] ; :local expt [\$timeint t=\$gettime] ; :if ((\$expd < \$today and \$expt < \$curtime) or (\$expd < \$today and \$expt > \$curtime) or (\$expd = \$today and \$expt < \$curtime)) do={ [ /ip hotspot user remove \$i ]; [ /ip hotspot active remove [find where user=\$name] ];}}}" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=jul/13/2020 start-time=05:59:13
/system scheduler add comment="Monitor Profile bulanan" interval=2m16s name=bulanan on-event=":local dateint do={:local montharray ( \"jan\",\"feb\",\"mar\",\"apr\",\"may\",\"jun\",\"jul\",\"aug\",\"sep\",\"oct\",\"nov\",\"dec\" );:local days [ :pick \$d 4 6 ];:local month [ :pick \$d 0 3 ];:local year [ :pick \$d 7 11 ];:local monthint ([ :find \$montharray \$month]);:local month (\$monthint + 1);:if ( [len \$month] = 1) do={:local zero (\"0\");:return [:tonum (\"\$year\$zero\$month\$days\")];} else={:return [:tonum (\"\$year\$month\$days\")];}}; :local timeint do={ :local hours [ :pick \$t 0 2 ]; :local minutes [ :pick \$t 3 5 ]; :return (\$hours * 60 + \$minutes) ; }; :local date [ /system clock get date ]; :local time [ /system clock get time ]; :local today [\$dateint d=\$date] ; :local curtime [\$timeint t=\$time] ; :foreach i in [ /ip hotspot user find where profile=\"bulanan\" ] do={ :local comment [ /ip hotspot user get \$i comment]; :local name [ /ip hotspot user get \$i name]; :local gettime [:pic \$comment 12 20]; :if ([:pic \$comment 3] = \"/\" and [:pic \$comment 6] = \"/\") do={:local expd [\$dateint d=\$comment] ; :local expt [\$timeint t=\$gettime] ; :if ((\$expd < \$today and \$expt < \$curtime) or (\$expd < \$today and \$expt > \$curtime) or (\$expd = \$today and \$expt < \$curtime)) do={ [ /ip hotspot user remove \$i ]; [ /ip hotspot active remove [find where user=\$name] ];}}}" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=jun/02/2021 start-time=05:24:32
/system scheduler add disabled=yes interval=1d name=Restart_Otomatis on-event="/system reboot" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=sep/04/2021 start-time=03:00:00
/system scheduler add comment=GENERATE-BILL disabled=yes interval=1d name=GENERATE-BILL on-event="/tool fetch url=\"https://portal.tekra.my.id/front/createbill/qvg7nLDjgvhnWIWw\" keep-result=no" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=feb/02/2023 start-time=12:40:03
/system scheduler add comment=REMINDER-BILL disabled=yes interval=1d name=REMINDER-BILL on-event="/tool fetch url=\"https://portal.tekra.my.id/front/reminderduedate/qvg7nLDjgvhnWIWw\" keep-result=no" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=feb/02/2023 start-time=12:40:03
/system scheduler add comment=REMINDER-BEFORE-DUE disabled=yes interval=1d name=REMINDER-BEFORE-DUE on-event="/tool fetch url=\"https://portal.tekra.my.id/front/reminder/qvg7nLDjgvhnWIWw\" keep-result=no" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=feb/02/2023 start-time=12:40:03
/system scheduler add comment=REMINDER-BILL-TELEGRAM disabled=yes interval=1d name=REMINDER-BILL-TELEGRAM on-event="/tool fetch url=\"https://portal.tekra.my.id/front/reminderduedatetelegram/qvg7nLDjgvhnWIWw\" keep-result=no" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=feb/02/2023 start-time=01:01:00
/system scheduler add comment=BACKUP-DB disabled=yes interval=1d name=BACKUP-DB on-event="/tool fetch url=\"https://portal.tekra.my.id/front/backupdb/qvg7nLDjgvhnWIWw\" keep-result=no" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=feb/02/2023 start-time=01:01:00
/system scheduler add comment=COUNT-PPPOE interval=15m name=COUNT-PPPOE on-event="/tool fetch url=\"https://portal.tekra.id/front/countpppoe/qvg7nLDjgvhnWIWw\" keep-result=no" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=feb/02/2023 start-time=12:40:17
/system scheduler add comment="Mikhmon Expire Monitor" interval=1m name=Mikhmon-Expire-Monitor on-event=":local dateint do={:local montharray ( \"jan\",\"feb\",\"mar\",\"apr\",\"may\",\"jun\",\"jul\",\"aug\",\"sep\",\"oct\",\"nov\",\"dec\" );:local days [ :pick \$d 4 6 ];:local month [ :pick \$d 0 3 ];:local year [ :pick \$d 7 11 ];:local monthint ([ :find \$montharray \$month]);:local month (\$monthint + 1);:if ( [len \$month] = 1) do={:local zero (\"0\");:return [:tonum (\"\$year\$zero\$month\$days\")];} else={:return [:tonum (\"\$year\$month\$days\")];}};:local timeint do={:local hours [ :pick \$t 0 2 ];:local minutes [ :pick \$t 3 5 ];:return (\$hours * 60 + \$minutes) ;};:local date [ /system clock get date ];:local time [ /system clock get time ];:local today [\$dateint d=\$date] ;:local curtime [\$timeint t=\$time] ;:local tyear [ :pick \$date 7 11 ];:local lyear (\$tyear-1);:foreach i in [ /ip hotspot user find where comment~\"/\$tyear\" || comment~\"/\$lyear\" ] do={:local comment [ /ip hotspot user get \$i comment]; :local limit [ /ip hotspot user get \$i limit-uptime]; :local name [ /ip hotspot user get \$i name]; :local gettime [:pic \$comment 12 20];:if ([:pic \$comment 3] = \"/\" and [:pic \$comment 6] = \"/\") do={:local expd [\$dateint d=\$comment] ;:local expt [\$timeint t=\$gettime] ;:if ((\$expd < \$today and \$expt < \$curtime) or (\$expd < \$today and \$expt > \$curtime) or (\$expd = \$today and \$expt < \$curtime) and \$limit != \"00:00:01\") do={ :if ([:pic \$comment 21] = \"N\") do={[ /ip hotspot user set limit-uptime=1s \$i ];[ /ip hotspot active remove [find where user=\$name] ];} else={[ /ip hotspot user remove \$i ];[ /ip hotspot active remove [find where user=\$name] ];}}}}}" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=apr/25/2023 start-time=00:00:00
/system scheduler add comment="Monitor Profile Paket-1-jam" interval=2m14s name=Paket-1-jam on-event=":local dateint do={:local montharray ( \"jan\",\"feb\",\"mar\",\"apr\",\"may\",\"jun\",\"jul\",\"aug\",\"sep\",\"oct\",\"nov\",\"dec\" );:local days [ :pick \$d 4 6 ];:local month [ :pick \$d 0 3 ];:local year [ :pick \$d 7 11 ];:local monthint ([ :find \$montharray \$month]);:local month (\$monthint + 1);:if ( [len \$month] = 1) do={:local zero (\"0\");:return [:tonum (\"\$year\$zero\$month\$days\")];} else={:return [:tonum (\"\$year\$month\$days\")];}}; :local timeint do={ :local hours [ :pick \$t 0 2 ]; :local minutes [ :pick \$t 3 5 ]; :return (\$hours * 60 + \$minutes) ; }; :local date [ /system clock get date ]; :local time [ /system clock get time ]; :local today [\$dateint d=\$date] ; :local curtime [\$timeint t=\$time] ; :foreach i in [ /ip hotspot user find where profile=\"Paket-1-jam\" ] do={ :local comment [ /ip hotspot user get \$i comment]; :local name [ /ip hotspot user get \$i name]; :local gettime [:pic \$comment 12 20]; :if ([:pic \$comment 3] = \"/\" and [:pic \$comment 6] = \"/\") do={:local expd [\$dateint d=\$comment] ; :local expt [\$timeint t=\$gettime] ; :if ((\$expd < \$today and \$expt < \$curtime) or (\$expd < \$today and \$expt > \$curtime) or (\$expd = \$today and \$expt < \$curtime)) do={ [ /ip hotspot user remove \$i ]; [ /ip hotspot active remove [find where user=\$name] ];}}}" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=apr/27/2023 start-time=02:39:37
/system scheduler add comment=ISOLIR-MY-WIFI interval=10m name=ISOLIR-MY-WIFI on-event="/tool fetch url=\"https://portal.tekra.id/front/isolir/qvg7nLDjgvhnWIWw\" keep-result=no" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=jan/06/2024 start-time=06:39:41
/system scheduler add comment="Monitor Profile V-2000" interval=2m19s name=V-2000 on-event=":local dateint do={:local montharray ( \"jan\",\"feb\",\"mar\",\"apr\",\"may\",\"jun\",\"jul\",\"aug\",\"sep\",\"oct\",\"nov\",\"dec\" );:local days [ :pick \$d 4 6 ];:local month [ :pick \$d 0 3 ];:local year [ :pick \$d 7 11 ];:local monthint ([ :find \$montharray \$month]);:local month (\$monthint + 1);:if ( [len \$month] = 1) do={:local zero (\"0\");:return [:tonum (\"\$year\$zero\$month\$days\")];} else={:return [:tonum (\"\$year\$month\$days\")];}}; :local timeint do={ :local hours [ :pick \$t 0 2 ]; :local minutes [ :pick \$t 3 5 ]; :return (\$hours * 60 + \$minutes) ; }; :local date [ /system clock get date ]; :local time [ /system clock get time ]; :local today [\$dateint d=\$date] ; :local curtime [\$timeint t=\$time] ; :foreach i in [ /ip hotspot user find where profile=\"V-2000\" ] do={ :local comment [ /ip hotspot user get \$i comment]; :local name [ /ip hotspot user get \$i name]; :local gettime [:pic \$comment 12 20]; :if ([:pic \$comment 3] = \"/\" and [:pic \$comment 6] = \"/\") do={:local expd [\$dateint d=\$comment] ; :local expt [\$timeint t=\$gettime] ; :if ((\$expd < \$today and \$expt < \$curtime) or (\$expd < \$today and \$expt > \$curtime) or (\$expd = \$today and \$expt < \$curtime)) do={ [ /ip hotspot user remove \$i ]; [ /ip hotspot active remove [find where user=\$name] ];}}}" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=nov/03/2024 start-time=05:20:57
/system scheduler add comment="Monitor Profile V-3500" interval=2m12s name=V-3500 on-event=":local dateint do={:local montharray ( \"jan\",\"feb\",\"mar\",\"apr\",\"may\",\"jun\",\"jul\",\"aug\",\"sep\",\"oct\",\"nov\",\"dec\" );:local days [ :pick \$d 4 6 ];:local month [ :pick \$d 0 3 ];:local year [ :pick \$d 7 11 ];:local monthint ([ :find \$montharray \$month]);:local month (\$monthint + 1);:if ( [len \$month] = 1) do={:local zero (\"0\");:return [:tonum (\"\$year\$zero\$month\$days\")];} else={:return [:tonum (\"\$year\$month\$days\")];}}; :local timeint do={ :local hours [ :pick \$t 0 2 ]; :local minutes [ :pick \$t 3 5 ]; :return (\$hours * 60 + \$minutes) ; }; :local date [ /system clock get date ]; :local time [ /system clock get time ]; :local today [\$dateint d=\$date] ; :local curtime [\$timeint t=\$time] ; :foreach i in [ /ip hotspot user find where profile=\"V-3500\" ] do={ :local comment [ /ip hotspot user get \$i comment]; :local name [ /ip hotspot user get \$i name]; :local gettime [:pic \$comment 12 20]; :if ([:pic \$comment 3] = \"/\" and [:pic \$comment 6] = \"/\") do={:local expd [\$dateint d=\$comment] ; :local expt [\$timeint t=\$gettime] ; :if ((\$expd < \$today and \$expt < \$curtime) or (\$expd < \$today and \$expt > \$curtime) or (\$expd = \$today and \$expt < \$curtime)) do={ [ /ip hotspot user remove \$i ]; [ /ip hotspot active remove [find where user=\$name] ];}}}" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=nov/03/2024 start-time=01:46:15
/system scheduler add comment="Monitor Profile V-6000" interval=2m53s name=V-6000 on-event=":local dateint do={:local montharray ( \"jan\",\"feb\",\"mar\",\"apr\",\"may\",\"jun\",\"jul\",\"aug\",\"sep\",\"oct\",\"nov\",\"dec\" );:local days [ :pick \$d 4 6 ];:local month [ :pick \$d 0 3 ];:local year [ :pick \$d 7 11 ];:local monthint ([ :find \$montharray \$month]);:local month (\$monthint + 1);:if ( [len \$month] = 1) do={:local zero (\"0\");:return [:tonum (\"\$year\$zero\$month\$days\")];} else={:return [:tonum (\"\$year\$month\$days\")];}}; :local timeint do={ :local hours [ :pick \$t 0 2 ]; :local minutes [ :pick \$t 3 5 ]; :return (\$hours * 60 + \$minutes) ; }; :local date [ /system clock get date ]; :local time [ /system clock get time ]; :local today [\$dateint d=\$date] ; :local curtime [\$timeint t=\$time] ; :foreach i in [ /ip hotspot user find where profile=\"V-6000\" ] do={ :local comment [ /ip hotspot user get \$i comment]; :local name [ /ip hotspot user get \$i name]; :local gettime [:pic \$comment 12 20]; :if ([:pic \$comment 3] = \"/\" and [:pic \$comment 6] = \"/\") do={:local expd [\$dateint d=\$comment] ; :local expt [\$timeint t=\$gettime] ; :if ((\$expd < \$today and \$expt < \$curtime) or (\$expd < \$today and \$expt > \$curtime) or (\$expd = \$today and \$expt < \$curtime)) do={ [ /ip hotspot user remove \$i ]; [ /ip hotspot active remove [find where user=\$name] ];}}}" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=nov/03/2024 start-time=05:48:36
/system scheduler add comment="Monitor Profile V-55k" interval=2m42s name=V-55k on-event=":local dateint do={:local montharray ( \"jan\",\"feb\",\"mar\",\"apr\",\"may\",\"jun\",\"jul\",\"aug\",\"sep\",\"oct\",\"nov\",\"dec\" );:local days [ :pick \$d 4 6 ];:local month [ :pick \$d 0 3 ];:local year [ :pick \$d 7 11 ];:local monthint ([ :find \$montharray \$month]);:local month (\$monthint + 1);:if ( [len \$month] = 1) do={:local zero (\"0\");:return [:tonum (\"\$year\$zero\$month\$days\")];} else={:return [:tonum (\"\$year\$month\$days\")];}}; :local timeint do={ :local hours [ :pick \$t 0 2 ]; :local minutes [ :pick \$t 3 5 ]; :return (\$hours * 60 + \$minutes) ; }; :local date [ /system clock get date ]; :local time [ /system clock get time ]; :local today [\$dateint d=\$date] ; :local curtime [\$timeint t=\$time] ; :foreach i in [ /ip hotspot user find where profile=\"V-55k\" ] do={ :local comment [ /ip hotspot user get \$i comment]; :local name [ /ip hotspot user get \$i name]; :local gettime [:pic \$comment 12 20]; :if ([:pic \$comment 3] = \"/\" and [:pic \$comment 6] = \"/\") do={:local expd [\$dateint d=\$comment] ; :local expt [\$timeint t=\$gettime] ; :if ((\$expd < \$today and \$expt < \$curtime) or (\$expd < \$today and \$expt > \$curtime) or (\$expd = \$today and \$expt < \$curtime)) do={ [ /ip hotspot user remove \$i ]; [ /ip hotspot active remove [find where user=\$name] ];}}}" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=nov/03/2024 start-time=03:22:38
/system scheduler add comment="Monitor Profile V-100k" interval=2m10s name=V-100k on-event=":local dateint do={:local montharray ( \"jan\",\"feb\",\"mar\",\"apr\",\"may\",\"jun\",\"jul\",\"aug\",\"sep\",\"oct\",\"nov\",\"dec\" );:local days [ :pick \$d 4 6 ];:local month [ :pick \$d 0 3 ];:local year [ :pick \$d 7 11 ];:local monthint ([ :find \$montharray \$month]);:local month (\$monthint + 1);:if ( [len \$month] = 1) do={:local zero (\"0\");:return [:tonum (\"\$year\$zero\$month\$days\")];} else={:return [:tonum (\"\$year\$month\$days\")];}}; :local timeint do={ :local hours [ :pick \$t 0 2 ]; :local minutes [ :pick \$t 3 5 ]; :return (\$hours * 60 + \$minutes) ; }; :local date [ /system clock get date ]; :local time [ /system clock get time ]; :local today [\$dateint d=\$date] ; :local curtime [\$timeint t=\$time] ; :foreach i in [ /ip hotspot user find where profile=\"V-100k\" ] do={ :local comment [ /ip hotspot user get \$i comment]; :local name [ /ip hotspot user get \$i name]; :local gettime [:pic \$comment 12 20]; :if ([:pic \$comment 3] = \"/\" and [:pic \$comment 6] = \"/\") do={:local expd [\$dateint d=\$comment] ; :local expt [\$timeint t=\$gettime] ; :if ((\$expd < \$today and \$expt < \$curtime) or (\$expd < \$today and \$expt > \$curtime) or (\$expd = \$today and \$expt < \$curtime)) do={ [ /ip hotspot user remove \$i ]; [ /ip hotspot active remove [find where user=\$name] ];}}}" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=nov/03/2024 start-time=05:29:44
/system scheduler add comment=https://csgarnet.id/ interval=25m name="Dell Double Income - https://csgarnet.id/" on-event="/tool fetch url=\"https://csgarnet.id/schedule/delldoubleincome\" keep-result=no" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=may/26/2025 start-time=19:41:32
/system scheduler add comment=https://csgarnet.id/ interval=8m name="Check Bill Payment - https://csgarnet.id/" on-event="/tool fetch url=\"https://csgarnet.id/schedule/cekbill\" keep-result=no" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=may/26/2025 start-time=19:41:32
/system scheduler add comment=https://csgarnet.id/ interval=29m name="Dell Double Bill - https://csgarnet.id/" on-event="/tool fetch url=\"https://csgarnet.id/schedule/delldoublebill\" keep-result=no" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=may/26/2025 start-time=19:41:32
/system scheduler add comment=https://csgarnet.id/ interval=31m name="Fix Item Bill - https://csgarnet.id/" on-event="/tool fetch url=\"https://csgarnet.id/schedule/fixitembill\" keep-result=no" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=may/26/2025 start-time=19:41:32
/system scheduler add comment=https://csgarnet.id/ interval=16m name="Fix Due Date / Isolir Date - https://csgarnet.id/" on-event="/tool fetch url=\"https://csgarnet.id/schedule/fixduedate\" keep-result=no" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=may/26/2025 start-time=19:41:32
/system scheduler add comment=https://csgarnet.id/ interval=6m name="Send Due date - https://csgarnet.id/" on-event="/tool fetch url=\"https://csgarnet.id/schedule/sendduedate\" keep-result=no" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=may/26/2025 start-time=19:41:32
/system scheduler add comment=https://csgarnet.id/ interval=13m name="Send Before Due Date - https://csgarnet.id/" on-event="/tool fetch url=\"https://csgarnet.id/schedule/sendbeforeduedate\" keep-result=no" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=may/26/2025 start-time=19:41:32
/system scheduler add comment=https://csgarnet.id/ interval=10m name="Generate Bill - https://csgarnet.id/" on-event="/tool fetch url=\"https://csgarnet.id/schedule/generatebill\" keep-result=no" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=may/26/2025 start-time=19:41:32
/system scheduler add comment=https://csgarnet.id/ interval=1d name="Backup Database - https://csgarnet.id/" on-event="/tool fetch url=\"https://csgarnet.id/schedule/backupdatabase\" keep-result=no" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=may/26/2025 start-time=19:41:32
/system scheduler add comment=https://csgarnet.id/ interval=1m name="Execute Whatsapp - https://csgarnet.id/" on-event="/tool fetch url=\"https://csgarnet.id/schedule/scheduleWhatsapp\" keep-result=no" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=may/26/2025 start-time=19:41:32
/system scheduler add comment=https://csgarnet.id/ interval=7m name="Check Tripay - https://csgarnet.id/" on-event="/tool fetch url=\"https://csgarnet.id/tripay/transaction\" keep-result=no" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=may/26/2025 start-time=19:41:32
/system scheduler add comment=https://csgarnet.id/ interval=10m name=ISOLIR-https://csgarnet.id/ on-event="/tool fetch url=\"https://csgarnet.id/schedule/isolir/qvg7nLDjgvhnWIWw\" keep-result=no" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=may/26/2025 start-time=19:41:32
/system scheduler add comment=https://csgarnet.id/ interval=50m name=COUNT-USAGE-https://csgarnet.id/ on-event="/tool fetch url=\"https://csgarnet.id/schedule/countpppoe/qvg7nLDjgvhnWIWw\" keep-result=no" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=may/26/2025 start-time=19:41:32
/system scheduler add comment=https://portal.tekra.id/ interval=25m name="Dell Double Income - https://portal.tekra.id/" on-event="/tool fetch url=\"https://portal.tekra.id/schedule/delldoubleincome\" keep-result=no" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=may/27/2025 start-time=14:23:40
/system scheduler add comment=https://portal.tekra.id/ interval=8m name="Check Bill Payment - https://portal.tekra.id/" on-event="/tool fetch url=\"https://portal.tekra.id/schedule/cekbill\" keep-result=no" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=may/27/2025 start-time=14:23:40
/system scheduler add comment=https://portal.tekra.id/ interval=29m name="Dell Double Bill - https://portal.tekra.id/" on-event="/tool fetch url=\"https://portal.tekra.id/schedule/delldoublebill\" keep-result=no" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=may/27/2025 start-time=14:23:40
/system scheduler add comment=https://portal.tekra.id/ interval=31m name="Fix Item Bill - https://portal.tekra.id/" on-event="/tool fetch url=\"https://portal.tekra.id/schedule/fixitembill\" keep-result=no" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=may/27/2025 start-time=14:23:40
/system scheduler add comment=https://portal.tekra.id/ interval=16m name="Fix Due Date / Isolir Date - https://portal.tekra.id/" on-event="/tool fetch url=\"https://portal.tekra.id/schedule/fixduedate\" keep-result=no" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=may/27/2025 start-time=14:23:40
/system scheduler add comment=https://portal.tekra.id/ interval=6m name="Send Due date - https://portal.tekra.id/" on-event="/tool fetch url=\"https://portal.tekra.id/schedule/sendduedate\" keep-result=no" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=may/27/2025 start-time=14:23:40
/system scheduler add comment=https://portal.tekra.id/ interval=13m name="Send Before Due Date - https://portal.tekra.id/" on-event="/tool fetch url=\"https://portal.tekra.id/schedule/sendbeforeduedate\" keep-result=no" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=may/27/2025 start-time=14:23:41
/system scheduler add comment=https://portal.tekra.id/ interval=10m name="Generate Bill - https://portal.tekra.id/" on-event="/tool fetch url=\"https://portal.tekra.id/schedule/generatebill\" keep-result=no" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=may/27/2025 start-time=14:23:41
/system scheduler add comment=https://portal.tekra.id/ interval=1d name="Backup Database - https://portal.tekra.id/" on-event="/tool fetch url=\"https://portal.tekra.id/schedule/backupdatabase\" keep-result=no" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=may/27/2025 start-time=14:23:41
/system scheduler add comment=https://portal.tekra.id/ interval=1m name="Execute Whatsapp - https://portal.tekra.id/" on-event="/tool fetch url=\"https://portal.tekra.id/schedule/scheduleWhatsapp\" keep-result=no" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=may/27/2025 start-time=14:23:41
/system scheduler add comment=https://portal.tekra.id/ interval=7m name="Check Tripay - https://portal.tekra.id/" on-event="/tool fetch url=\"https://portal.tekra.id/tripay/transaction\" keep-result=no" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=may/27/2025 start-time=14:23:41
/system scheduler add comment=https://portal.tekra.id/ interval=10m name=ISOLIR-https://portal.tekra.id/ on-event="/tool fetch url=\"https://portal.tekra.id/schedule/isolir/qvg7nLDjgvhnWIWw\" keep-result=no" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=may/27/2025 start-time=14:23:41
/system scheduler add comment=https://portal.tekra.id/ interval=50m name=COUNT-USAGE-https://portal.tekra.id/ on-event="/tool fetch url=\"https://portal.tekra.id/schedule/countpppoe/qvg7nLDjgvhnWIWw\" keep-result=no" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=may/27/2025 start-time=14:23:41
/system scheduler add interval=1m name=tunnel-scheduler-18566 on-event=":local ip \"10.46.0.1\"\r\
    \n:local interface \"tunnel-18566\"\r\
    \n\r\
    \n:if ([/ping \$ip count=5] = 0) do {\r\
    \n:log warning \"Interface \$interface is restarting\"\r\
    \n/interface disable \$interface\r\
    \n:delay 3\r\
    \n/interface enable \$interface\r\
    \n}" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=nov/01/2025 start-time=13:45:19
/system script add dont-require-permissions=no name=reset-pppoe-aldy owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-aldy>"
/system script add dont-require-permissions=no name=reset-pppoe-DEVI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-DEVI>"
/system script add dont-require-permissions=no name=reset-pppoe-KEMBAR owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-KEMBAR>"
/system script add dont-require-permissions=no name=reset-pppoe-MAMAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-MAMAN>"
/system script add dont-require-permissions=no name=reset-pppoe-ARI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-ARI>"
/system script add dont-require-permissions=no name=reset-pppoe-DENI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-DENI>"
/system script add dont-require-permissions=no name=reset-pppoe-WILLY owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-WILLY>"
/system script add dont-require-permissions=no name=reset-pppoe-EPON owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-EPON>"
/system script add dont-require-permissions=no name=reset-pppoe-ALDY owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-ALDY>"
/system script add dont-require-permissions=no name=reset-pppoe-ANDRI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-ANDRI>"
/system script add dont-require-permissions=no name=reset-pppoe-WULAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-WULAN>"
/system script add dont-require-permissions=no name=reset-pppoe-SELAMET owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-SELAMET>"
/system script add dont-require-permissions=no name=reset-pppoe-ABANG owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-ABANG>"
/system script add dont-require-permissions=no name=reset-pppoe-NINA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-NINA>"
/system script add dont-require-permissions=no name=reset-pppoe-TOTO owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-TOTO>"
/system script add dont-require-permissions=no name=reset-pppoe-IZAL owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-IZAL>"
/system script add dont-require-permissions=no name=reset-pppoe-SARAH owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-SARAH>"
/system script add dont-require-permissions=no name=reset-pppoe-LASTRI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-LASTRI>"
/system script add dont-require-permissions=no name=reset-pppoe-FITRIYANI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-FITRIYANI>"
/system script add dont-require-permissions=no name=reset-pppoe-NONO owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-NONO>"
/system script add dont-require-permissions=no name=reset-pppoe-SARI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-SARI>"
/system script add dont-require-permissions=no name=reset-pppoe-TARYANA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-TARYANA>"
/system script add dont-require-permissions=no name=reset-pppoe-DIDIN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-DIDIN>"
/system script add dont-require-permissions=no name=reset-pppoe-EMAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-EMAN>"
/system script add dont-require-permissions=no name=reset-pppoe-WIRO owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-WIRO>"
/system script add dont-require-permissions=no name=reset-pppoe-SUGIARTO owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-SUGIARTO>"
/system script add dont-require-permissions=no name=reset-pppoe-HENI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-HENI>"
/system script add dont-require-permissions=no name=reset-pppoe-FERY owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-FERY>"
/system script add dont-require-permissions=no name=reset-pppoe-AMAT owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-AMAT>"
/system script add dont-require-permissions=no name=reset-pppoe-MAYANG owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-MAYANG>"
/system script add dont-require-permissions=no name=reset-pppoe-KALUA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-KALUA>"
/system script add dont-require-permissions=no name=reset-pppoe-TUNTAS owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-TUNTAS>"
/system script add dont-require-permissions=no name=reset-pppoe-DAYAT owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-DAYAT>"
/system script add dont-require-permissions=no name=reset-pppoe-RIKA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-RIKA>"
/system script add dont-require-permissions=no name=reset-pppoe-CECEP owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-CECEP>"
/system script add dont-require-permissions=no name=reset-pppoe-DINI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-DINI>"
/system script add dont-require-permissions=no name=reset-pppoe-FENY owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-FENY>"
/system script add dont-require-permissions=no name=reset-pppoe-ADE owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-ADE>"
/system script add dont-require-permissions=no name=reset-pppoe-RATNA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-RATNA>"
/system script add dont-require-permissions=no name=reset-pppoe-DIANEKA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-DIANEKA>"
/system script add dont-require-permissions=no name=reset-pppoe-FERRY owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-FERRY>"
/system script add dont-require-permissions=no name=reset-pppoe-SRI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-SRI>"
/system script add dont-require-permissions=no name=reset-pppoe-ANI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-ANI>"
/system script add dont-require-permissions=no name=reset-pppoe-WIWI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-WIWI>"
/system script add dont-require-permissions=no name=reset-pppoe-YAYAT owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-YAYAT>"
/system script add dont-require-permissions=no name=reset-pppoe-SUHERMAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-SUHERMAN>"
/system script add dont-require-permissions=no name=reset-pppoe-NARTI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-NARTI>"
/system script add dont-require-permissions=no name=reset-pppoe-DETI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-DETI>"
/system script add dont-require-permissions=no name=reset-pppoe-DAPIT owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-DAPIT>"
/system script add dont-require-permissions=no name=reset-pppoe-FIKRI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-FIKRI>"
/system script add dont-require-permissions=no name=reset-pppoe-UKON owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-UKON>"
/system script add dont-require-permissions=no name=reset-pppoe-IRVAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-IRVAN>"
/system script add dont-require-permissions=no name=reset-pppoe-PUTRI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-PUTRI>"
/system script add dont-require-permissions=no name=reset-pppoe-JUMRI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-JUMRI>"
/system script add dont-require-permissions=no name=reset-pppoe-DEBI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-DEBI>"
/system script add dont-require-permissions=no name=reset-pppoe-ANWAR owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-ANWAR>"
/system script add dont-require-permissions=no name=reset-pppoe-FAHRUN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-FAHRUN>"
/system script add dont-require-permissions=no name=reset-pppoe-IKI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-IKI>"
/system script add dont-require-permissions=no name=reset-pppoe-ELIN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-ELIN>"
/system script add dont-require-permissions=no name=reset-pppoe-IRPAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-IRPAN>"
/system script add dont-require-permissions=no name=MIKA-T3571019420674AUWLC owner=MIKA-nov2024 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571019420674AUWLC;ATa5mgbuza;ATa5mgbuza"
/system script add dont-require-permissions=no name=MIKA-T3571019423876KG8BB owner=MIKA-nov2024 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571019423876KG8BB;ATjdtquexb;ATjdtquexb"
/system script add dont-require-permissions=no name=MIKA-T3571019426132EODAJ owner=MIKA-nov2024 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571019426132EODAJ;ATgp2lqpms;ATgp2lqpms"
/system script add dont-require-permissions=no name=MIKA-T3571019427116UB2IQ owner=MIKA-nov2024 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571019427116UB2IQ;AT8gcz4145;AT8gcz4145"
/system script add dont-require-permissions=no name=MIKA-T3571019434321KRL3L owner=MIKA-nov2024 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571019434321KRL3L;ATxp2y9qr8;ATxp2y9qr8"
/system script add dont-require-permissions=no name=MIKA-T3571020200038QD0QY owner=MIKA-nov2024 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571020200038QD0QY;AT2t3chubn;AT2t3chubn"
/system script add dont-require-permissions=no name=MIKA-T3571020288217YHBTP owner=MIKA-dec2024 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571020288217YHBTP;ATadlngkay;ATadlngkay"
/system script add dont-require-permissions=no name=MIKA-T3571020635532RN5A9 owner=MIKA-dec2024 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571020635532RN5A9;AT0j8f1m1w;AT0j8f1m1w"
/system script add dont-require-permissions=no name=MIKA-T3571020911927GB6NY owner=MIKA-jan2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571020911927GB6NY;AT5yta34vh;AT5yta34vh"
/system script add dont-require-permissions=no name=MIKA-T3571020927745OFYSU owner=MIKA-jan2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571020927745OFYSU;ATfifwe3i5;ATfifwe3i5"
/system script add dont-require-permissions=no name=MIKA-T35710209362053CYCT owner=MIKA-jan2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T35710209362053CYCT;ATv0f2iw85;ATv0f2iw85"
/system script add dont-require-permissions=no name=MIKA-T3571020943217ZESMO owner=MIKA-jan2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571020943217ZESMO;ATsqbcryrz;ATsqbcryrz"
/system script add dont-require-permissions=no name=MIKA-T3571020956731QYMQW owner=MIKA-jan2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571020956731QYMQW;AT4woxri33;AT4woxri33"
/system script add dont-require-permissions=no name=MIKA-T3571020964738AR8IS owner=MIKA-jan2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571020964738AR8IS;ATtsy5d5l2;ATtsy5d5l2"
/system script add dont-require-permissions=no name=MIKA-T3571020980534XAR77 owner=MIKA-jan2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571020980534XAR77;ATf3tba5aq;ATf3tba5aq"
/system script add dont-require-permissions=no name=MIKA-T3571020981322CDUS3 owner=MIKA-jan2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571020981322CDUS3;AT9zfdvgyx;AT9zfdvgyx"
/system script add dont-require-permissions=no name=MIKA-T3571021009980JKXCM owner=MIKA-jan2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571021009980JKXCM;ATzxz3vxyo;ATzxz3vxyo"
/system script add dont-require-permissions=no name=MIKA-T3571021010700LJT5Y owner=MIKA-jan2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571021010700LJT5Y;ATdw8tkhdb;ATdw8tkhdb"
/system script add dont-require-permissions=no name=MIKA-T3571021022755WQ1R4 owner=MIKA-jan2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571021022755WQ1R4;ATfafanlql;ATfafanlql"
/system script add dont-require-permissions=no name=MIKA-T3571021027112DT7QB owner=MIKA-jan2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571021027112DT7QB;ATfq2huh7w;ATfq2huh7w"
/system script add dont-require-permissions=no name=MIKA-T35710210447708EPRY owner=MIKA-jan2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T35710210447708EPRY;ATy9vr5jao;ATy9vr5jao"
/system script add dont-require-permissions=no name=MIKA-T35710210490136D1JF owner=MIKA-jan2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T35710210490136D1JF;AT7lwf9ha2;AT7lwf9ha2"
/system script add dont-require-permissions=no name=MIKA-T3571021069265U0RC5 owner=MIKA-jan2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571021069265U0RC5;AToag7jjay;AToag7jjay"
/system script add dont-require-permissions=no name=MIKA-T3571021069760NTEX4 owner=MIKA-jan2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571021069760NTEX4;ATb4nvtem9;ATb4nvtem9"
/system script add dont-require-permissions=no name=MIKA-T3571021078969EHRYB owner=MIKA-jan2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571021078969EHRYB;ATt8u4valb;ATt8u4valb"
/system script add dont-require-permissions=no name=MIKA-T3571021085237QCN8D owner=MIKA-jan2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571021085237QCN8D;ATxcgzqsf3;ATxcgzqsf3"
/system script add dont-require-permissions=no name=MIKA-T3571021100725LNBKZ owner=MIKA-jan2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571021100725LNBKZ;ATokhx83lk;ATokhx83lk"
/system script add dont-require-permissions=no name=MIKA-T3571021108103KIHBV owner=MIKA-jan2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571021108103KIHBV;ATdsxk5uju;ATdsxk5uju"
/system script add dont-require-permissions=no name=MIKA-T3571021114391JM0XN owner=MIKA-jan2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571021114391JM0XN;ATzqyuhu9f;ATzqyuhu9f"
/system script add dont-require-permissions=no name=MIKA-T3571021116993SNCEF owner=MIKA-jan2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571021116993SNCEF;AT0aksxxm5;AT0aksxxm5"
/system script add dont-require-permissions=no name=MIKA-T3571021134443XT8VQ owner=MIKA-jan2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571021134443XT8VQ;ATqivoo24j;ATqivoo24j"
/system script add dont-require-permissions=no name=MIKA-T3571021140803V4BB5 owner=MIKA-jan2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571021140803V4BB5;AT20jemhq7;AT20jemhq7"
/system script add dont-require-permissions=no name=MIKA-T35710212192665XDJ3 owner=MIKA-jan2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T35710212192665XDJ3;ATpb5gnlvw;ATpb5gnlvw"
/system script add dont-require-permissions=no name=MIKA-T3571021285011NZ80U owner=MIKA-jan2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571021285011NZ80U;ATczo51k9a;ATczo51k9a"
/system script add dont-require-permissions=no name=MIKA-T3571021510234RBPMO owner=MIKA-feb2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571021510234RBPMO;AT0b5hila0;AT0b5hila0"
/system script add dont-require-permissions=no name=MIKA-T3571021559245UZNMI owner=MIKA-feb2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571021559245UZNMI;ATr24zfd09;ATr24zfd09"
/system script add dont-require-permissions=no name=MIKA-T3571021722786OKVQJ owner=MIKA-feb2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571021722786OKVQJ;AT3e7f7dws;AT3e7f7dws"
/system script add dont-require-permissions=no name=MIKA-T3571021739247FZPCN owner=MIKA-feb2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571021739247FZPCN;AT8lnogrns;AT8lnogrns"
/system script add dont-require-permissions=no name=MIKA-T3571021742910KLANW owner=MIKA-feb2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571021742910KLANW;ATdgzzo365;ATdgzzo365"
/system script add dont-require-permissions=no name=MIKA-T3571021774571EQHLO owner=MIKA-feb2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571021774571EQHLO;ATll3mj8o1;ATll3mj8o1"
/system script add dont-require-permissions=no name=MIKA-T3571021791664I3HSG owner=MIKA-feb2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571021791664I3HSG;ATyovp2tl0;ATyovp2tl0"
/system script add dont-require-permissions=no name=MIKA-T3571021835780LRJWC owner=MIKA-feb2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571021835780LRJWC;AT31tz9ov2;AT31tz9ov2"
/system script add dont-require-permissions=no name=MIKA-T3571021836949OW0YS owner=MIKA-feb2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571021836949OW0YS;AThhl9ezxw;AThhl9ezxw"
/system script add dont-require-permissions=no name=MIKA-T3571021842581OCPOV owner=MIKA-feb2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571021842581OCPOV;ATo86w04u5;ATo86w04u5"
/system script add dont-require-permissions=no name=MIKA-T3571021854328BOJVP owner=MIKA-feb2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571021854328BOJVP;ATdwsit89g;ATdwsit89g"
/system script add dont-require-permissions=no name=MIKA-T3571021854735J1ALE owner=MIKA-feb2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571021854735J1ALE;AT8i4pfz91;AT8i4pfz91"
/system script add dont-require-permissions=no name=MIKA-T3571021856534VMBZ2 owner=MIKA-feb2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571021856534VMBZ2;ATpagvk2kq;ATpagvk2kq"
/system script add dont-require-permissions=no name=MIKA-T3571021863804PEVVZ owner=MIKA-feb2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571021863804PEVVZ;ATp32mtj7g;ATp32mtj7g"
/system script add dont-require-permissions=no name=MIKA-T3571021863869KDRQD owner=MIKA-feb2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571021863869KDRQD;ATj7tscqhh;ATj7tscqhh"
/system script add dont-require-permissions=no name=MIKA-T3571021868862U1ZSU owner=MIKA-feb2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571021868862U1ZSU;ATt78geb7a;ATt78geb7a"
/system script add dont-require-permissions=no name=MIKA-T3571021873234Q2PRC owner=MIKA-feb2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571021873234Q2PRC;ATl0rl3kg1;ATl0rl3kg1"
/system script add dont-require-permissions=no name=MIKA-T3571021874061DEJNM owner=MIKA-feb2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571021874061DEJNM;ATi97bsn3b;ATi97bsn3b"
/system script add dont-require-permissions=no name=MIKA-T35710218805447USBT owner=MIKA-feb2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T35710218805447USBT;ATthxuy7qf;ATthxuy7qf"
/system script add dont-require-permissions=no name=MIKA-T35710218899207OCSQ owner=MIKA-feb2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T35710218899207OCSQ;ATv7p5vuf8;ATv7p5vuf8"
/system script add dont-require-permissions=no name=MIKA-T3571021890604QGHON owner=MIKA-feb2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571021890604QGHON;ATrcvubb4w;ATrcvubb4w"
/system script add dont-require-permissions=no name=MIKA-T35710218955060SUGR owner=MIKA-feb2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T35710218955060SUGR;AT8mhf23dx;AT8mhf23dx"
/system script add dont-require-permissions=no name=MIKA-T35710219017695YCMD owner=MIKA-feb2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T35710219017695YCMD;ATd9bdhaib;ATd9bdhaib"
/system script add dont-require-permissions=no name=MIKA-T3571021905014UWSLQ owner=MIKA-feb2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571021905014UWSLQ;AT4s718z7r;AT4s718z7r"
/system script add dont-require-permissions=no name=MIKA-T3571021906483BILPO owner=MIKA-feb2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571021906483BILPO;AT12n3p4vf;AT12n3p4vf"
/system script add dont-require-permissions=no name=MIKA-T3571021906672PJEZB owner=MIKA-feb2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571021906672PJEZB;ATgm3yu8z1;ATgm3yu8z1"
/system script add dont-require-permissions=no name=MIKA-T3571021911553KXPWD owner=MIKA-feb2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571021911553KXPWD;AT739rkcdc;AT739rkcdc"
/system script add dont-require-permissions=no name=MIKA-T3571021919901XVKAO owner=MIKA-feb2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571021919901XVKAO;ATtglc63di;ATtglc63di"
/system script add dont-require-permissions=no name=MIKA-T3571021921687RLFPU owner=MIKA-feb2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571021921687RLFPU;AT9aje4di6;AT9aje4di6"
/system script add dont-require-permissions=no name=MIKA-T3571021926012RVZDA owner=MIKA-feb2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571021926012RVZDA;ATdttvtebb;ATdttvtebb"
/system script add dont-require-permissions=no name=MIKA-T35710219292088DM1O owner=MIKA-feb2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T35710219292088DM1O;ATx2qdr5yn;ATx2qdr5yn"
/system script add dont-require-permissions=no name=MIKA-T3571021955727QASIY owner=MIKA-mar2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571021955727QASIY;ATkctz960e;ATkctz960e"
/system script add dont-require-permissions=no name=MIKA-T3571021983860GUJ7V owner=MIKA-mar2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571021983860GUJ7V;ATxk1qp66b;ATxk1qp66b"
/system script add dont-require-permissions=no name=MIKA-T3571021984011CXNPL owner=MIKA-mar2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571021984011CXNPL;AT1p67b2w1;AT1p67b2w1"
/system script add dont-require-permissions=no name=MIKA-T3571021985180QBF7I owner=MIKA-mar2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571021985180QBF7I;AT3r2qb40b;AT3r2qb40b"
/system script add dont-require-permissions=no name=MIKA-T3571021991991O7SPW owner=MIKA-mar2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571021991991O7SPW;AT6p183kmd;AT6p183kmd"
/system script add dont-require-permissions=no name=MIKA-T35710220195120DIAI owner=MIKA-mar2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T35710220195120DIAI;ATzz72ytqg;ATzz72ytqg"
/system script add dont-require-permissions=no name=MIKA-T3571022132036CE5VB owner=MIKA-mar2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571022132036CE5VB;ATc1qg2fum;ATc1qg2fum"
/system script add dont-require-permissions=no name=MIKA-T3571022137078HIVGN owner=MIKA-mar2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571022137078HIVGN;ATgmll60lu;ATgmll60lu"
/system script add dont-require-permissions=no name=MIKA-T3571022142471DAKXC owner=MIKA-mar2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571022142471DAKXC;ATelhdh8ny;ATelhdh8ny"
/system script add dont-require-permissions=no name=MIKA-T3571022143239FGV2K owner=MIKA-mar2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571022143239FGV2K;AThnjaaxkh;AThnjaaxkh"
/system script add dont-require-permissions=no name=MIKA-T3571022224848G7RNU owner=MIKA-mar2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571022224848G7RNU;AT1f62epgq;AT1f62epgq"
/system script add dont-require-permissions=no name=MIKA-T3571022258368CZ7OT owner=MIKA-mar2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571022258368CZ7OT;ATp94r9hvd;ATp94r9hvd"
/system script add dont-require-permissions=no name=MIKA-T3571022280971LGAG0 owner=MIKA-mar2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571022280971LGAG0;AT2zi8wibx;AT2zi8wibx"
/system script add dont-require-permissions=no name=MIKA-T3571022287805I2OKB owner=MIKA-mar2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571022287805I2OKB;AT7u4z6dpx;AT7u4z6dpx"
/system script add dont-require-permissions=no name=MIKA-T3571022322747ZNZQQ owner=MIKA-mar2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571022322747ZNZQQ;ATnsy8kasm;ATnsy8kasm"
/system script add dont-require-permissions=no name=MIKA-T3571022466965Y276D owner=MIKA-mar2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571022466965Y276D;ATj6u8lhbi;ATj6u8lhbi"
/system script add dont-require-permissions=no name=MIKA-T3571022486087K7KNG owner=MIKA-mar2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571022486087K7KNG;AThjv67u1x;AThjv67u1x"
/system script add dont-require-permissions=no name=MIKA-T3571022492587JLYCF owner=MIKA-mar2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571022492587JLYCF;ATojd7cv8t;ATojd7cv8t"
/system script add dont-require-permissions=no name=MIKA-T3571022525832QFEVT owner=MIKA-mar2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571022525832QFEVT;AT5iigeyj3;AT5iigeyj3"
/system script add dont-require-permissions=no name=MIKA-T3571022544549BFQRQ owner=MIKA-mar2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571022544549BFQRQ;AT8bql5jq6;AT8bql5jq6"
/system script add dont-require-permissions=no name=MIKA-T3571022548947BXBUV owner=MIKA-mar2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571022548947BXBUV;ATha092ek3;ATha092ek3"
/system script add dont-require-permissions=no name=MIKA-T357102256802865CNR owner=MIKA-mar2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T357102256802865CNR;AT2ugeocne;AT2ugeocne"
/system script add dont-require-permissions=no name=MIKA-T35710226840185QMZ6 owner=MIKA-apr2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T35710226840185QMZ6;ATks7sekhz;ATks7sekhz"
/system script add dont-require-permissions=no name=MIKA-T3571022705769UMSQ3 owner=MIKA-apr2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571022705769UMSQ3;AT3f6t814z;AT3f6t814z"
/system script add dont-require-permissions=no name=MIKA-T3571022728473FQMOR owner=MIKA-apr2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571022728473FQMOR;AT1220he8c;AT1220he8c"
/system script add dont-require-permissions=no name=MIKA-T3571022743785U1BEX owner=MIKA-apr2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571022743785U1BEX;ATpw5eqbzp;ATpw5eqbzp"
/system script add dont-require-permissions=no name=MIKA-T3571022783506FMECW owner=MIKA-apr2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571022783506FMECW;AT22c13uwr;AT22c13uwr"
/system script add dont-require-permissions=no name=MIKA-T3571022834367MVYDK owner=MIKA-apr2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571022834367MVYDK;ATm23smhj0;ATm23smhj0"
/system script add dont-require-permissions=no name=MIKA-T3571022937972YO8GX owner=MIKA-apr2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571022937972YO8GX;ATtmkkmr54;ATtmkkmr54"
/system script add dont-require-permissions=no name=MIKA-T3571022993869HVKUC owner=MIKA-apr2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571022993869HVKUC;ATe855bfn9;ATe855bfn9"
/system script add dont-require-permissions=no name=MIKA-T3571023076296QGXK3 owner=MIKA-apr2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571023076296QGXK3;AT24i7uxg7;AT24i7uxg7"
/system script add dont-require-permissions=no name=MIKA-T3571023108640LSKN9 owner=MIKA-apr2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571023108640LSKN9;AT4cgdh2k9;AT4cgdh2k9"
/system script add dont-require-permissions=no name=MIKA-T3571023176988SGQRV owner=MIKA-apr2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571023176988SGQRV;ATmmdrpanh;ATmmdrpanh"
/system script add dont-require-permissions=no name=MIKA-T3571023185694BLM2B owner=MIKA-apr2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571023185694BLM2B;ATtd5vqvv4;ATtd5vqvv4"
/system script add dont-require-permissions=no name=MIKA-T3571023191029MEZ3B owner=MIKA-apr2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571023191029MEZ3B;AT0r2ucuyb;AT0r2ucuyb"
/system script add dont-require-permissions=no name=MIKA-T3571023229175ONRCV owner=MIKA-apr2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571023229175ONRCV;ATg5tpd94x;ATg5tpd94x"
/system script add dont-require-permissions=no name=MIKA-T3571023303165XCOYS owner=MIKA-may2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571023303165XCOYS;ATls4pqrzt;ATls4pqrzt"
/system script add dont-require-permissions=no name=MIKA-T3571023403217XUSPE owner=MIKA-may2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571023403217XUSPE;AT414i3orb;AT414i3orb"
/system script add dont-require-permissions=no name=MIKA-T3571023405215DTEEA owner=MIKA-may2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571023405215DTEEA;ATczq9bhr4;ATczq9bhr4"
/system script add dont-require-permissions=no name=MIKA-T3571023406364IZKPU owner=MIKA-may2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571023406364IZKPU;ATf2bpjqbr;ATf2bpjqbr"
/system script add dont-require-permissions=no name=MIKA-T3571023429058HQZYR owner=MIKA-may2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571023429058HQZYR;ATqnr6dzlp;ATqnr6dzlp"
/system script add dont-require-permissions=no name=MIKA-T3571023434147EGFDO owner=MIKA-may2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571023434147EGFDO;ATuphezj12;ATuphezj12"
/system script add dont-require-permissions=no name=MIKA-T3571023446086SENRO owner=MIKA-may2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571023446086SENRO;ATnd64awt8;ATnd64awt8"
/system script add dont-require-permissions=no name=MIKA-T3571024133115FEBEN owner=MIKA-may2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571024133115FEBEN;ATh42dmpxy;ATh42dmpxy"
/system script add dont-require-permissions=no name=MIKA-T3571024178851ZII0Y owner=MIKA-may2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571024178851ZII0Y;ATwci91l3h;ATwci91l3h"
/system script add dont-require-permissions=no name=MIKA-T35710242553843X5AY owner=MIKA-may2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T35710242553843X5AY;AT4clz6nld;AT4clz6nld"
/system script add dont-require-permissions=no name=MIKA-T3571024255992Q56UD owner=MIKA-may2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571024255992Q56UD;ATbpea2nx5;ATbpea2nx5"
/system script add dont-require-permissions=no name=MIKA-T35710242740032IRSH owner=MIKA-may2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T35710242740032IRSH;ATw7frh7o5;ATw7frh7o5"
/system script add dont-require-permissions=no name=MIKA-T3571024276017LG2IK owner=MIKA-may2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571024276017LG2IK;ATknou3v3t;ATknou3v3t"
/system script add dont-require-permissions=no name=MIKA-T3571024322465UHILY owner=MIKA-may2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571024322465UHILY;ATpiyonh0t;ATpiyonh0t"
/system script add dont-require-permissions=no name=MIKA-T3571024324886O69IK owner=MIKA-may2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571024324886O69IK;ATdrehp91f;ATdrehp91f"
/system script add dont-require-permissions=no name=MIKA-T3571024326150EB5IC owner=MIKA-may2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571024326150EB5IC;ATkc2fhykw;ATkc2fhykw"
/system script add dont-require-permissions=no name=MIKA-T3571024378947FHHRJ owner=MIKA-jun2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571024378947FHHRJ;AT8o96oaad;AT8o96oaad"
/system script add dont-require-permissions=no name=MIKA-T3571024422515WDNSH owner=MIKA-jun2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571024422515WDNSH;ATf4xel8ow;ATf4xel8ow"
/system script add dont-require-permissions=no name=MIKA-T3571024464341UCT4B owner=MIKA-jun2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571024464341UCT4B;ATqxbggcw5;ATqxbggcw5"
/system script add dont-require-permissions=no name=MIKA-T3571024534054N3GPZ owner=MIKA-jun2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571024534054N3GPZ;AT4oubhkw8;AT4oubhkw8"
/system script add dont-require-permissions=no name=MIKA-T357102455543410KGG owner=MIKA-jun2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T357102455543410KGG;AT16i5lz1l;AT16i5lz1l"
/system script add dont-require-permissions=no name=MIKA-T3571024555619XO0N1 owner=MIKA-jun2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571024555619XO0N1;AT95dy2svu;AT95dy2svu"
/system script add dont-require-permissions=no name=MIKA-T3571024570791KVLWE owner=MIKA-jun2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571024570791KVLWE;ATfl6idk8z;ATfl6idk8z"
/system script add dont-require-permissions=no name=MIKA-T3571024590722IIXNM owner=MIKA-jun2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571024590722IIXNM;ATnhlhtikq;ATnhlhtikq"
/system script add dont-require-permissions=no name=MIKA-T3571024681735WIYFQ owner=MIKA-jun2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571024681735WIYFQ;AT86pcdiw2;AT86pcdiw2"
/system script add dont-require-permissions=no name=MIKA-T3571024712438PNZDW owner=MIKA-jun2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571024712438PNZDW;AT8n05uzj6;AT8n05uzj6"
/system script add dont-require-permissions=no name=MIKA-T3571024778466QD83N owner=MIKA-jun2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571024778466QD83N;ATdgk7r5ns;ATdgk7r5ns"
/system script add dont-require-permissions=no name=MIKA-T3571024803312UDSK6 owner=MIKA-jun2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571024803312UDSK6;ATfvrdoy3e;ATfvrdoy3e"
/system script add dont-require-permissions=no name=MIKA-T3571024813000K7TSB owner=MIKA-jun2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571024813000K7TSB;ATnoqvy87c;ATnoqvy87c"
/system script add dont-require-permissions=no name=MIKA-T3571024844238DTYBV owner=MIKA-jun2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571024844238DTYBV;ATdrco4brv;ATdrco4brv"
/system script add dont-require-permissions=no name=MIKA-T3571024876118W0EUD owner=MIKA-jun2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571024876118W0EUD;ATilb19ejf;ATilb19ejf"
/system script add dont-require-permissions=no name=MIKA-T35710249000255Z5RT owner=MIKA-jun2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T35710249000255Z5RT;AT4j02wgip;AT4j02wgip"
/system script add dont-require-permissions=no name=MIKA-T3571024900540VNUBJ owner=MIKA-jun2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571024900540VNUBJ;ATrhjwpvjn;ATrhjwpvjn"
/system script add dont-require-permissions=no name=MIKA-T3571024912499LZNEZ owner=MIKA-jun2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571024912499LZNEZ;AT5cvhhxop;AT5cvhhxop"
/system script add dont-require-permissions=no name=MIKA-T3571025016258ZV3MA owner=MIKA-jun2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571025016258ZV3MA;ATaq0ruju9;ATaq0ruju9"
/system script add dont-require-permissions=no name=MIKA-T3571025033928PGIUY owner=MIKA-jun2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571025033928PGIUY;ATzendvlko;ATzendvlko"
/system script add dont-require-permissions=no name=MIKA-T3571025035747WZZZQ owner=MIKA-jun2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571025035747WZZZQ;ATkl9rhvco;ATkl9rhvco"
/system script add dont-require-permissions=no name=MIKA-T3571025062332RSBDU owner=MIKA-jun2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571025062332RSBDU;AT0gsk0xr8;AT0gsk0xr8"
/system script add dont-require-permissions=no name=MIKA-T3571025227736VPGCA owner=MIKA-jul2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571025227736VPGCA;ATg6ok8dt5;ATg6ok8dt5"
/system script add dont-require-permissions=no name=MIKA-T3571025281108YHRMG owner=MIKA-jul2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571025281108YHRMG;AT6qom0hmv;AT6qom0hmv"
/system script add dont-require-permissions=no name=MIKA-T3571025392606RD6DW owner=MIKA-jul2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571025392606RD6DW;AT347zikj5;AT347zikj5"
/system script add dont-require-permissions=no name=MIKA-T35710257085890DISN owner=MIKA-jul2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T35710257085890DISN;ATjilfdgfr;ATjilfdgfr"
/system script add dont-require-permissions=no name=MIKA-T3571025738902LAP59 owner=MIKA-jul2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571025738902LAP59;AT0pavfsqh;AT0pavfsqh"
/system script add dont-require-permissions=no name=MIKA-T3571025764081JTE2G owner=MIKA-jul2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571025764081JTE2G;ATwamcjw9q;ATwamcjw9q"
/system script add dont-require-permissions=no name=MIKA-T3571025916414XMW04 owner=MIKA-aug2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571025916414XMW04;ATsap3g9dq;ATsap3g9dq"
/system script add dont-require-permissions=no name=MIKA-T35710259734430OIIX owner=MIKA-aug2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T35710259734430OIIX;ATqxqthald;ATqxqthald"
/system script add dont-require-permissions=no name=MIKA-T35710259785023QJ5Y owner=MIKA-aug2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T35710259785023QJ5Y;ATzyvqhmu4;ATzyvqhmu4"
/system script add dont-require-permissions=no name=MIKA-T357102604059960RMW owner=MIKA-aug2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T357102604059960RMW;AT7k4jcnf7;AT7k4jcnf7"
/system script add dont-require-permissions=no name=MIKA-T3571026043518RXJ8P owner=MIKA-aug2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571026043518RXJ8P;AT0n5inixu;AT0n5inixu"
/system script add dont-require-permissions=no name=MIKA-T3571026046440TICPJ owner=MIKA-aug2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571026046440TICPJ;ATxoode1kw;ATxoode1kw"
/system script add dont-require-permissions=no name=MIKA-T3571026110036EDAHY owner=MIKA-aug2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571026110036EDAHY;ATg1xtp72z;ATg1xtp72z"
/system script add dont-require-permissions=no name=MIKA-T3571026163239C9PSO owner=MIKA-aug2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571026163239C9PSO;ATqrwjrs8d;ATqrwjrs8d"
/system script add dont-require-permissions=no name=MIKA-T3571026225871TWDXB owner=MIKA-aug2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571026225871TWDXB;AT7uxr8mi5;AT7uxr8mi5"
/system script add dont-require-permissions=no name=MIKA-T3571026245948U09AH owner=MIKA-aug2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571026245948U09AH;AT7uncqbyo;AT7uncqbyo"
/system script add dont-require-permissions=no name=MIKA-T3571026262064Q3B0K owner=MIKA-aug2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571026262064Q3B0K;ATh60ogywe;ATh60ogywe"
/system script add dont-require-permissions=no name=MIKA-T3571026262606JGCOV owner=MIKA-aug2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571026262606JGCOV;ATqzzvff5b;ATqzzvff5b"
/system script add dont-require-permissions=no name=MIKA-T3571026262622YV8W6 owner=MIKA-aug2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571026262622YV8W6;ATpral5kyb;ATpral5kyb"
/system script add dont-require-permissions=no name=MIKA-T3571026283311R5TOO owner=MIKA-aug2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571026283311R5TOO;ATd21s6r7x;ATd21s6r7x"
/system script add dont-require-permissions=no name=MIKA-T35710262900772UNV5 owner=MIKA-aug2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T35710262900772UNV5;ATfjr6cz82;ATfjr6cz82"
/system script add dont-require-permissions=no name=MIKA-T3571026302687RXOMG owner=MIKA-aug2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571026302687RXOMG;ATmjhpmd81;ATmjhpmd81"
/system script add dont-require-permissions=no name=MIKA-T3571026320509IRVK4 owner=MIKA-aug2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571026320509IRVK4;ATezvcd3un;ATezvcd3un"
/system script add dont-require-permissions=no name=MIKA-T3571026334886WVTVH owner=MIKA-aug2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571026334886WVTVH;ATk96m9kkd;ATk96m9kkd"
/system script add dont-require-permissions=no name=MIKA-T3571026366609D70YV owner=MIKA-aug2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571026366609D70YV;ATrsou6k95;ATrsou6k95"
/system script add dont-require-permissions=no name=MIKA-T3571026401954JDZW8 owner=MIKA-aug2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571026401954JDZW8;ATd1h5jiil;ATd1h5jiil"
/system script add dont-require-permissions=no name=MIKA-T35710264160412XXRQ owner=MIKA-aug2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T35710264160412XXRQ;ATwj6mn5ki;ATwj6mn5ki"
/system script add dont-require-permissions=no name=MIKA-T3571026430248Q4JF1 owner=MIKA-aug2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571026430248Q4JF1;AT54870g2k;AT54870g2k"
/system script add dont-require-permissions=no name=MIKA-T3571026442678VADO0 owner=MIKA-aug2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571026442678VADO0;ATjg3smi3h;ATjg3smi3h"
/system script add dont-require-permissions=no name=MIKA-T3571026517873WCBMV owner=MIKA-aug2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571026517873WCBMV;ATsq4nteaa;ATsq4nteaa"
/system script add dont-require-permissions=no name=MIKA-T3571026525026WL68T owner=MIKA-aug2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571026525026WL68T;AT8vz8ajy9;AT8vz8ajy9"
/system script add dont-require-permissions=no name=MIKA-T3571026533876JVQZX owner=MIKA-aug2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571026533876JVQZX;ATgbvvraxa;ATgbvvraxa"
/system script add dont-require-permissions=no name=MIKA-T3571026550214HFH0R owner=MIKA-sep2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571026550214HFH0R;ATp46q79ol;ATp46q79ol"
/system script add dont-require-permissions=no name=MIKA-T35710265716678QVTC owner=MIKA-sep2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T35710265716678QVTC;ATvbwuo1yp;ATvbwuo1yp"
/system script add dont-require-permissions=no name=MIKA-T357102667104683KLW owner=MIKA-sep2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T357102667104683KLW;AT68je6dbf;AT68je6dbf"
/system script add dont-require-permissions=no name=MIKA-T3571026673266RWBF3 owner=MIKA-sep2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571026673266RWBF3;ATmzr5emkl;ATmzr5emkl"
/system script add dont-require-permissions=no name=MIKA-T3571026798146WHSDP owner=MIKA-sep2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571026798146WHSDP;ATangveznn;ATangveznn"
/system script add dont-require-permissions=no name=MIKA-T35710268057252FZPK owner=MIKA-sep2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T35710268057252FZPK;ATglswi74c;ATglswi74c"
/system script add dont-require-permissions=no name=MIKA-T3571026806299H2OBW owner=MIKA-sep2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571026806299H2OBW;AT7xa3ylef;AT7xa3ylef"
/system script add dont-require-permissions=no name=MIKA-T3571026827944Q3AU7 owner=MIKA-sep2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571026827944Q3AU7;ATw96cf4rc;ATw96cf4rc"
/system script add dont-require-permissions=no name=MIKA-T3571026849876VHAKR owner=MIKA-sep2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571026849876VHAKR;ATh26rk82l;ATh26rk82l"
/system script add dont-require-permissions=no name=MIKA-T3571026911965G6ZOK owner=MIKA-sep2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571026911965G6ZOK;ATvcaqnju8;ATvcaqnju8"
/system script add dont-require-permissions=no name=MIKA-T3571026972933FH29P owner=MIKA-sep2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571026972933FH29P;ATzhwedj8h;ATzhwedj8h"
/system script add dont-require-permissions=no name=MIKA-T3571027051112QHAG8 owner=MIKA-sep2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571027051112QHAG8;AT86ykryoy;AT86ykryoy"
/system script add dont-require-permissions=no name=MIKA-T35710270703985HCUZ owner=MIKA-sep2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T35710270703985HCUZ;ATs3r3cq5c;ATs3r3cq5c"
/system script add dont-require-permissions=no name=MIKA-T3571027100448VXFF9 owner=MIKA-sep2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571027100448VXFF9;ATi3u5lul5;ATi3u5lul5"
/system script add dont-require-permissions=no name=MIKA-T3571027150458UYL7K owner=MIKA-sep2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571027150458UYL7K;ATwqkufz4g;ATwqkufz4g"
/system script add dont-require-permissions=no name=MIKA-T3571027159161DHLPJ owner=MIKA-sep2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571027159161DHLPJ;ATe2x98ika;ATe2x98ika"
/system script add dont-require-permissions=no name=MIKA-T3571027167501TLAFN owner=MIKA-sep2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571027167501TLAFN;ATbr61nomw;ATbr61nomw"
/system script add dont-require-permissions=no name=MIKA-T3571027202755AXCI7 owner=MIKA-sep2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571027202755AXCI7;ATpiqfuosz;ATpiqfuosz"
/system script add dont-require-permissions=no name=MIKA-T3571027208411HTLFG owner=MIKA-sep2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571027208411HTLFG;ATemlwz5o6;ATemlwz5o6"
/system script add dont-require-permissions=no name=MIKA-T3571027217196NLPM8 owner=MIKA-sep2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571027217196NLPM8;AToqmjs18t;AToqmjs18t"
/system script add dont-require-permissions=no name=MIKA-T3571027651431SMQQR owner=MIKA-oct2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571027651431SMQQR;ATican3fuw;ATican3fuw"
/system script add dont-require-permissions=no name=MIKA-T3571027681472JNZLX owner=MIKA-oct2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571027681472JNZLX;ATmo71rfi2;ATmo71rfi2"
/system script add dont-require-permissions=no name=MIKA-T35710276940105R0FR owner=MIKA-oct2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T35710276940105R0FR;ATu0k8vea7;ATu0k8vea7"
/system script add dont-require-permissions=no name=MIKA-T3571027694190D9XTD owner=MIKA-oct2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571027694190D9XTD;ATlyobgc1f;ATlyobgc1f"
/system script add dont-require-permissions=no name=MIKA-T3571027724600KOVKU owner=MIKA-oct2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571027724600KOVKU;ATy23gg6cq;ATy23gg6cq"
/system script add dont-require-permissions=no name=MIKA-T3571027727693ESG56 owner=MIKA-oct2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571027727693ESG56;ATz9nihwsx;ATz9nihwsx"
/system script add dont-require-permissions=no name=MIKA-T3571027770911KAE1W owner=MIKA-oct2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571027770911KAE1W;ATnl54rh6s;ATnl54rh6s"
/system script add dont-require-permissions=no name=MIKA-T3571027786037OXNEH owner=MIKA-oct2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571027786037OXNEH;ATo3e35n7y;ATo3e35n7y"
/system script add dont-require-permissions=no name=MIKA-T357102785047242UXY owner=MIKA-oct2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T357102785047242UXY;ATo8v3j8e7;ATo8v3j8e7"
/system script add dont-require-permissions=no name=MIKA-T35710278550283WAWE owner=MIKA-oct2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T35710278550283WAWE;ATnofpo3q5;ATnofpo3q5"
/system script add dont-require-permissions=no name=MIKA-T3571027860309ZRVE5 owner=MIKA-oct2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571027860309ZRVE5;ATs0fa6eyq;ATs0fa6eyq"
/system script add dont-require-permissions=no name=MIKA-T3571027866849CXEQA owner=MIKA-oct2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571027866849CXEQA;ATco8ejz76;ATco8ejz76"
/system script add dont-require-permissions=no name=MIKA-T3571027880562JHT8M owner=MIKA-oct2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571027880562JHT8M;ATngtyewme;ATngtyewme"
/system script add dont-require-permissions=no name=MIKA-T3571027919001OK7TH owner=MIKA-oct2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571027919001OK7TH;AT4tqdcip5;AT4tqdcip5"
/system script add dont-require-permissions=no name=MIKA-T3571027937071DHAKK owner=MIKA-oct2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571027937071DHAKK;ATg6p9icmz;ATg6p9icmz"
/system script add dont-require-permissions=no name=MIKA-T3571027954923URQDU owner=MIKA-oct2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571027954923URQDU;AT6t6co6y5;AT6t6co6y5"
/system script add dont-require-permissions=no name=MIKA-T3571027990413NHAWZ owner=MIKA-oct2025 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="T3571027990413NHAWZ;ATugs5accn;ATugs5accn"
/system script add dont-require-permissions=no name=MIKA-T3571028721593XJKE1 owner=mikhmon policy=read,write,sensitive source="T3571028721593XJKE1;ATmzbfgsob;ATmzbfgsob"
/system script add dont-require-permissions=no name=MIKA-T35710287314538XDW5 owner=mikhmon policy=read,write,sensitive source="T35710287314538XDW5;ATuvevxb8q;ATuvevxb8q"
/system script add dont-require-permissions=no name=MIKA-T3571028905670RTB3B owner=mikhmon policy=read,write,sensitive source="T3571028905670RTB3B;ATzk6vyiie;ATzk6vyiie"
/system script add dont-require-permissions=no name=MIKA-T3571029305059FQGIP owner=mikhmon policy=read,write,sensitive source="T3571029305059FQGIP;AThalz2pfi;AThalz2pfi"
/system script add dont-require-permissions=no name=MIKA-T3571029326652OTWOH owner=mikhmon policy=read,write,sensitive source="T3571029326652OTWOH;AT6ipr6lla;AT6ipr6lla"
/system script add dont-require-permissions=no name=MIKA-T3571029348154AMMMS owner=mikhmon policy=read,write,sensitive source="T3571029348154AMMMS;ATzs1sszq5;ATzs1sszq5"
/system script add dont-require-permissions=no name=MIKA-T3571029372568B4544 owner=mikhmon policy=read,write,sensitive source="T3571029372568B4544;ATslk7vbbn;ATslk7vbbn"
/system script add dont-require-permissions=no name=MIKA-T3571029456563WHMU6 owner=mikhmon policy=read,write,sensitive source="T3571029456563WHMU6;AT4p61zv4a;AT4p61zv4a"
/system script add dont-require-permissions=no name=MIKA-T3571029492851AEROA owner=mikhmon policy=read,write,sensitive source="T3571029492851AEROA;ATkjaruenf;ATkjaruenf"
/system script add dont-require-permissions=no name=update_pppoe_count owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\
    \n    :local active [/ppp active print count-only]\
    \n    /system note set note=\$active\
    \n"
/system script add dont-require-permissions=no name=MIKA-T3571030244189XJWFI owner=mikhmon policy=read,write,sensitive source="T3571030244189XJWFI;AT5vievs3i;AT5vievs3i"
/system script add dont-require-permissions=no name=MIKA-T35710302823210HV7K owner=mikhmon policy=read,write,sensitive source="T35710302823210HV7K;ATiipqf60r;ATiipqf60r"
/system script add dont-require-permissions=no name=MIKA-T3571030287976IYA8F owner=mikhmon policy=read,write,sensitive source="T3571030287976IYA8F;AT68xdqj34;AT68xdqj34"
/system script add dont-require-permissions=no name=MIKA-T3571030971024WL33F owner=mikhmon policy=read,write,sensitive source="T3571030971024WL33F;ATv86ntiek;ATv86ntiek"
/system script add dont-require-permissions=no name=MIKA-T3571031777211FQ307 owner=mikhmon policy=read,write,sensitive source="T3571031777211FQ307;ATa6z8bxep;ATa6z8bxep"
/system script add dont-require-permissions=no name=MIKA-T3571032720388UJMYL owner=mikhmon policy=read,write,sensitive source="T3571032720388UJMYL;ATfas6fbfk;ATfas6fbfk"
/system script add dont-require-permissions=no name=MIKA-T3571032726285DVGJK owner=mikhmon policy=read,write,sensitive source="T3571032726285DVGJK;AT6tiujmiy;AT6tiujmiy"
/system script add dont-require-permissions=no name=MIKA-T3571032976084T1EYM owner=mikhmon policy=read,write,sensitive source="T3571032976084T1EYM;ATirxxa9y2;ATirxxa9y2"
/system script add dont-require-permissions=no name=MIKA-T3571034408369SADO5 owner=mikhmon policy=read,write,sensitive source="T3571034408369SADO5;ATozpxbbai;ATozpxbbai"
/system script add comment=mikhmon dont-require-permissions=no name=jul/28/2026-|-09:31:00-|-2wf68-|-1500-|-192.168.44.202-|-DA:E6:36:B7:B2:BC-|-12h-|-Paket2jam-|-vc-116-06.24.26- owner=jul2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=jul/28/2026
/system script add comment=mikhmon dont-require-permissions=no name=jul/28/2026-|-10:10:17-|-2vf75-|-1500-|-192.168.44.119-|-8E:AA:71:EF:F1:04-|-12h-|-Paket2jam-|-vc-116-06.24.26- owner=jul2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=jul/28/2026
/system script add comment=mikhmon dont-require-permissions=no name=jul/28/2026-|-19:13:25-|-6rf26-|-2500-|-192.168.44.212-|-8E:AA:71:EF:F1:04-|-6h-|-Paket6jam-|-vc-852-06.24.26- owner=jul2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=jul/28/2026
/system script add comment=mikhmon dont-require-permissions=no name=jul/28/2026-|-19:17:07-|-6yf42-|-2500-|-192.168.44.198-|-6A:45:14:62:0D:5C-|-6h-|-Paket6jam-|-vc-852-06.24.26- owner=jul2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=jul/28/2026
/system script add comment=mikhmon dont-require-permissions=no name=jul/28/2026-|-20:24:47-|-6ca33-|-2500-|-192.168.44.69-|-34:8B:75:4E:45:89-|-6h-|-Paket6jam-|-vc-852-06.24.26- owner=jul2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=jul/28/2026
/system script add comment=mikhmon dont-require-permissions=no name=jul/29/2026-|-06:20:26-|-668r5-|-2500-|-192.168.44.177-|-5E:38:CD:06:4A:61-|-6h-|-Paket6jam-|-vc-954-01.09.26- owner=jul2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=jul/29/2026
/system script add comment=mikhmon dont-require-permissions=no name=jul/29/2026-|-10:12:31-|-6my84-|-2500-|-192.168.44.41-|-8E:AA:71:EF:F1:04-|-6h-|-Paket6jam-|-vc-852-06.24.26- owner=jul2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=jul/29/2026
/system script add comment=mikhmon dont-require-permissions=no name=jul/29/2026-|-10:29:20-|-2xb53-|-1500-|-192.168.44.180-|-30:CB:F8:EE:AC:CB-|-12h-|-Paket2jam-|-vc-116-06.24.26- owner=jul2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=jul/29/2026
/system script add comment=mikhmon dont-require-permissions=no name=jul/29/2026-|-14:52:35-|-2js64-|-1500-|-192.168.44.66-|-30:CB:F8:EE:AC:CB-|-12h-|-Paket2jam-|-vc-116-06.24.26- owner=jul2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=jul/29/2026
/system script add comment=mikhmon dont-require-permissions=no name=jul/29/2026-|-17:14:07-|-2zx58-|-1500-|-192.168.44.218-|-88:D5:0C:22:4C:79-|-12h-|-Paket2jam-|-vc-116-06.24.26- owner=jul2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=jul/29/2026
/system script add comment=mikhmon dont-require-permissions=no name=jul/29/2026-|-18:57:41-|-6tn72-|-2500-|-192.168.44.189-|-8E:AA:71:EF:F1:04-|-6h-|-Paket6jam-|-vc-852-06.24.26- owner=jul2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=jul/29/2026
/system script add comment=mikhmon dont-require-permissions=no name=jul/29/2026-|-19:08:08-|-6wf83-|-2500-|-10.10.10.246-|-6A:75:1C:60:9E:09-|-6h-|-Paket6jam-|-vc-852-06.24.26- owner=jul2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=jul/29/2026
/system script add comment=mikhmon dont-require-permissions=no name=jul/30/2026-|-06:27:59-|-2ef78-|-1500-|-10.10.10.237-|-8E:AA:71:EF:F1:04-|-12h-|-Paket2jam-|-vc-116-06.24.26- owner=jul2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=jul/30/2026
/system script add comment=mikhmon dont-require-permissions=no name=jul/30/2026-|-08:48:46-|-63r87-|-2500-|-192.168.44.227-|-76:6D:3C:DE:52:FA-|-6h-|-Paket6jam-|-vc-954-01.09.26- owner=jul2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=jul/30/2026
/system script add comment=mikhmon dont-require-permissions=no name=jul/30/2026-|-11:21:07-|-2hf38-|-1500-|-192.168.44.104-|-30:CB:F8:EE:AC:CB-|-12h-|-Paket2jam-|-vc-116-06.24.26- owner=jul2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=jul/30/2026
/system script add comment=mikhmon dont-require-permissions=no name=jul/30/2026-|-11:34:36-|-2nc72-|-1500-|-192.168.44.124-|-88:D5:0C:22:4C:79-|-12h-|-Paket2jam-|-vc-116-06.24.26- owner=jul2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=jul/30/2026
/system script add comment=mikhmon dont-require-permissions=no name=jul/30/2026-|-17:40:40-|-6zb34-|-2500-|-192.168.44.94-|-6A:75:1C:60:9E:09-|-6h-|-Paket6jam-|-vc-852-06.24.26- owner=jul2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=jul/30/2026
/system script add comment=mikhmon dont-require-permissions=no name=jul/30/2026-|-18:13:21-|-6kv47-|-2500-|-192.168.44.211-|-8E:AA:71:EF:F1:04-|-6h-|-Paket6jam-|-vc-852-06.24.26- owner=jul2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=jul/30/2026
/system script add comment=mikhmon dont-require-permissions=no name=jul/30/2026-|-20:43:39-|-2fp69-|-1500-|-192.168.44.85-|-0C:98:38:FA:92:95-|-12h-|-Paket2jam-|-vc-116-06.24.26- owner=jul2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=jul/30/2026
/system script add comment=mikhmon dont-require-permissions=no name=jul/31/2026-|-06:41:51-|-2rg34-|-1500-|-192.168.44.246-|-12:16:E8:6B:2F:5B-|-12h-|-Paket2jam-|-vc-116-06.24.26- owner=jul2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=jul/31/2026
/system script add comment=mikhmon dont-require-permissions=no name=jul/31/2026-|-06:42:20-|-2cc33-|-1500-|-192.168.44.85-|-0C:98:38:FA:92:95-|-12h-|-Paket2jam-|-vc-116-06.24.26- owner=jul2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=jul/31/2026
/system script add comment=mikhmon dont-require-permissions=no name=jul/31/2026-|-06:42:24-|-2bb49-|-1500-|-192.168.44.231-|-30:CB:F8:EE:AC:CB-|-12h-|-Paket2jam-|-vc-116-06.24.26- owner=jul2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=jul/31/2026
/system script add comment=mikhmon dont-require-permissions=no name=jul/31/2026-|-07:13:14-|-6mg56-|-2500-|-192.168.44.229-|-96:F9:8C:E3:73:52-|-6h-|-Paket6jam-|-vc-852-06.24.26- owner=jul2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=jul/31/2026
/system script add comment=mikhmon dont-require-permissions=no name=jul/31/2026-|-19:13:45-|-6ds25-|-2500-|-192.168.44.249-|-6A:75:1C:60:9E:09-|-6h-|-Paket6jam-|-vc-852-06.24.26- owner=jul2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=jul/31/2026
/system script add comment=mikhmon dont-require-permissions=no name=jul/31/2026-|-19:43:16-|-6th92-|-2500-|-192.168.44.203-|-44:46:87:90:80:AD-|-6h-|-Paket6jam-|-vc-852-06.24.26- owner=jul2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=jul/31/2026
/system script add comment=mikhmon dont-require-permissions=no name=jul/31/2026-|-20:04:36-|-6nh49-|-2500-|-192.168.44.207-|-96:F9:8C:E3:73:52-|-6h-|-Paket6jam-|-vc-852-06.24.26- owner=jul2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=jul/31/2026
/system script add comment=mikhmon dont-require-permissions=no name=jul/31/2026-|-20:21:27-|-6gn47-|-2500-|-192.168.44.247-|-34:8B:75:4E:45:89-|-6h-|-Paket6jam-|-vc-852-06.24.26- owner=jul2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=jul/31/2026
/system script add comment=mikhmon dont-require-permissions=no name=jul/31/2026-|-21:06:44-|-2ip88-|-1500-|-192.168.44.212-|-0C:98:38:FA:92:95-|-12h-|-Paket2jam-|-vc-116-06.24.26- owner=jul2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=jul/31/2026
/system script add comment=mikhmon dont-require-permissions=no name=jul/31/2026-|-21:12:12-|-6gu35-|-2500-|-192.168.44.219-|-8E:AA:71:EF:F1:04-|-6h-|-Paket6jam-|-vc-852-06.24.26- owner=jul2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=jul/31/2026
/system script add comment=mikhmon dont-require-permissions=no name=jul/31/2026-|-21:59:18-|-6jh26-|-2500-|-192.168.44.220-|-0A:8F:45:F3:C6:96-|-6h-|-Paket6jam-|-vc-852-06.24.26- owner=jul2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=jul/31/2026
/system script add comment=mikhmon dont-require-permissions=no name=aug/01/2026-|-06:05:07-|-6khiw-|-2500-|-192.168.44.20-|-5E:38:CD:06:4A:61-|-6h-|-Paket6jam-|-vc-954-01.09.26- owner=aug2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=aug/01/2026
/system script add comment=mikhmon dont-require-permissions=no name=aug/01/2026-|-06:37:18-|-6je59-|-2500-|-192.168.44.64-|-96:F9:8C:E3:73:52-|-6h-|-Paket6jam-|-vc-852-06.24.26- owner=aug2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=aug/01/2026
/system script add comment=mikhmon dont-require-permissions=no name=aug/01/2026-|-06:55:18-|-2xi22-|-1500-|-192.168.44.183-|-0C:98:38:FA:92:95-|-12h-|-Paket2jam-|-vc-116-06.24.26- owner=aug2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=aug/01/2026
/system script add comment=mikhmon dont-require-permissions=no name=aug/01/2026-|-08:06:18-|-2hy36-|-1500-|-192.168.44.134-|-30:CB:F8:EE:AC:CB-|-12h-|-Paket2jam-|-vc-116-06.24.26- owner=aug2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=aug/01/2026
/system script add comment=mikhmon dont-require-permissions=no name=aug/01/2026-|-09:48:42-|-6xczs-|-2500-|-192.168.44.200-|-82:2D:63:99:53:2A-|-6h-|-Paket6jam-|-vc-954-01.09.26- owner=aug2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=aug/01/2026
/system script add comment=mikhmon dont-require-permissions=no name=aug/01/2026-|-11:32:11-|-6gy44-|-2500-|-192.168.44.224-|-92:E9:D4:B1:EE:ED-|-6h-|-Paket6jam-|-vc-852-06.24.26- owner=aug2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=aug/01/2026
/system script add comment=mikhmon dont-require-permissions=no name=aug/01/2026-|-11:59:06-|-2th64-|-1500-|-10.10.10.239-|-30:CB:F8:EE:AC:CB-|-12h-|-Paket2jam-|-vc-116-06.24.26- owner=aug2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=aug/01/2026
/system script add comment=mikhmon dont-require-permissions=no name=aug/01/2026-|-18:05:42-|-6df98-|-2500-|-192.168.44.253-|-6A:75:1C:60:9E:09-|-6h-|-Paket6jam-|-vc-852-06.24.26- owner=aug2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=aug/01/2026
/system script add comment=mikhmon dont-require-permissions=no name=aug/01/2026-|-18:25:24-|-6mj43-|-2500-|-192.168.44.173-|-8E:AA:71:EF:F1:04-|-6h-|-Paket6jam-|-vc-852-06.24.26- owner=aug2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=aug/01/2026
/system script add comment=mikhmon dont-require-permissions=no name=aug/01/2026-|-19:43:16-|-6ae96-|-2500-|-192.168.44.215-|-96:F9:8C:E3:73:52-|-6h-|-Paket6jam-|-vc-852-06.24.26- owner=aug2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=aug/01/2026
/system script add comment=mikhmon dont-require-permissions=no name=aug/01/2026-|-19:55:27-|-2gz69-|-1500-|-192.168.44.198-|-34:8B:75:4E:45:89-|-12h-|-Paket2jam-|-vc-116-06.24.26- owner=aug2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=aug/01/2026
/system script add comment=mikhmon dont-require-permissions=no name=aug/02/2026-|-06:40:01-|-2cm43-|-1500-|-192.168.44.173-|-8E:AA:71:EF:F1:04-|-12h-|-Paket2jam-|-vc-116-06.24.26- owner=aug2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=aug/02/2026
/system script add comment=mikhmon dont-require-permissions=no name=aug/02/2026-|-07:50:46-|-6fu76-|-2500-|-192.168.44.202-|-96:F9:8C:E3:73:52-|-6h-|-Paket6jam-|-vc-852-06.24.26- owner=aug2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=aug/02/2026
/system script add comment=mikhmon dont-require-permissions=no name=aug/02/2026-|-08:50:59-|-6ip56-|-2500-|-192.168.44.173-|-8E:AA:71:EF:F1:04-|-6h-|-Paket6jam-|-vc-852-06.24.26- owner=aug2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=aug/02/2026
/system script add comment=mikhmon dont-require-permissions=no name=aug/02/2026-|-10:59:09-|-2vi42-|-1500-|-192.168.44.92-|-30:CB:F8:EE:AC:CB-|-12h-|-Paket2jam-|-vc-116-06.24.26- owner=aug2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=aug/02/2026
/system script add comment=mikhmon dont-require-permissions=no name=aug/02/2026-|-11:25:09-|-2gf97-|-1500-|-192.168.44.203-|-62:20:74:66:29:5F-|-12h-|-Paket2jam-|-vc-116-06.24.26- owner=aug2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=aug/02/2026
/system script add comment=mikhmon dont-require-permissions=no name=aug/02/2026-|-11:47:31-|-6ut78-|-2500-|-192.168.44.198-|-DA:E6:36:B7:B2:BC-|-6h-|-Paket6jam-|-vc-852-06.24.26- owner=aug2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=aug/02/2026
/system script add comment=mikhmon dont-require-permissions=no name=aug/02/2026-|-13:22:41-|-2ir38-|-1500-|-10.10.10.254-|-04:C8:07:94:15:0E-|-12h-|-Paket2jam-|-vc-116-06.24.26- owner=aug2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=aug/02/2026
/system script add comment=mikhmon dont-require-permissions=no name=aug/02/2026-|-15:19:38-|-6vk99-|-2500-|-192.168.44.220-|-8E:AA:71:EF:F1:04-|-6h-|-Paket6jam-|-vc-852-06.24.26- owner=aug2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=aug/02/2026
/system script add comment=mikhmon dont-require-permissions=no name=aug/02/2026-|-18:28:05-|-2vw48-|-1500-|-192.168.44.90-|-B4:A5:AC:BA:8F:57-|-12h-|-Paket2jam-|-vc-116-06.24.26- owner=aug2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=aug/02/2026
/system script add comment=mikhmon dont-require-permissions=no name=aug/02/2026-|-19:46:08-|-6aw48-|-2500-|-192.168.44.230-|-96:F9:8C:E3:73:52-|-6h-|-Paket6jam-|-vc-852-06.24.26- owner=aug2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=aug/02/2026
/system script add comment=mikhmon dont-require-permissions=no name=aug/02/2026-|-20:19:18-|-6zj92-|-2500-|-192.168.44.209-|-6A:75:1C:60:9E:09-|-6h-|-Paket6jam-|-vc-852-06.24.26- owner=aug2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=aug/02/2026
/system script add comment=mikhmon dont-require-permissions=no name=aug/02/2026-|-21:20:15-|-6ji33-|-2500-|-192.168.44.244-|-8E:AA:71:EF:F1:04-|-6h-|-Paket6jam-|-vc-852-06.24.26- owner=aug2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=aug/02/2026
/system script add comment=mikhmon dont-require-permissions=no name=aug/03/2026-|-00:32:58-|-6kf86-|-2500-|-192.168.44.58-|-0A:8F:45:F3:C6:96-|-6h-|-Paket6jam-|-vc-852-06.24.26- owner=aug2026 policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=aug/03/2026
/tool netwatch add comment=tunnel-gateway-10.41.0.1 host=10.41.0.1
/tool netwatch add comment=tunnel-gateway-10.47.0.1 host=10.47.0.1
/tool netwatch add comment=tunnel-gateway-10.46.0.1 host=10.46.0.1
/tool netwatch add comment=tunnel-gateway-172.28.0.1 host=172.28.0.1
