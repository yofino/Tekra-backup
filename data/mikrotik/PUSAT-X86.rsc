# 2026-05-17 02:04:10 by RouterOS 7.11.3
# software id = NTU4-626A
#
# model = CCR2116-12G-4S+
# serial number = HFF099QH5K1
/interface bridge add name=BRIDGE-BACKBONE-CILISUNG
/interface bridge add name=BRIDGE-HOTSPOT
/interface bridge add name=BRIDGE-HOTSPOT-GX4
/interface bridge add name=BRIDGE-TR069
/interface ethernet set [ find default-name=sfp-sfpplus1 ] auto-negotiation=no name=SFP1-WAN-1
/interface ethernet set [ find default-name=sfp-sfpplus3 ] auto-negotiation=no name=SFP3-OLT-GPON speed=1Gbps
/interface ethernet set [ find default-name=sfp-sfpplus4 ] auto-negotiation=no name=SFP4-OLT-EPON speed=1Gbps
/interface ethernet set [ find default-name=ether1 ] name=ether1-SIMAYA
/interface ethernet set [ find default-name=ether2 ] name=ether2-SWITCH
/interface ethernet set [ find default-name=sfp-sfpplus2 ] auto-negotiation=no speed=1Gbps
/interface ovpn-client add comment=tunnel-31729 connect-to=id-24.tunnel.web.id mac-address=FE:0A:B1:5E:4B:23 name=tunnel-31729 user=pusat-ccr2
/interface l2tp-client add connect-to=103.226.138.15 name=l2tp-out2 user=koko
/interface vlan add interface=sfp-sfpplus2 name=VLAN-FROM-CILISUNG vlan-id=203
/interface vlan add interface=sfp-sfpplus2 name=VLAN-TO-CILISUNG vlan-id=202
/interface vlan add interface=SFP4-OLT-EPON name=VLAN-TR069-EPON vlan-id=100
/interface vlan add interface=SFP3-OLT-GPON name=VLAN-TR069-GPON vlan-id=100
/interface vlan add interface=SFP4-OLT-EPON name="vlan1-HOTSPOT CCR-EPON" vlan-id=103
/interface vlan add interface=SFP4-OLT-EPON name="vlan2-HOTSPOT GX4" vlan-id=101
/interface vlan add interface=SFP4-OLT-EPON name="vlan3-PPPOE-BOJONG SEUREUH" vlan-id=102
/interface vlan add interface=SFP4-OLT-EPON name="vlan4-PPPOE BOJONG SUREN" vlan-id=104
/interface vlan add interface=SFP4-OLT-EPON name="vlan5-PPPOE-BOJONG SUREN GIRANG" vlan-id=105
/interface vlan add interface=SFP3-OLT-GPON name=vlan6-HOTSPOT-GPON vlan-id=106
/interface vlan add interface=SFP4-OLT-EPON name="vlan7-PPPOE SUKALUYU" vlan-id=107
/interface vlan add interface=SFP4-OLT-EPON name="vlan8-PPPOE CIBURUY" vlan-id=108
/interface vlan add interface=SFP3-OLT-GPON name=vlan9-PPPOE-GPON vlan-id=109
/interface vlan add interface=SFP3-OLT-GPON name=vlan10-HOTSPOT-GX4 vlan-id=112
/interface vlan add interface=SFP3-OLT-GPON name=vlan11 vlan-id=1001
/interface wireless security-profiles set [ find default=yes ] supplicant-identity=MikroTik
/ip dhcp-server option add code=43 name=acs value=0x0119687474703A2F2F31302E31302E31302E3233303A37353437
/ip dhcp-server option sets add name=acs options=acs
/ip hotspot profile add dns-name=tekra.hotspot hotspot-address=10.10.10.1 html-directory=ne login-by=http-chap,http-pap,mac-cookie name=hsprof1
/ip hotspot profile add dns-name=tekra2.hotspot hotspot-address=172.90.10.1 html-directory=ne login-by=http-chap,http-pap,mac-cookie name=hsprof2
/ip hotspot user profile add name=kontrakan rate-limit=4M/4M shared-users=2
/ip hotspot user profile add name="1 BULAN 1 ORANG" rate-limit=2M/2M
/ip pool add name=paket1 ranges=10.1.0.5-10.1.7.254
/ip pool add name=paket2 ranges=10.2.0.5-10.2.7.254
/ip pool add name=paket3 ranges=10.10.13.5-10.10.13.254
/ip pool add name=paket4 ranges=10.10.14.5-10.10.14.254
/ip pool add name=paket5 ranges=10.10.15.5-10.10.15.254
/ip pool add name=hs-pool-14 ranges=172.90.10.150-172.90.10.254
/ip pool add name=pool1 ranges=192.168.44.100-192.168.44.240
/ip pool add name=dhcp_pool8 ranges=10.100.0.2-10.100.7.254
/ip pool add name=Hotspot next-pool=pool1 ranges=10.10.10.231-10.10.10.254
/ip pool add name=dhcp_pool9 ranges=10.100.0.2-10.100.7.254
/ip pool add name=ISOLIR ranges=10.10.16.5-10.10.16.254
/ip pool add name="paket 1 burst" ranges=10.3.0.5-10.3.7.254
/ip pool add name="paket 2 burst" ranges=10.10.16.5-10.10.16.254
/ip pool add name="paket 3 burst" ranges=10.10.17.5-10.10.17.254
/ip pool add name="paket 4 burst" ranges=10.10.18.5-10.10.18.254
/ip pool add name="paket 5 burst" ranges=10.10.19.5-10.10.19.254
/ip pool add name=dhcp_pool16 ranges=192.168.78.2-192.168.78.254
/ip dhcp-server add address-pool=Hotspot interface=BRIDGE-HOTSPOT name=dhcp1
/ip dhcp-server add address-pool=dhcp_pool9 dhcp-option-set=acs interface=BRIDGE-TR069 name=TR069
/ip dhcp-server
# DHCP server can not run on slave interface!
add address-pool=hs-pool-14 interface="vlan2-HOTSPOT GX4" name=dhcp3
/ip dhcp-server add address-pool=dhcp_pool16 interface=ether5 name=dhcp2
/ip hotspot add address-pool=Hotspot addresses-per-mac=unlimited disabled=no interface=BRIDGE-HOTSPOT name=hotspot1 profile=hsprof1
/ip hotspot add address-pool=hs-pool-14 addresses-per-mac=unlimited disabled=no interface=BRIDGE-HOTSPOT-GX4 name="hs-vlan2-HOTSPOT GX4" profile=hsprof2
/port set 0 name=serial0
/ppp profile add address-list=ISOLIR-LIST local-address=10.10.16.1 name=EXPIRED remote-address=ISOLIR
/queue simple add name=PAKET-1 target=10.1.0.0/21
/queue simple add name=PAKET-2 target=10.2.0.0/21
/queue simple add name=PAKET-1-BURST target=10.3.0.0/21
/queue simple add name=PAKET-2-BURST target=10.10.16.0/24
/queue simple add name=PAKET-3-BURST target=10.10.17.0/24
/queue simple add name=PAKET-4-BURST target=10.10.18.0/24
/queue simple add name=PAKET-5-BURST target=10.10.19.0/24
/queue simple add name=PAKET-3 target=10.10.13.0/24
/queue simple add name=PAKET-4 target=10.10.14.0/24
/queue simple add name=PAKET-5 target=10.10.15.0/24
/queue simple add comment="BOJONG SUREN" max-limit=8M/8M name=SANJAYA target=10.10.10.58/32
/queue simple add comment=RADIO max-limit=13M/13M name="NENG RESTI" target=192.168.44.23/32
/queue simple add comment=RADIO max-limit=10M/10M name="AMIN SURATMIN" target=10.10.10.162/32
/queue simple add comment=RADIO max-limit=15M/15M name="ADANG CIGURIANG" target=10.10.10.158/32
/queue simple add comment=RADIO max-limit=20M/20M name="RESI KOMPLEK" target=10.10.10.175/32
/queue simple add comment="BOJONG SUREN" max-limit=13M/13M name="EDI JAELANI STATIC" target=172.90.10.65/32
/queue simple add comment=RADIO max-limit=13M/13M name="AI SAFTINAH" target=10.10.10.212/32
/queue simple add comment=RADIO max-limit=8M/8M name=NURTITA target=10.10.10.214/32
/queue simple add comment=RADIO max-limit=13M/13M name="BAGAS CIJERAH" target=10.10.10.210/32
/queue simple add comment=BJS max-limit=5M/5M name="ABAH ACEP" target=172.90.10.22/32
/queue simple add comment="BOJONG SUREN" max-limit=13M/13M name="TEH ENDAH ARIF" target=192.168.44.24/32
/queue simple add comment=RADIO max-limit=8M/8M name="RIMA CIGURIANG" target=192.168.44.26/32
/queue type add kind=fq-codel name=FQ-CODEL
/ppp profile add local-address=10.1.0.1 name=PAKET1 only-one=yes parent-queue=PAKET-1 queue-type=FQ-CODEL rate-limit="10M/10M 0/0 0/0 0/0 8 10M/10M" remote-address=paket1
/ppp profile add local-address=10.2.0.1 name=PAKET2 only-one=yes parent-queue=PAKET-2 queue-type=FQ-CODEL rate-limit="16M/16M 0/0 0/0 0/0 8 16M/16M" remote-address=paket2
/ppp profile add local-address=10.10.13.1 name=PAKET3 only-one=yes parent-queue=PAKET-3 queue-type=FQ-CODEL rate-limit="20M/20M 0/0 0/0 0/0 8 20M/20M" remote-address=paket3
/ppp profile add local-address=10.10.14.1 name=PAKET4 only-one=yes parent-queue=PAKET-4 queue-type=FQ-CODEL rate-limit="25M/25M 0/0 0/0 0/0 8 25M/25M" remote-address=paket4
/ppp profile add local-address=10.10.15.1 name=PAKET5 only-one=yes parent-queue=PAKET-5 queue-type=FQ-CODEL rate-limit="30M/30M 0/0 0/0 0/0 8 30M/30M" remote-address=paket5
/ppp profile add local-address=10.2.0.1 name="PAKET HEMAT" only-one=yes parent-queue=PAKET-2 queue-type=FQ-CODEL rate-limit="10M/10M 0/0 0/0 0/0 8 10M/10M" remote-address=paket2
/ppp profile add local-address=10.10.13.1 name="PAKET MANTAP" only-one=yes parent-queue=PAKET-3 queue-type=FQ-CODEL rate-limit="20M/20M 0/0 0/0 0/0 8 20M/20M" remote-address=paket3
/ppp profile add local-address=10.10.15.1 name="PAKET PUAS" only-one=yes parent-queue=PAKET-5 queue-type=FQ-CODEL rate-limit="30M/30M 0/0 0/0 0/0 8 30M/30M" remote-address=paket5
/ppp profile add local-address=10.10.15.1 name=TEST only-one=yes parent-queue=PAKET-5 queue-type=FQ-CODEL rate-limit="100M/100M 0/0 0/0 0/0 8 100M/100M" remote-address=paket5
/ppp profile add local-address=10.3.0.1 name="PAKET HEMAT BURST" only-one=yes parent-queue=PAKET-1-BURST queue-type=FQ-CODEL rate-limit="5M/5M 10M/10M 40960k/40960k 40960k/40960k 60s 8" remote-address="paket 1 burst"
/ppp profile add local-address=10.10.16.1 name="PAKET MANTAP BURST" only-one=yes parent-queue=PAKET-2-BURST queue-type=FQ-CODEL rate-limit="10M/10M 20M/20M 81920k/81920k 81920k/81920k 60s 8" remote-address="paket 2 burst"
/ppp profile add local-address=10.10.17.1 name="PAKET PUAS BURST" only-one=yes parent-queue=PAKET-3-BURST queue-type=FQ-CODEL rate-limit="15M/15M 30M/30M 122880k/122880k 122880k/122880k 60s 8" remote-address="paket 3 burst"
/ppp profile add local-address=10.10.15.1 name="PAKET TURBO" only-one=yes parent-queue=PAKET-5 queue-type=FQ-CODEL rate-limit="50M/50M 0/0 0/0 0/0 8 50M/50M" remote-address=paket5
/routing table add disabled=no fib name=PFSENSE
/routing table add disabled=no fib name=SIMAYA
/routing table add disabled=no fib name=SPEEDTEST
/routing table add disabled=no fib name=vpn
/interface bridge port add bridge=BRIDGE-HOTSPOT interface=ether2-SWITCH
/interface bridge port add bridge=BRIDGE-HOTSPOT interface="vlan1-HOTSPOT CCR-EPON"
/interface bridge port add bridge=BRIDGE-TR069 interface=VLAN-TR069-EPON
/interface bridge port add bridge=BRIDGE-TR069 interface=VLAN-TR069-GPON
/interface bridge port add bridge=BRIDGE-HOTSPOT interface=vlan6-HOTSPOT-GPON
/interface bridge port add bridge=BRIDGE-HOTSPOT-GX4 interface=vlan10-HOTSPOT-GX4
/interface bridge port add bridge=BRIDGE-HOTSPOT-GX4 interface=ether7
/interface bridge port add bridge=BRIDGE-TR069 interface=vlan11
/interface bridge port add bridge=BRIDGE-HOTSPOT-GX4 interface="vlan2-HOTSPOT GX4"
/interface bridge port add bridge=BRIDGE-HOTSPOT-GX4 interface=VLAN-TO-CILISUNG
/interface bridge port add bridge=BRIDGE-BACKBONE-CILISUNG interface=ether12
/interface bridge port add bridge=BRIDGE-BACKBONE-CILISUNG interface=sfp-sfpplus2
/interface bridge port add bridge=BRIDGE-BACKBONE-CILISUNG interface=ether11
/ip neighbor discovery-settings set discover-interface-list=!dynamic
/interface pppoe-server server add disabled=no interface=BRIDGE-HOTSPOT service-name=service1
/interface pppoe-server server add disabled=no interface="vlan3-PPPOE-BOJONG SEUREUH" service-name=service2
/interface pppoe-server server add disabled=no interface="vlan4-PPPOE BOJONG SUREN" service-name=service3
/interface pppoe-server server add disabled=no interface="vlan5-PPPOE-BOJONG SUREN GIRANG" service-name=service4
/interface pppoe-server server add disabled=no interface="vlan7-PPPOE SUKALUYU" service-name=service6
/interface pppoe-server server add disabled=no interface="vlan8-PPPOE CIBURUY" service-name=service7
/interface pppoe-server server add disabled=no interface=vlan9-PPPOE-GPON service-name=service8
/ip address add address=10.10.10.1/24 interface=BRIDGE-HOTSPOT network=10.10.10.0
/ip address add address=10.100.0.1/21 interface=BRIDGE-TR069 network=10.100.0.0
/ip address add address=192.168.44.1/24 interface=BRIDGE-HOTSPOT network=192.168.44.0
/ip address add address=172.90.10.1/24 interface=BRIDGE-HOTSPOT-GX4 network=172.90.10.0
/ip address add address=192.168.123.90/24 interface=SFP1-WAN-1 network=192.168.123.0
/ip address add address=172.80.10.100/24 interface=ether1-SIMAYA network=172.80.10.0
/ip address add address=192.168.100.25/24 interface=ether10 network=192.168.100.0
/ip dhcp-server network add address=10.10.10.0/24 comment="hotspot network" gateway=10.10.10.1
/ip dhcp-server network add address=10.100.0.0/21 dhcp-option=acs gateway=10.100.0.1
/ip dhcp-server network add address=172.90.10.0/24 comment="hotspot network" gateway=172.90.10.1
/ip dhcp-server network add address=192.168.78.0/24 gateway=192.168.78.1
/ip dns set allow-remote-requests=yes cache-size=8192KiB servers=8.8.8.8,8.8.4.4
/ip dns static add address=10.10.10.230 name=acs.id.myrepublic.net
/ip dns static add address=10.10.10.230 name=acs
/ip dns static add address=10.10.10.230 name=xlacs.xl.co.id
/ip dns static add address=10.10.10.230 name=acs.telkom.net
/ip dns static add address=10.10.10.230 name=acs.net
/ip dns static add address=10.10.10.230 name=acs-new.telkom.net
/ip dns static add address=10.10.10.230 name=devacs.edatahome.com
/ip dns static add address=10.10.10.230 name=RMS.chinamobile.com
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
/ip firewall address-list add address=172.90.10.0/24 list=private-lokal
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
/ip firewall address-list add address=10.10.10.0/24 list=private-lokal
/ip firewall address-list add address=192.168.44.73 list="JALUR PFSENSE"
/ip firewall address-list add address=172.90.10.65 list=PBR
/ip firewall address-list add address=172.18.10.0/24 list=private-lokal
/ip firewall address-list add address=www.fast.com list=speedtest
/ip firewall address-list add address=speed.is comment=whatismyip.net list=speedtest
/ip firewall address-list add address=bgp.he.net list=speedtest
/ip firewall filter add action=accept chain=input dst-port=3388 protocol=tcp
/ip firewall filter add action=passthrough chain=unused-hs-chain comment="place hotspot rules here" disabled=yes
/ip firewall filter add action=drop chain=forward comment="BLOCK ISOLIR" src-address-list=ISOLIR-LIST
/ip firewall mangle add action=mark-routing chain=prerouting dst-address-list=speedtest new-routing-mark=SPEEDTEST passthrough=no src-address-list=private-lokal
/ip firewall mangle add action=mark-routing chain=prerouting disabled=yes new-routing-mark=SPEEDTEST passthrough=no src-address=10.10.10.205
/ip firewall mangle add action=mark-routing chain=prerouting disabled=yes new-routing-mark=SPEEDTEST passthrough=no src-address=10.10.13.178
/ip firewall mangle add action=mark-routing chain=prerouting disabled=yes new-routing-mark=SPEEDTEST passthrough=no src-address=10.1.0.2
/ip firewall mangle add action=mark-routing chain=prerouting disabled=yes new-routing-mark=SPEEDTEST passthrough=no src-address=10.10.13.245
/ip firewall nat add action=redirect chain=dstnat comment=ACS-NAT dst-port=53,5353 in-interface=BRIDGE-TR069 protocol=udp to-ports=53
/ip firewall nat add action=dst-nat chain=dstnat comment=ACS-NAT dst-address=!10.10.10.230 in-interface=BRIDGE-TR069 protocol=tcp to-addresses=10.10.10.230 to-ports=7547
/ip firewall nat add action=dst-nat chain=dstnat comment=ACS-NAT dst-port=!7547 in-interface=BRIDGE-TR069 protocol=tcp to-addresses=10.10.10.230 to-ports=7547
/ip firewall nat add action=redirect chain=dstnat comment=ISOLIR dst-port=80,443 protocol=tcp src-address-list=ISOLIR-LIST to-ports=8080
/ip firewall nat add action=passthrough chain=unused-hs-chain comment="place hotspot rules here" disabled=yes
/ip firewall nat add action=masquerade chain=srcnat out-interface=SFP1-WAN-1
/ip firewall nat add action=masquerade chain=srcnat out-interface=ether9
/ip firewall nat add action=masquerade chain=srcnat out-interface=ether1-SIMAYA
/ip firewall nat
# no interface
add action=masquerade chain=srcnat out-interface=*21
/ip firewall nat add action=masquerade chain=srcnat comment="masquerade hotspot network" src-address=10.10.10.0/24
/ip firewall nat add action=masquerade chain=srcnat comment="masquerade hotspot network" src-address=172.90.10.0/24
/ip firewall nat add action=dst-nat chain=dstnat dst-port=8822 in-interface=ether1-SIMAYA protocol=tcp to-addresses=172.90.10.1 to-ports=8291
/ip firewall nat add action=dst-nat chain=dstnat dst-port=8844 in-interface=ether1-SIMAYA protocol=tcp to-addresses=10.10.10.5 to-ports=554
/ip firewall nat add action=dst-nat chain=dstnat dst-port=3388 in-interface=ether1-SIMAYA protocol=tcp to-addresses=10.10.10.205 to-ports=3389
/ip firewall nat add action=dst-nat chain=dstnat dst-port=1822 in-interface=ether1-SIMAYA protocol=tcp to-addresses=172.90.10.1 to-ports=8728
/ip firewall nat add action=dst-nat chain=dstnat dst-port=1057 in-interface=ether1-SIMAYA protocol=tcp to-addresses=10.10.10.15 to-ports=34567
/ip firewall nat add action=dst-nat chain=dstnat dst-port=8622 in-interface=ether1-SIMAYA protocol=tcp to-addresses=10.10.10.10 to-ports=37777
/ip firewall nat add action=dst-nat chain=dstnat comment=tunnel-nat-172.26.1.37-3389 dst-address=172.26.1.37 dst-port=3389 protocol=tcp to-addresses=10.10.10.205 to-ports=3389
/ip firewall nat add action=dst-nat chain=dstnat comment=tunnel-nat-172.26.1.37-3000 dst-address=172.26.1.37 dst-port=3000 protocol=tcp to-addresses=10.10.10.22 to-ports=3000
/ip hotspot ip-binding add address=172.90.10.10 comment=CILISUNG to-address=172.90.10.10 type=bypassed
/ip hotspot ip-binding add address=172.90.10.11 comment="CILISUNG GX4" to-address=172.90.10.11 type=bypassed
/ip hotspot ip-binding add address=172.90.10.12 comment="CILISUNG OLT" to-address=172.90.10.12 type=bypassed
/ip hotspot ip-binding add address=172.90.10.13 comment="OLT SERVER" to-address=172.90.10.13 type=bypassed
/ip hotspot ip-binding add address=172.90.10.14 comment="OLT SERVER GPON" to-address=172.90.10.14 type=bypassed
/ip hotspot ip-binding add address=172.90.10.15 comment=TESTING to-address=172.90.10.15 type=bypassed
/ip hotspot ip-binding add address=172.90.10.22 to-address=172.90.10.22 type=bypassed
/ip hotspot ip-binding add address=172.90.10.27 to-address=172.90.10.27 type=bypassed
/ip hotspot ip-binding add address=10.10.10.60 to-address=10.10.10.60 type=bypassed
/ip hotspot ip-binding add address=10.10.10.10 comment=NVR to-address=10.10.10.10 type=bypassed
/ip hotspot ip-binding add address=10.10.10.5 comment="SWITCH USW" to-address=10.10.10.5 type=bypassed
/ip hotspot ip-binding add address=10.10.10.4 comment=Laptop to-address=10.10.10.4 type=bypassed
/ip hotspot ip-binding add address=10.10.10.3 comment="Station ciguriang dyan" to-address=10.10.10.3 type=bypassed
/ip hotspot ip-binding add address=10.10.10.2 comment="AP UBIQUITI UTARA resti" to-address=10.10.10.2 type=bypassed
/ip hotspot ip-binding add address=10.10.10.6 comment="AP UBIQUITI KULON" to-address=10.10.10.6 type=bypassed
/ip hotspot ip-binding add address=10.10.10.7 comment="Station budi ciguriang" to-address=10.10.10.7 type=bypassed
/ip hotspot ip-binding add address=10.10.10.9 comment="AP Mikrotik" to-address=10.10.10.9 type=bypassed
/ip hotspot ip-binding add address=10.10.10.8 comment="Station carik" to-address=10.10.10.8 type=bypassed
/ip hotspot ip-binding add address=10.10.10.11 comment="kamera ip" to-address=10.10.10.11 type=bypassed
/ip hotspot ip-binding add address=10.10.10.12 comment="kamera ip" to-address=10.10.10.12 type=bypassed
/ip hotspot ip-binding add address=10.10.10.13 comment="station fera carik" to-address=10.10.10.13 type=bypassed
/ip hotspot ip-binding add address=10.10.10.14 comment="CCTV MASJID" to-address=10.10.10.14 type=bypassed
/ip hotspot ip-binding add address=10.10.10.16 to-address=10.10.10.16 type=bypassed
/ip hotspot ip-binding add address=10.10.10.15 to-address=10.10.10.15 type=bypassed
/ip hotspot ip-binding add address=10.10.10.18 comment="windows server" to-address=10.10.10.18 type=bypassed
/ip hotspot ip-binding add address=10.10.10.21 comment="windows server" to-address=10.10.10.21 type=bypassed
/ip hotspot ip-binding add address=10.10.10.22 comment="windows server" to-address=10.10.10.22 type=bypassed
/ip hotspot ip-binding add address=10.10.10.23 comment="cctv kamera bojong suren" to-address=10.10.10.23 type=bypassed
/ip hotspot ip-binding add address=10.10.10.24 comment="cctv kamera pa elan" to-address=10.10.10.24 type=bypassed
/ip hotspot ip-binding add address=10.10.10.25 comment="cctv kamera pa abin" to-address=10.10.10.25 type=bypassed
/ip hotspot ip-binding add address=10.10.10.26 comment="cctv kamera pa elan" to-address=10.10.10.26 type=bypassed
/ip hotspot ip-binding add address=10.10.10.27 comment="cctv kamera pa elan" to-address=10.10.10.27 type=bypassed
/ip hotspot ip-binding add address=10.10.10.28 comment="cctv kamera desa" to-address=10.10.10.28 type=bypassed
/ip hotspot ip-binding add address=10.10.10.29 comment="cctv sekeandur" to-address=10.10.10.29 type=bypassed
/ip hotspot ip-binding add address=10.10.10.30 comment="cctv kamera desa" to-address=10.10.10.30 type=bypassed
/ip hotspot ip-binding add address=10.10.10.36 to-address=10.10.10.36 type=bypassed
/ip hotspot ip-binding add address=10.10.10.58 to-address=10.10.10.58 type=bypassed
/ip hotspot ip-binding add address=10.10.10.66 to-address=10.10.10.66 type=bypassed
/ip hotspot ip-binding add address=10.10.10.68 to-address=10.10.10.68 type=bypassed
/ip hotspot ip-binding add address=10.10.10.75 to-address=10.10.10.75 type=bypassed
/ip hotspot ip-binding add address=10.10.10.79 to-address=10.10.10.79 type=bypassed
/ip hotspot ip-binding add disabled=yes mac-address=DC:F5:05:22:0E:87 type=blocked
/ip hotspot ip-binding add disabled=yes mac-address=9C:52:F8:38:24:F3 type=blocked
/ip hotspot ip-binding add disabled=yes mac-address=44:55:B1:AB:3E:B6 type=blocked
/ip hotspot ip-binding add disabled=yes mac-address=5C:92:5E:71:7D:E1 type=blocked
/ip hotspot ip-binding add address=10.10.10.123 to-address=10.10.10.123 type=bypassed
/ip hotspot ip-binding add comment="SI RENI" mac-address=04:F1:28:3A:A4:AB type=blocked
/ip hotspot ip-binding add disabled=yes mac-address=4A:B5:1C:2A:18:1A type=blocked
/ip hotspot ip-binding add disabled=yes mac-address=04:88:5F:FD:43:91 type=blocked
/ip hotspot ip-binding add disabled=yes mac-address=68:BF:C4:AE:49:56 type=bypassed
/ip hotspot ip-binding add address=10.10.10.144 to-address=10.10.10.144 type=bypassed
/ip hotspot ip-binding add address=10.10.10.151 to-address=10.10.10.151 type=bypassed
/ip hotspot ip-binding add address=10.10.10.158 to-address=10.10.10.158 type=bypassed
/ip hotspot ip-binding add address=10.10.10.162 to-address=10.10.10.162 type=bypassed
/ip hotspot ip-binding add address=10.5.50.40 to-address=10.5.50.40 type=bypassed
/ip hotspot ip-binding add address=10.10.10.165 to-address=10.10.10.165 type=bypassed
/ip hotspot ip-binding add address=10.10.10.167 to-address=10.10.10.167 type=bypassed
/ip hotspot ip-binding add address=10.10.10.168 to-address=10.10.10.168 type=bypassed
/ip hotspot ip-binding add disabled=yes mac-address=28:83:35:83:98:24 type=blocked
/ip hotspot ip-binding add address=10.10.10.171 to-address=10.10.10.171 type=bypassed
/ip hotspot ip-binding add address=10.10.10.172 to-address=10.10.10.172 type=bypassed
/ip hotspot ip-binding add address=10.10.10.173 to-address=10.10.10.173 type=bypassed
/ip hotspot ip-binding add address=10.10.10.174 to-address=10.10.10.174 type=bypassed
/ip hotspot ip-binding add address=10.10.10.175 to-address=10.10.10.175 type=bypassed
/ip hotspot ip-binding add address=10.10.10.176 to-address=10.10.10.176 type=bypassed
/ip hotspot ip-binding add comment=dapit disabled=yes mac-address=36:59:E4:71:28:4D type=blocked
/ip hotspot ip-binding add address=10.10.10.185 to-address=10.10.10.185 type=bypassed
/ip hotspot ip-binding add disabled=yes mac-address=5C:92:5E:71:55:D9 type=blocked
/ip hotspot ip-binding add address=10.10.10.197 to-address=10.10.10.197 type=bypassed
/ip hotspot ip-binding add address=10.10.10.198 to-address=10.10.10.198 type=bypassed
/ip hotspot ip-binding add address=10.10.10.199 to-address=10.10.10.199 type=bypassed
/ip hotspot ip-binding add address=10.10.10.200 to-address=10.10.10.200 type=bypassed
/ip hotspot ip-binding add address=10.10.10.201 to-address=10.10.10.201 type=bypassed
/ip hotspot ip-binding add address=10.10.10.202 comment="RADIO PA ANTON" to-address=10.10.10.202 type=bypassed
/ip hotspot ip-binding add address=10.10.10.203 disabled=yes to-address=10.10.10.203 type=bypassed
/ip hotspot ip-binding add address=10.10.10.204 comment=OLT-GPON to-address=10.10.10.204 type=bypassed
/ip hotspot ip-binding add address=10.10.10.205 comment="MINI PC" to-address=10.10.10.205 type=bypassed
/ip hotspot ip-binding add disabled=yes mac-address=7C:D6:61:57:BD:57 type=blocked
/ip hotspot ip-binding add disabled=yes mac-address=72:AB:16:7D:6D:5E type=blocked
/ip hotspot ip-binding add address=192.168.44.23 comment=RESTI to-address=192.168.44.23 type=bypassed
/ip hotspot ip-binding add address=192.168.44.24 comment="TV ARIF" to-address=192.168.44.24 type=bypassed
/ip hotspot ip-binding add address=192.168.44.26 comment="ciguriang baru" to-address=192.168.44.26 type=bypassed
/ip hotspot ip-binding add address=192.168.44.69 comment=BACOT to-address=192.168.44.69 type=bypassed
/ip hotspot ip-binding add address=10.10.10.206 comment="cctv endang" to-address=10.10.10.206 type=bypassed
/ip hotspot ip-binding add address=10.10.10.207 comment="ACCESS CONTROL" to-address=10.10.10.207 type=bypassed
/ip hotspot ip-binding add address=10.10.10.208 comment="OLT CILISUNG" to-address=10.10.10.208 type=bypassed
/ip hotspot ip-binding add address=10.5.50.10 to-address=10.5.50.10 type=bypassed
/ip hotspot ip-binding add address=10.10.10.210 to-address=10.10.10.210 type=bypassed
/ip hotspot ip-binding add address=10.10.10.211 to-address=10.10.10.211 type=bypassed
/ip hotspot ip-binding add address=10.10.10.212 to-address=10.10.10.212 type=bypassed
/ip hotspot ip-binding add address=10.10.10.213 to-address=10.10.10.213 type=bypassed
/ip hotspot ip-binding add address=10.10.10.214 to-address=10.10.10.214 type=bypassed
/ip hotspot ip-binding add address=10.10.10.216 to-address=10.10.10.216 type=bypassed
/ip hotspot ip-binding add address=10.10.10.253 to-address=10.10.10.253 type=bypassed
/ip hotspot ip-binding add address=10.10.10.254 to-address=10.10.10.254 type=bypassed
/ip hotspot ip-binding add address=10.10.10.244 to-address=10.10.10.244 type=bypassed
/ip hotspot ip-binding add address=10.10.10.218 to-address=10.10.10.218 type=bypassed
/ip hotspot ip-binding add address=10.10.10.219 to-address=10.10.10.219 type=bypassed
/ip hotspot ip-binding add disabled=yes mac-address=DC:F5:05:22:0E:87 type=blocked
/ip hotspot ip-binding add disabled=yes mac-address=9C:52:F8:38:24:F3 type=blocked
/ip hotspot ip-binding add disabled=yes mac-address=44:55:B1:AB:3E:B6 type=blocked
/ip hotspot ip-binding add disabled=yes mac-address=5C:92:5E:71:7D:E1 type=blocked
/ip hotspot ip-binding add disabled=yes mac-address=4A:B5:1C:2A:18:1A type=blocked
/ip hotspot ip-binding add disabled=yes mac-address=04:88:5F:FD:43:91 type=blocked
/ip hotspot ip-binding add disabled=yes mac-address=68:BF:C4:AE:49:56 type=bypassed
/ip hotspot ip-binding add disabled=yes mac-address=28:83:35:83:98:24 type=blocked
/ip hotspot ip-binding add comment=dapit disabled=yes mac-address=36:59:E4:71:28:4D type=blocked
/ip hotspot ip-binding add disabled=yes mac-address=5C:92:5E:71:55:D9 type=blocked
/ip hotspot ip-binding add disabled=yes mac-address=7C:D6:61:57:BD:57 type=blocked
/ip hotspot ip-binding add disabled=yes mac-address=72:AB:16:7D:6D:5E type=blocked
/ip hotspot ip-binding add address=10.10.10.220 comment="LINUX GENIEACS" to-address=10.10.10.220 type=bypassed
/ip hotspot ip-binding add address=10.10.10.221 comment="LINUX GENIEACS" to-address=10.10.10.221 type=bypassed
/ip hotspot ip-binding add address=10.10.10.230 comment="LINUX GENIEACS" to-address=10.10.10.230 type=bypassed
/ip hotspot ip-binding add address=172.90.10.65 to-address=172.90.10.65 type=bypassed
/ip hotspot ip-binding add address=172.90.10.66 to-address=172.90.10.66 type=bypassed
/ip hotspot ip-binding add address=172.90.10.67 to-address=172.90.10.67 type=bypassed
/ip hotspot ip-binding add address=172.90.10.36 to-address=172.90.10.36 type=bypassed
/ip hotspot ip-binding add mac-address=5C:92:5E:6A:66:91 type=blocked
/ip hotspot ip-binding add mac-address=78:9A:18:5E:2F:FA type=blocked
/ip hotspot ip-binding add address=10.10.10.65 comment="SWITCH USW" to-address=10.10.10.65 type=bypassed
/ip hotspot ip-binding add address=10.10.10.249 mac-address=48:A9:8A:1C:D1:AA server=hotspot1 to-address=10.10.10.249 type=bypassed
/ip hotspot ip-binding add address=10.10.10.209 comment="OLT CILISUNG" to-address=10.10.10.209 type=bypassed
/ip hotspot user add name=admin
/ip hotspot user add name=UBUK profile=kontrakan
/ip hotspot user add name=ridwan profile=kontrakan
/ip hotspot user add name=qipin profile="1 BULAN 1 ORANG"
/ip hotspot user add name=nunung profile="1 BULAN 1 ORANG"
/ip hotspot user add name=wina profile="1 BULAN 1 ORANG"
/ip proxy set enabled=yes
/ip proxy access add action=deny comment=ISOLIR dst-address=!10.10.16.1 src-address=10.10.16.0/24
/ip proxy access add action=deny comment=ISOLIR dst-host=!https://portal.tekra.my.id src-address=10.10.16.0/24
/ip proxy access add action=deny comment=ISOLIR dst-host=!https://tripay.co.id src-address=10.10.16.0/24
/ip route add check-gateway=ping disabled=no dst-address=0.0.0.0/0 gateway=192.168.123.1 routing-table=main suppress-hw-offload=no
/ip route add disabled=no dst-address=10.10.10.4/32 gateway=172.80.10.1 routing-table=main suppress-hw-offload=no
/ip route add disabled=no distance=1 dst-address=10.10.10.18/32 gateway=172.80.10.1 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/ip route add disabled=no distance=1 dst-address=10.10.10.200/32 gateway=172.80.10.1 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/ip route add disabled=no distance=1 dst-address=10.10.10.230/32 gateway=172.80.10.1 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/ip route add disabled=no distance=1 dst-address=8.8.8.8/32 gateway=172.80.10.1 routing-table=main scope=10 suppress-hw-offload=no target-scope=10
/ip route add disabled=no distance=1 dst-address=8.8.4.4/32 gateway=192.168.123.1 pref-src="" routing-table=main scope=10 suppress-hw-offload=no target-scope=10
/ip route add check-gateway=ping comment=SPEEDTEST disabled=no distance=1 dst-address=0.0.0.0/0 gateway=8.8.8.8 pref-src="" routing-table=SPEEDTEST scope=30 suppress-hw-offload=no target-scope=11
/ip route add check-gateway=ping comment=SIMAYA disabled=no distance=1 dst-address=0.0.0.0/0 gateway=8.8.8.8 pref-src="" routing-table=SIMAYA scope=30 suppress-hw-offload=no target-scope=11
/ip route add check-gateway=ping comment=SPEEDTEST disabled=no distance=2 dst-address=0.0.0.0/0 gateway=8.8.4.4 pref-src="" routing-table=SPEEDTEST scope=30 suppress-hw-offload=no target-scope=11
/ip route add check-gateway=ping comment=SIMAYA disabled=no distance=2 dst-address=0.0.0.0/0 gateway=8.8.4.4 pref-src="" routing-table=SIMAYA scope=30 suppress-hw-offload=no target-scope=11
/ip route add disabled=yes distance=1 dst-address=10.1.2.2/32 gateway=10.10.10.205 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/ip route add disabled=no distance=1 dst-address=10.10.10.22/32 gateway=172.80.10.1 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/ip route add disabled=yes distance=1 dst-address=10.10.10.203/32 gateway=172.80.10.1 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/ip route add disabled=yes distance=1 dst-address=10.10.10.204/32 gateway=172.80.10.1 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/ip route add disabled=yes distance=1 dst-address=192.168.1.0/24 gateway=10.1.0.2 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/ip route add disabled=no distance=1 dst-address=10.10.10.15/32 gateway=172.80.10.1 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/ip route add disabled=no distance=1 dst-address=10.10.10.16/32 gateway=172.80.10.1 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/ip route add disabled=no distance=1 dst-address=192.168.101.10/32 gateway=172.80.10.1 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/ip route add disabled=no distance=1 dst-address=192.168.124.1/32 gateway=172.80.10.1 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/ip route add disabled=no distance=1 dst-address=192.168.101.10/32 gateway=172.80.10.1 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/ip route add disabled=no distance=1 dst-address=192.168.0.88/32 gateway=172.80.10.1 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/ip route add disabled=no distance=1 dst-address=10.10.10.29/32 gateway=172.80.10.1 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/ip route add disabled=no distance=1 dst-address=10.10.10.30/32 gateway=172.80.10.1 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/ip route add disabled=no distance=1 dst-address=10.10.10.31/32 gateway=172.80.10.1 pref-src="" routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/ip service set telnet disabled=yes
/ip service set ftp disabled=yes
/ip service set www disabled=yes
/ip service set ssh port=18
/ip service set api-ssl disabled=yes
/ppp secret add local-address=10.6.0.1 name=DAGO remote-address=10.6.0.2
/ppp secret add local-address=192.168.33.1 name=KEMBAR profile=PAKET4 remote-address=192.168.33.4 service=pppoe
/ppp secret add name=ABANG profile=PAKET2 service=pppoe
/ppp secret add local-address=192.168.33.1 name=GUSTI profile=PAKET3 remote-address=192.168.33.14 service=pppoe
/ppp secret add local-address=192.168.33.1 name=DENI profile=PAKET1 remote-address=192.168.33.81 service=pppoe
/ppp secret add local-address=192.168.33.1 name=SELAMET profile=PAKET3 remote-address=192.168.33.33 service=pppoe
/ppp secret add name=ALDY profile=PAKET1 service=pppoe
/ppp secret add name=ABAH profile=PAKET3 service=pppoe
/ppp secret add name=SERVER profile=PAKET4 service=pppoe
/ppp secret add name=IRPAN profile=PAKET2 service=pppoe
/ppp secret add name=ANDRI profile=PAKET2 service=pppoe
/ppp secret add name=220720164405-SULASTRI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=NINA profile=PAKET1 service=pppoe
/ppp secret add name=220801153539-DETI profile=PAKET1 service=pppoe
/ppp secret add name=MAMAN profile=PAKET2 service=pppoe
/ppp secret add name=SARAH profile=PAKET1 service=pppoe
/ppp secret add name=IPENK profile=PAKET2 service=pppoe
/ppp secret add name=NONO profile=PAKET1 service=pppoe
/ppp secret add name=SARI profile=PAKET1 service=pppoe
/ppp secret add name=210901203309-FERY profile=PAKET5 service=pppoe
/ppp secret add name=DIDIN profile=PAKET1 service=pppoe
/ppp secret add name=ELIN profile=PAKET2 service=pppoe
/ppp secret add name=221119172542-LENI profile=PAKET2 service=pppoe
/ppp secret add name=r1 profile=PAKET2 service=pppoe
/ppp secret add name=r2 profile=PAKET1 service=pppoe
/ppp secret add name=r4 profile=PAKET5 service=pppoe
/ppp secret add name=r5 profile=PAKET1 service=pppoe
/ppp secret add name=HENI profile=PAKET1 service=pppoe
/ppp secret add name=ANWAR profile=PAKET1 service=pppoe
/ppp secret add name=FERRY profile=PAKET4 service=pppoe
/ppp secret add name=230114074208-ADITYA profile=PAKET2 service=pppoe
/ppp secret add disabled=yes name=DINI profile=PAKET2 service=pppoe
/ppp secret add name=IKI profile=PAKET4 service=pppoe
/ppp secret add name=230114074223-TUTI profile=PAKET2 service=pppoe
/ppp secret add disabled=yes name=MAYANG profile=PAKET1 service=pppoe
/ppp secret add name=UBUK profile=PAKET1 service=pppoe
/ppp secret add name=FAHRUN profile=PAKET3 service=pppoe
/ppp secret add name=KALUA profile=PAKET1 service=pppoe
/ppp secret add name=DAYAT profile=PAKET1 service=pppoe
/ppp secret add name=DIANEKA profile=PAKET1 service=pppoe
/ppp secret add name=RIKA profile=PAKET1 service=pppoe
/ppp secret add name=ENDA profile=PAKET1 service=pppoe
/ppp secret add name=RIAN profile=PAKET1 service=pppoe
/ppp secret add name=HENDRA profile=PAKET1 service=pppoe
/ppp secret add name=CILISUNG profile=PAKET1 service=pppoe
/ppp secret add name=230909151059-IMAS profile=PAKET1 service=pppoe
/ppp secret add name=RIA profile=PAKET2 service=pppoe
/ppp secret add name=ADIBIL profile=PAKET1 service=pppoe
/ppp secret add name=IRFA profile=PAKET1 service=pppoe
/ppp secret add name=ADIB profile=PAKET2 service=pppoe
/ppp secret add name=KPPS profile=PAKET5 service=pppoe
/ppp secret add name=IQBAL profile=PAKET4 service=pppoe
/ppp secret add name=NENDI profile=PAKET1 service=pppoe
/ppp secret add name=210902132718-UJANG profile=PAKET2 service=pppoe
/ppp secret add name=210902125942-TEBE profile=PAKET2 service=pppoe
/ppp secret add name=210902135358-USIN profile=PAKET2 service=pppoe
/ppp secret add name=210902134829-IKI profile=PAKET1 service=pppoe
/ppp secret add name=230909151054-ANGGA profile=PAKET1 service=pppoe
/ppp secret add name=230909151056-SUWITO profile=PAKET1 service=pppoe
/ppp secret add name=230114074231-DIKDIK profile=PAKET1 service=pppoe
/ppp secret add name=230909151066-AEP profile=PAKET1 service=pppoe
/ppp secret add name=210902135654-DADI profile="PAKET MANTAP" service=pppoe
/ppp secret add name=230909151072-DINGGO profile=PAKET1 service=pppoe
/ppp secret add name=220322140756-INOY profile=PAKET1 service=pppoe
/ppp secret add name=230909151055-CACAH profile=PAKET1 service=pppoe
/ppp secret add name=230909151062-ASEP profile=PAKET2 service=pppoe
/ppp secret add name=230114074216-FITRIYANI profile=PAKET2 service=pppoe
/ppp secret add name=231008170936-YUNITA profile="PAKET HEMAT" service=pppoe
/ppp secret add name=230909151063-RANTI profile=PAKET1 service=pppoe
/ppp secret add name=210902134719-UCOK profile=PAKET1 service=pppoe
/ppp secret add name=230613081729-DWI profile=PAKET2 service=pppoe
/ppp secret add disabled=yes name=230613081731-SHINTA profile=PAKET1 service=pppoe
/ppp secret add name=231008170938-ADIB profile=PAKET2 service=pppoe
/ppp secret add name=230909151058-RIAN profile="PAKET HEMAT" service=pppoe
/ppp secret add name=210902135558-KOCREK profile=PAKET1 service=pppoe
/ppp secret add name=230906111356-RINA profile=PAKET1 service=pppoe
/ppp secret add name=210902124605-DEA profile=PAKET2 service=pppoe
/ppp secret add name=220315114250-EKA profile=PAKET4 service=pppoe
/ppp secret add name=230613081727-RINI profile=PAKET1 service=pppoe
/ppp secret add name=230613081728-YADI profile=PAKET1 service=pppoe
/ppp secret add name=210902135311-IYAH profile=PAKET2 service=pppoe
/ppp secret add name=220726185926-NENDEN profile=PAKET2 service=pppoe
/ppp secret add name=231008170940-YENI profile=PAKET2 service=pppoe
/ppp secret add name=231008170939-ROCHSI profile=PAKET5 service=pppoe
/ppp secret add name=230909151046-SUMPENA profile=PAKET2 service=pppoe
/ppp secret add name=220606150759-NIA profile=PAKET1 service=pppoe
/ppp secret add name=210902124058-MAYA profile=PAKET1 service=pppoe
/ppp secret add name=231008170932-YUDI profile=PAKET2 service=pppoe
/ppp secret add name=231009185223-RENDY profile=PAKET2 service=pppoe
/ppp secret add name=221011122722-TANTI profile=PAKET1 service=pppoe
/ppp secret add name=230114074226-NENDI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=210901203434-SANSAN profile=PAKET2 service=pppoe
/ppp secret add name=230114074209-DAINE profile=PAKET2 service=pppoe
/ppp secret add name=230909151057-DALIT profile=PAKET1 service=pppoe
/ppp secret add name=210901203608-ELIS profile=PAKET3 service=pppoe
/ppp secret add name=230909151069-ERIK profile=PAKET2 service=pppoe
/ppp secret add name=231008170935-RIA profile=PAKET3 service=pppoe
/ppp secret add disabled=yes name=230909151060-RENI profile=PAKET1 service=pppoe
/ppp secret add name=220818123605-ESA profile="PAKET HEMAT" service=pppoe
/ppp secret add name=231009185222-LINA profile=PAKET3 service=pppoe
/ppp secret add name=231008170942-MENTARI profile=PAKET3 service=pppoe
/ppp secret add name=230909151074-HERMAWAN profile=PAKET1 service=pppoe
/ppp secret add name=230909151075-AYI profile=PAKET1 service=pppoe
/ppp secret add disabled=yes name=220318142406-AHO profile=PAKET1 service=pppoe
/ppp secret add name=210902133706-CIKAL profile=PAKET2 service=pppoe
/ppp secret add name=230909151076-KOMARIAH profile=PAKET1 service=pppoe
/ppp secret add name=OGUT profile=PAKET1 service=pppoe
/ppp secret add disabled=yes name=230613081734-YADI profile=PAKET1 service=pppoe
/ppp secret add name=230909151077-RESTIWI profile=PAKET1 service=pppoe
/ppp secret add name=ARIF profile=PAKET2 service=pppoe
/ppp secret add name=SAEFUL profile=PAKET2 service=pppoe
/ppp secret add name=210902162958-HANIPAH profile=PAKET2 service=pppoe
/ppp secret add name=220307114152-TOM profile=PAKET3 service=pppoe
/ppp secret add name=210902170221-FROZEN profile=PAKET1 service=pppoe
/ppp secret add name=210902163107-IIP profile=PAKET1 service=pppoe
/ppp secret add name=210902164511-DUDE profile=PAKET2 service=pppoe
/ppp secret add name=210902165641-RIDWAN profile=PAKET3 service=pppoe
/ppp secret add name=240315141540-DENDI profile=PAKET2 service=pppoe
/ppp secret add name=221119172541-AHMAD profile=PAKET1 service=pppoe
/ppp secret add name=221119172547-WENDI profile=PAKET1 service=pppoe
/ppp secret add name=210902163224-AYU profile=PAKET2 service=pppoe
/ppp secret add name=231008170931-RIFKI profile=PAKET1 service=pppoe
/ppp secret add name=240315141542-ADE profile=PAKET1 service=pppoe
/ppp secret add disabled=yes name=220104200010-DESI profile=PAKET2 service=pppoe
/ppp secret add name=210902161926-IDA profile=PAKET1 service=pppoe
/ppp secret add name=210902170557-YANA profile=PAKET1 service=pppoe
/ppp secret add name=210902164603-DENI profile=PAKET2 service=pppoe
/ppp secret add name=210902161800-GUSTI profile=PAKET3 service=pppoe
/ppp secret add name=221228123326-AKUR profile=PAKET1 service=pppoe
/ppp secret add name=210901114107-DEDI profile=PAKET1 service=pppoe
/ppp secret add name=221228123324-IMAS profile=PAKET1 service=pppoe
/ppp secret add name=210902140131-ASEP profile=PAKET1 service=pppoe
/ppp secret add name=231008170943-VIQRI profile=PAKET1 service=pppoe
/ppp secret add name=230909151080-EBIH profile=PAKET1 service=pppoe
/ppp secret add name=210902162311-TONO profile="PAKET PUAS" service=pppoe
/ppp secret add name=220718133013-INDRA profile=PAKET2 service=pppoe
/ppp secret add name=210902133102-ANWAR profile=PAKET1 service=pppoe
/ppp secret add disabled=yes name=230311155641-DEBI profile=PAKET2 service=pppoe
/ppp secret add name=210901143902-FAHRUN profile=PAKET3 service=pppoe
/ppp secret add name=230114074225-FENI profile=PAKET1 service=pppoe
/ppp secret add name=230909151050-FIKRI profile=PAKET1 service=pppoe
/ppp secret add name=221119172544-HENI profile=PAKET1 service=pppoe
/ppp secret add name=221009174256-RUSTINI profile=PAKET4 service=pppoe
/ppp secret add name=230114074214-IROB profile=PAKET1 service=pppoe
/ppp secret add name=220512104255-IRPAN profile=PAKET2 service=pppoe
/ppp secret add name=231009185221-IRFAN profile=PAKET1 service=pppoe
/ppp secret add name=210902194915-IZAL profile=PAKET2 service=pppoe
/ppp secret add name=230909151052-UJANG profile=PAKET1 service=pppoe
/ppp secret add name=220810121116-MAMAN profile=PAKET2 service=pppoe
/ppp secret add name=220720135429-NINA profile=PAKET1 service=pppoe
/ppp secret add name=230909151053-PUTRI profile=PAKET2 service=pppoe
/ppp secret add name=230114074229-REZKA profile=PAKET2 service=pppoe
/ppp secret add name=221119172543-SUGIARTO profile=PAKET3 service=pppoe
/ppp secret add name=221119172548-SUHERMAN profile=PAKET2 service=pppoe
/ppp secret add name=230909151051-UKON profile=PAKET1 service=pppoe
/ppp secret add name=221126120614-OCANG profile=PAKET2 service=pppoe
/ppp secret add name=230114074227-WIWI profile=PAKET1 service=pppoe
/ppp secret add name=230114074228-YAYAT profile=PAKET1 service=pppoe
/ppp secret add name=230615172244-SRI profile=PAKET2 service=pppoe
/ppp secret add name=240315141543-THENDRA profile=PAKET2 service=pppoe
/ppp secret add name=210902161308-DAENG profile=PAKET5 service=pppoe
/ppp secret add name=210902161520-KEMAN profile=PAKET2 service=pppoe
/ppp secret add name=231008170930-NOVISA profile=PAKET2 service=pppoe
/ppp secret add name=IWAN profile=PAKET1 service=pppoe
/ppp secret add name=EMANNUR profile=PAKET1 service=pppoe
/ppp secret add name=EDI profile=PAKET1 service=pppoe
/ppp secret add name=AMAT profile=PAKET1 service=pppoe
/ppp secret add name=SAHMAN profile=PAKET1 service=pppoe
/ppp secret add name=ROSA profile=PAKET1 service=pppoe
/ppp secret add name=11200001-HARIYADI profile=PAKET1 service=pppoe
/ppp secret add name=211222184753-YAYAN profile=PAKET1 service=pppoe
/ppp secret add name=210902163935-NUR profile=PAKET1 service=pppoe
/ppp secret add name=230102125719-IMAT profile=PAKET1 service=pppoe
/ppp secret add name=FAJAR profile=PAKET1 service=pppoe
/ppp secret add name=230909151081-YOPPI profile=PAKET1 service=pppoe
/ppp secret add name=210901143237-MANO profile=PAKET2 service=pppoe
/ppp secret add name=210901143046-SENDUL profile=PAKET1 service=pppoe
/ppp secret add name=210901120736-ALYA profile=PAKET1 service=pppoe
/ppp secret add name=210901120952-CINDI profile=PAKET1 service=pppoe
/ppp secret add name=210902130133-ASEPDEDI profile=PAKET1 service=pppoe
/ppp secret add name=210901115359-RESI profile=PAKET3 service=pppoe
/ppp secret add name=210902125742-IKIN profile=PAKET1 service=pppoe
/ppp secret add name=210901120842-HENDAR profile=PAKET2 service=pppoe
/ppp secret add name=210902134955-IISMARTINI profile=PAKET1 service=pppoe
/ppp secret add name=210902124240-OJEH profile=PAKET1 service=pppoe
/ppp secret add name=210901143402-BUALDY profile=PAKET1 service=pppoe
/ppp secret add name=211209092917-CINDIANDANG profile=PAKET2 service=pppoe
/ppp secret add name=220604103729-ADAM profile=PAKET3 service=pppoe
/ppp secret add name=230909151065-ADIBIL profile="PAKET HEMAT" service=pppoe
/ppp secret add name=5G profile=PAKET5 service=pppoe
/ppp secret add name=WARUNGAMAT profile=PAKET1 service=pppoe
/ppp secret add name=5G1 profile=PAKET5 service=pppoe
/ppp secret add name=5G2 profile=PAKET5 service=pppoe
/ppp secret add name=5G3 profile=PAKET5 service=pppoe
/ppp secret add name=5G4 profile=PAKET5 service=pppoe
/ppp secret add name=210902133157-ITANG profile=PAKET1 service=pppoe
/ppp secret add name=210901115538-EDI profile=PAKET1 service=pppoe
/ppp secret add name=210901143749-ABANG profile=PAKET2 service=pppoe
/ppp secret add name=210902132954-MORFIN profile=PAKET1 service=pppoe
/ppp secret add name=r3 profile=PAKET5 service=pppoe
/ppp secret add name=230613081736-KOMALA profile=PAKET1 service=pppoe
/ppp secret add name=230613081737-ADE profile=PAKET1 service=pppoe
/ppp secret add name=230114074213-CAHYANA profile=PAKET1 service=pppoe
/ppp secret add name=210902135124-ATEN profile=PAKET1 service=pppoe
/ppp secret add name=240315141544-DEDEN profile="PAKET MANTAP" service=pppoe
/ppp secret add name=230909151082-ELIS profile=PAKET1 service=pppoe
/ppp secret add name=221119172546-YAYAH profile=PAKET2 service=pppoe
/ppp secret add name=230114074224-RIKA profile=PAKET1 service=pppoe
/ppp secret add name=221119172545-IKA profile=PAKET5 service=pppoe
/ppp secret add name=230114190806-SABRINA profile=PAKET1 service=pppoe
/ppp secret add name=230114190807-SRI profile=PAKET1 service=pppoe
/ppp secret add disabled=yes name=240315141545-VIKY profile=PAKET1 service=pppoe
/ppp secret add name=230909151083-BAGUS profile=PAKET1 service=pppoe
/ppp secret add name=210901143902-TOKOFAHRUN profile=PAKET1 service=pppoe
/ppp secret add name=220901083021-YADI profile=PAKET2 service=pppoe
/ppp secret add name=230114074222-RESTI profile="PAKET MANTAP" service=pppoe
/ppp secret add name=210902123554-KURDI profile=PAKET3 service=pppoe
/ppp secret add name=210902123948-IIN profile=PAKET1 service=pppoe
/ppp secret add name=220307114338-ACEP profile=PAKET2 service=pppoe
/ppp secret add name=230114074230-HERY profile="PAKET HEMAT" service=pppoe
/ppp secret add disabled=yes name=230108152454-YANA profile=PAKET1 service=pppoe
/ppp secret add name=210902134333-EUNGGING profile=PAKET1 service=pppoe
/ppp secret add name=210902164954-WINDA profile="PAKET TURBO" service=pppoe
/ppp secret add name=231008170937-SIFA profile=PAKET1 service=pppoe
/ppp secret add name=210902165036-IRVA profile=PAKET3 service=pppoe
/ppp secret add name=220810190846-SUKAENAH profile=PAKET2 service=pppoe
/ppp secret add name=220412123320-DEWI profile=PAKET2 service=pppoe
/ppp secret add name=210902165403-ALDY profile=PAKET2 service=pppoe
/ppp secret add name=220218062120-ETI profile=PAKET2 service=pppoe
/ppp secret add name=230909151084-JAJANG profile=PAKET2 service=pppoe
/ppp secret add name=YOFI profile="PAKET HEMAT" service=pppoe
/ppp secret add disabled=yes name=RUMAH profile="PAKET HEMAT" service=pppoe
/ppp secret add name=231209182072-SEFTIANY profile=PAKET1 service=pppoe
/ppp secret add name=210902170410-ELIN profile=PAKET2 service=pppoe
/ppp secret add name=240315141546-GILANG profile=PAKET1 service=pppoe
/ppp secret add name=210915173502-RIRI profile=PAKET1 service=pppoe
/ppp secret add name=230909151085-REYNALDI profile=PAKET2 service=pppoe
/ppp secret add name=230909151086-MARLIAWATI profile=PAKET1 service=pppoe
/ppp secret add name=240315141547-RAHMAT profile=PAKET1 service=pppoe
/ppp secret add name=230909151087-HANI profile=PAKET1 service=pppoe
/ppp secret add name=230909151088-EPIN profile=PAKET1 service=pppoe
/ppp secret add name=230909151089-ENTIN profile=PAKET1 service=pppoe
/ppp secret add name=230613081738-UYAT profile=PAKET1 service=pppoe
/ppp secret add name=230613081739-GUGUN profile=PAKET1 service=pppoe
/ppp secret add name=230613081740-DUDIT profile=PAKET1 service=pppoe
/ppp secret add name=230114190808-SIDIK profile=PAKET1 service=pppoe
/ppp secret add name=231009185225-DADANG profile=PAKET1 service=pppoe
/ppp secret add name=231008170944-SOLIHIN profile=PAKET1 service=pppoe
/ppp secret add name=230909151091-ANI profile=PAKET1 service=pppoe
/ppp secret add name=9900001-LUTHFI profile=PAKET1 service=pppoe
/ppp secret add name=230126060439-RUDI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=240315141548-INDRI profile=PAKET1 service=pppoe
/ppp secret add name=230909151092-IMASWATI profile=PAKET1 service=pppoe
/ppp secret add name=231008170945-MURNI profile=PAKET2 service=pppoe
/ppp secret add name=230909151093-SOPAN profile="PAKET HEMAT" service=pppoe
/ppp secret add name=240315141549-VIDI profile=PAKET2 service=pppoe
/ppp secret add name=230909151094-RIKA profile=PAKET1 service=pppoe
/ppp secret add name=230909151095-IPAN profile=PAKET1 service=pppoe
/ppp secret add disabled=yes name=11200002-ISUR profile=PAKET2 service=pppoe
/ppp secret add name=230126060440-IIS profile=PAKET2 service=pppoe
/ppp secret add disabled=yes name=220309142259-JUWITA profile=PAKET1 service=pppoe
/ppp secret add name=230613081741-DEDI profile=PAKET1 service=pppoe
/ppp secret add name=221212152521-IMAN profile=PAKET1 service=pppoe
/ppp secret add name=240504175810-DIKI profile=PAKET1 service=pppoe
/ppp secret add name=240315141550-JAJANG profile=PAKET1 service=pppoe
/ppp secret add disabled=yes name=220107190811-ILHAM profile="PAKET MANTAP" service=pppoe
/ppp secret add disabled=yes name=220309142260-INDRI profile="PAKET HEMAT" service=pppoe
/ppp secret add disabled=yes name=240315141551-KANIA profile=PAKET1 service=pppoe
/ppp secret add name=240315141552-AYAT profile=PAKET1 service=pppoe
/ppp secret add name=230909151096-MIA profile=PAKET1 service=pppoe
/ppp secret add name=240315141553-SUMARNA profile=PAKET1 service=pppoe
/ppp secret add name=231009185226-RICKY profile="PAKET HEMAT" service=pppoe
/ppp secret add name=220203105928-AGUNG profile=PAKET1 service=pppoe
/ppp secret add name=221212153130-SONA profile=PAKET2 service=pppoe
/ppp secret add name=230311155640-DIDIN profile=PAKET1 service=pppoe
/ppp secret add disabled=yes name=240315141554-ITA profile="PAKET HEMAT" service=pppoe
/ppp secret add name=221101132931-DADI profile=PAKET1 service=pppoe
/ppp secret add name=230126060441-ERVAN profile=PAKET1 service=pppoe
/ppp secret add name=230613081742-SUDRAJAT profile=PAKET1 service=pppoe
/ppp secret add name=240315141555-IIN profile=PAKET1 service=pppoe
/ppp secret add name=230126060442-RACHMAD profile=PAKET2 service=pppoe
/ppp secret add name=230613081743-AGUS profile=PAKET1 service=pppoe
/ppp secret add name=230613081744-AANG profile=PAKET1 service=pppoe
/ppp secret add name=230613081745-SEPTIAWAN profile=PAKET1 service=pppoe
/ppp secret add name=230613081746-IYUS profile=PAKET1 service=pppoe
/ppp secret add disabled=yes name=240315141556-PINA profile=PAKET1 service=pppoe
/ppp secret add name=230909151067-ADE profile=PAKET1 service=pppoe
/ppp secret add name=220109202027-DIKI profile=PAKET2 service=pppoe
/ppp secret add name=211209092759-LENI profile=PAKET1 service=pppoe
/ppp secret add name=220709164810-TIA profile=PAKET1 service=pppoe
/ppp secret add name=210902170808-DECKY profile=PAKET3 service=pppoe
/ppp secret add name=220404134237-SITI profile="PAKET PUAS" service=pppoe
/ppp secret add name=220317135834-OKTAVIANI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=211202114506-ANIS profile=PAKET1 service=pppoe
/ppp secret add name=230613081747-YAYAT profile=PAKET1 service=pppoe
/ppp secret add name=230907102222-YUSUFA profile=PAKET1 service=pppoe
/ppp secret add name=210902165444-SELAMET profile=PAKET2 service=pppoe
/ppp secret add name=230114074218-SARIAH profile="PAKET HEMAT" service=pppoe
/ppp secret add name=240315141557-RIAN profile=PAKET1 service=pppoe
/ppp secret add name=230613081748-PERA profile=PAKET2 service=pppoe
/ppp secret add name=240315141558-SITI profile=PAKET1 service=pppoe
/ppp secret add name=230613081749-FITRI profile=PAKET1 service=pppoe
/ppp secret add name=230613081750-SIDIK profile="PAKET HEMAT" service=pppoe
/ppp secret add name=240315141559-ARNI profile=PAKET2 service=pppoe
/ppp secret add name=210927114345-RISMA profile=PAKET1 service=pppoe
/ppp secret add name=240315141560-AI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=230613081751-SITI profile=PAKET1 service=pppoe
/ppp secret add name=230613081752-SUNANDAR profile="PAKET PUAS" service=pppoe
/ppp secret add name=230909151097-HERI profile=PAKET1 service=pppoe
/ppp secret add name=230613081753-WAHYUDIN profile=PAKET1 service=pppoe
/ppp secret add name=240315141561-EDDY profile=PAKET1 service=pppoe
/ppp secret add name=230613081754-NENDEN profile=PAKET1 service=pppoe
/ppp secret add disabled=yes name=230909151098-ENCAR profile="PAKET HEMAT" service=pppoe
/ppp secret add name=221109122214-ALISKA profile=PAKET1 service=pppoe
/ppp secret add name=240315141562-SARDAN profile="PAKET HEMAT" service=pppoe
/ppp secret add name=230126060443-WIWIN profile=PAKET1 service=pppoe
/ppp secret add name=240315141563-ASEP profile=PAKET1 service=pppoe
/ppp secret add name=230126060444-MUTHIYA profile=PAKET1 service=pppoe
/ppp secret add name=230909151099-RUSLI profile=PAKET1 service=pppoe
/ppp secret add name=240315141564-GUGUN profile=PAKET1 service=pppoe
/ppp secret add name=230126060445-AGUS profile=PAKET1 service=pppoe
/ppp secret add name=230613081755-UJANG profile=PAKET1 service=pppoe
/ppp secret add name=230909151100-IRVAN profile=PAKET1 service=pppoe
/ppp secret add name=240315141565-NINA profile=PAKET1 service=pppoe
/ppp secret add name=210902134550-IPIN profile=PAKET1 service=pppoe
/ppp secret add name=230613081757-EULIS profile=PAKET1 service=pppoe
/ppp secret add name=230909151101-NANDANG profile=PAKET1 service=pppoe
/ppp secret add name=221119172549-PURI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=230613081758-SITI profile=PAKET1 service=pppoe
/ppp secret add name=221109135358-ADELIA profile=PAKET1 service=pppoe
/ppp secret add name=240315141566-MUTIARA profile=PAKET5 service=pppoe
/ppp secret add name=230613081759-ASEP profile=PAKET1 service=pppoe
/ppp secret add name=240315141567-PAJAR profile="PAKET HEMAT" service=pppoe
/ppp secret add name=230613081760-WIDARYANTO profile=PAKET1 service=pppoe
/ppp secret add name=240315141568-FITRIYA profile=PAKET1 service=pppoe
/ppp secret add disabled=yes name=240315141569-JUJU profile=PAKET1 service=pppoe
/ppp secret add name=241006135944-FIRMAN profile=PAKET2 service=pppoe
/ppp secret add name=240315141570-DANA profile=PAKET1 service=pppoe
/ppp secret add name=240315141571-ADE profile="PAKET HEMAT" service=pppoe
/ppp secret add name=230613081761-HENDRA profile=PAKET1 service=pppoe
/ppp secret add name=230114074215-SITI profile=PAKET2 service=pppoe
/ppp secret add name=220808121224-ANTON profile=PAKET1 service=pppoe
/ppp secret add name=230909151064-VINA profile=PAKET1 service=pppoe
/ppp secret add disabled=yes name=230909151068-NUR profile=PAKET1 service=pppoe
/ppp secret add name=240315141572-YENI profile=PAKET1 service=pppoe
/ppp secret add name=210902132104-ARFAN profile=PAKET3 service=pppoe
/ppp secret add name=210902135207-ARIS profile=PAKET1 service=pppoe
/ppp secret add name=210902140040-TONI profile=PAKET1 service=pppoe
/ppp secret add name=210902123711-EMAN profile=PAKET3 service=pppoe
/ppp secret add name=240315141573-ELIS profile=PAKET1 service=pppoe
/ppp secret add name=241006135945-MIANETA profile=PAKET1 service=pppoe
/ppp secret add name=221112092334-NENI profile=PAKET1 service=pppoe
/ppp secret add name=210902124742-RONI profile=PAKET1 service=pppoe
/ppp secret add name=210902135913-SADELI profile=PAKET1 service=pppoe
/ppp secret add name=220510100316-YUDI profile=PAKET1 service=pppoe
/ppp secret add name=221217135004-SELI profile=PAKET2 service=pppoe
/ppp secret add name=210902135747-YUDA profile=PAKET1 service=pppoe
/ppp secret add name=220315160317-ABIN profile=PAKET1 service=pppoe
/ppp secret add name=211202112632-HANI profile=PAKET1 service=pppoe
/ppp secret add name=230909151047-RULLY profile="PAKET HEMAT" service=pppoe
/ppp secret add name=210901121109-WIDI profile=PAKET1 service=pppoe
/ppp secret add name=211106085026-TATANG profile=PAKET1 service=pppoe
/ppp secret add name=220108081811-ANDA profile=PAKET1 service=pppoe
/ppp secret add disabled=yes name=10300001-RIAN profile=PAKET1 service=pppoe
/ppp secret add name=11100001-IIS profile=PAKET1 service=pppoe
/ppp secret add name=220108112546-SUSI profile=PAKET1 service=pppoe
/ppp secret add name=220108101310-AGUS profile=PAKET1 service=pppoe
/ppp secret add name=210902195917-EMAN profile=PAKET1 service=pppoe
/ppp secret add name=230613081756-KANKAN profile=PAKET1 service=pppoe
/ppp secret add name=210901144241-HENDRA profile=PAKET2 service=pppoe
/ppp secret add name=10300077-SEPHIA profile=PAKET1 service=pppoe
/ppp secret add name=10300078-EKA profile=PAKET1 service=pppoe
/ppp secret add name=210902195330-DYAN profile=PAKET1 service=pppoe
/ppp secret add name=210902193918-ISTANA profile=PAKET2 service=pppoe
/ppp secret add name=230615172246-EUISLUMAYA profile=PAKET1 service=pppoe
/ppp secret add name=220110164540-SUDRAJAT profile=PAKET1 service=pppoe
/ppp secret add name=220402104649-SITIAMINAH profile=PAKET1 service=pppoe
/ppp secret add name=230613081733-NINA profile=PAKET1 service=pppoe
/ppp secret add name=210902195807-HENDRA profile=PAKET1 service=pppoe
/ppp secret add name=230104175459-ETIYULIANTI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=230104175460-SITIMASITOH profile=PAKET1 service=pppoe
/ppp secret add name=230104175462-IMAMRAHMAN profile=PAKET1 service=pppoe
/ppp secret add name=230613081732-NETI profile=PAKET1 service=pppoe
/ppp secret add name=230104175463-FIKI profile=PAKET1 service=pppoe
/ppp secret add name=230613081730-RENALDI profile=PAKET1 service=pppoe
/ppp secret add name=210902195622-BAGAS profile=PAKET1 service=pppoe
/ppp secret add disabled=yes name=11200003-IWAN profile=PAKET1 service=pppoe
/ppp secret add name=221016145225-IING profile=PAKET1 service=pppoe
/ppp secret add name=230613081726-DIANA profile=PAKET1 service=pppoe
/ppp secret add name=210902195553-TOTO profile=PAKET2 service=pppoe
/ppp secret add name=230613081723-EULISYANI profile=PAKET1 service=pppoe
/ppp secret add name=221016171724-IPA profile=PAKET1 service=pppoe
/ppp secret add name=220910200413-WIDANINGSIH profile=PAKET2 service=pppoe
/ppp secret add name=211005123816-FATIMAH profile=PAKET1 service=pppoe
/ppp secret add name=230615172245-DEWIUTARI profile=PAKET1 service=pppoe
/ppp secret add name=210902195716-DUDI profile=PAKET1 service=pppoe
/ppp secret add name=230613081724-FERI profile=PAKET2 service=pppoe
/ppp secret add name=210902194811-EFI profile=PAKET2 service=pppoe
/ppp secret add name=220309142257-RUDI profile=PAKET1 service=pppoe
/ppp secret add name=220309142258-DAMAR profile=PAKET1 service=pppoe
/ppp secret add name=210902194311-IMAN profile=PAKET1 service=pppoe
/ppp secret add disabled=yes name=210902194358-IWAN profile=PAKET2 service=pppoe
/ppp secret add name=210902195422-SILVY profile=PAKET1 service=pppoe
/ppp secret add name=220309142262-ABING profile=PAKET1 service=pppoe
/ppp secret add name=210902194958-DENI profile=PAKET2 service=pppoe
/ppp secret add name=211201182657-NOVI profile=PAKET1 service=pppoe
/ppp secret add name=220309142261-YATNA profile=PAKET1 service=pppoe
/ppp secret add name=210902194446-IMAM profile=PAKET2 service=pppoe
/ppp secret add name=211125155525-LIA profile=PAKET2 service=pppoe
/ppp secret add name=10200001-TITA profile=PAKET3 service=pppoe
/ppp secret add name=10400001-SITI profile=PAKET1 service=pppoe
/ppp secret add name=10300079-RIDWAN profile=PAKET1 service=pppoe
/ppp secret add name=10300080-YANTI profile=PAKET1 service=pppoe
/ppp secret add name=10300081-NADIA profile=PAKET4 service=pppoe
/ppp secret add name=10300082-ECEP profile=PAKET2 service=pppoe
/ppp secret add name=10300083-LIA profile=PAKET1 service=pppoe
/ppp secret add name=10100001-AGUNG profile=PAKET2 service=pppoe
/ppp secret add name=10100197-YANA profile=PAKET1 service=pppoe
/ppp secret add name=10100198-YOPI profile=PAKET1 service=pppoe
/ppp secret add name=10200107-RESTI profile=PAKET1 service=pppoe
/ppp secret add name=10200108-NENI profile=PAKET1 service=pppoe
/ppp secret add name=11100108-ABDIKA profile=PAKET4 service=pppoe
/ppp secret add name=10100199-RIADI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=10500001-SUTISNA profile=PAKET2 service=pppoe
/ppp secret add name=101000001-TOMI profile=PAKET1 service=pppoe
/ppp secret add name=230613081748-PERARATNA profile=PAKET2 service=pppoe
/ppp secret add name=241109132115-LILIK profile=PAKET1 service=pppoe
/ppp secret add name=SAUNG profile=PAKET4 service=pppoe
/ppp secret add name=AYI profile=PAKET1 service=pppoe
/ppp secret add name=220715102353-RICKI profile=PAKET2 service=pppoe
/ppp secret add name=220715102356-ALDI profile=PAKET1 service=pppoe
/ppp secret add name=220715102355-AWALUDIN profile="PAKET HEMAT" service=pppoe
/ppp secret add name=230613081724-FERIMAULANA profile=PAKET1 service=pppoe
/ppp secret add name=10200109-DEA profile=PAKET1 service=pppoe
/ppp secret add name=210902163107-MAMAHIIP profile=PAKET2 service=pppoe
/ppp secret add name=241203121051-REVANA profile=PAKET2 service=pppoe
/ppp secret add name=241205150940-FITRIANA profile="PAKET HEMAT" service=pppoe
/ppp secret add name=241206161113-MIASEPTIANI profile=PAKET1 service=pppoe
/ppp secret add name=210902162706-ADANG profile=PAKET2 service=pppoe
/ppp secret add name=241213145556-NOER profile=PAKET2 service=pppoe
/ppp secret add name=241213155647-SAADAH profile=PAKET1 service=pppoe
/ppp secret add name=241213180117-LERRY profile=PAKET1 service=pppoe
/ppp secret add name=241213191106-NOVIARYANTI profile=PAKET2 service=pppoe
/ppp secret add name=241214105706-ULAYYA profile=PAKET1 service=pppoe
/ppp secret add name=210902163716-INTAN profile=PAKET2 service=pppoe
/ppp secret add name=241216110713-ENDI profile=PAKET1 service=pppoe
/ppp secret add name=241218114812-ASEPSOPANDI profile=PAKET1 service=pppoe
/ppp secret add name=241218133449-MARIAM profile=PAKET1 service=pppoe
/ppp secret add name=241219114432-DAUS profile=PAKET1 service=pppoe
/ppp secret add name=241220150933-FERDY profile=PAKET1 service=pppoe
/ppp secret add disabled=yes name=220715102354-AJI profile=PAKET1 service=pppoe
/ppp secret add name=241225104811-CACA profile=PAKET1 service=pppoe
/ppp secret add name=210902194604-KEMBAR profile=PAKET3 service=pppoe
/ppp secret add name=210902195251-YANTI profile=PAKET2 service=pppoe
/ppp secret add name=210902125337-TATA profile=PAKET1 service=pppoe
/ppp secret add name=211002153847-SARIPUDIN profile=PAKET1 service=pppoe
/ppp secret add name=210902135936-SUGEUNG profile=PAKET1 service=pppoe
/ppp secret add name=220109070515-TAUFIK profile=PAKET2 service=pppoe
/ppp secret add name=221119172551-RISA profile=PAKET2 service=pppoe
/ppp secret add name=211210102802-ASEP profile=PAKET2 service=pppoe
/ppp secret add name=211225102400-ROHMAT profile=PAKET1 service=pppoe
/ppp secret add name=230114074217-NONO profile=PAKET1 service=pppoe
/ppp secret add name=210902134124-AYU profile=PAKET1 service=pppoe
/ppp secret add name=221228123323-WIDIA profile=PAKET1 service=pppoe
/ppp secret add name=210902132834-TOAH profile=PAKET1 service=pppoe
/ppp secret add name=210902124310-IYEP profile=PAKET1 service=pppoe
/ppp secret add name=221217133904-RACHMAT profile=PAKET2 service=pppoe
/ppp secret add name=210902123833-IQBAL profile=PAKET5 service=pppoe
/ppp secret add name=250103142605-AYUSHINTA profile=PAKET2 service=pppoe
/ppp secret add name=IVENK profile=PAKET1 service=pppoe
/ppp secret add name=250105143745-ISMAIL profile=PAKET1 service=pppoe
/ppp secret add name=230114074220-ASEP profile=PAKET1 service=pppoe
/ppp secret add name=220417143556-ANI profile=PAKET1 service=pppoe
/ppp secret add name=210901144114-ENDA profile=PAKET1 service=pppoe
/ppp secret add name=210901144009-HASAN profile=PAKET1 service=pppoe
/ppp secret add name=210902135508-YOGA profile=PAKET1 service=pppoe
/ppp secret add name=210902125836-NAUFAL profile=PAKET1 service=pppoe
/ppp secret add name=230906111355-EFA profile=PAKET1 service=pppoe
/ppp secret add name=220620140633-ENDANG profile=PAKET1 service=pppoe
/ppp secret add name=210902193817-ROSA profile=PAKET1 service=pppoe
/ppp secret add name=220607160905-SEPTI profile=PAKET2 service=pppoe
/ppp secret add name=250111090317-TUTI profile=PAKET1 service=pppoe
/ppp secret add name=230304191412-AEP profile=PAKET1 service=pppoe
/ppp secret add name=250120095543-LINA profile=PAKET1 service=pppoe
/ppp secret add name=250201113106-OMIH profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250202152946-GUGUM profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250207112615-YAYANG profile="PAKET HEMAT" service=pppoe
/ppp secret add name=10100198-YOPIHIDAYAT profile=PAKET1 service=pppoe
/ppp secret add name=250212093026-SUNAEDI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250215140432-ASEP profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250221163051-MIASITI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250222093240-EUISSITI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250222104603-VINAJULI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=210902200033-BUDIZOO profile=PAKET2 service=pppoe
/ppp secret add name=211109135251-FERA profile=PAKET2 service=pppoe
/ppp secret add name=211109135123-RIYAN profile=PAKET2 service=pppoe
/ppp secret add name=211223071015-DEBI profile=PAKET2 service=pppoe
/ppp secret add name=230126060435-DESY profile=PAKET2 service=pppoe
/ppp secret add name=230126060436-TATI profile=PAKET2 service=pppoe
/ppp secret add name=250223101518-ENENG profile="PAKET HEMAT" service=pppoe
/ppp secret add disabled=yes name=250223101518-ENENGFITRI profile=PAKET2 service=pppoe
/ppp secret add name=250226183037-SITI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250226183048-SITIKOM profile="PAKET HEMAT" service=pppoe
/ppp secret add name=240315141558-SITISURYATI profile=PAKET1 service=pppoe
/ppp secret add name=250228105742-PURNAMAALI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250228161959-SARI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250302105822-ROBBY profile="PAKET MANTAP" service=pppoe
/ppp secret add name=250302114437-DINIFATIMAH profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250302134218-CEPI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250303143516-TATIKARYATI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250303155354-ANENG profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250305104835-NURSULASTRI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250305141050-HARYANTO profile="PAKET HEMAT" service=pppoe
/ppp secret add name=220717160400-NERI profile=PAKET2 service=pppoe
/ppp secret add name=211116183142-ANTONWINDANI profile=PAKET2 service=pppoe
/ppp secret add name=250310164048-MAHMURI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250311155850-PANDU profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250314150512-SINTA profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250405124250-PEPI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250409132220-TIARA profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250411104651-EVA profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250412104331-YAYATHIDAYAT profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250412162047-RAFLI profile="PAKET MANTAP" service=pppoe
/ppp secret add name=250416103529-ADANG profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250419103915-RIO profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250419130956-FENI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250422120606-RINA profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250425113021-NONOH profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250427121121-REKA profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250427130456-NENI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250504122116-DEDIH profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250507112153-VINI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250509132105-SEPTIAN profile="PAKET HEMAT" service=pppoe
/ppp secret add name=210902163618-SANJAYA profile=PAKET1 service=pppoe
/ppp secret add name=10200130-DEDENUR profile="PAKET MANTAP" service=pppoe
/ppp secret add name=10200131-NUNUNG profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250526152352-IRPAN profile="PAKET HEMAT" service=pppoe
/ppp secret add name=10600001-DIANROHENDI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=10600021-ELAH profile="PAKET HEMAT" service=pppoe
/ppp secret add name=10100219-DEDENMARDANI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250601173512-DINDA profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250603112655-ALIT profile="PAKET HEMAT" service=pppoe
/ppp secret add disabled=yes name=250605111505-ERNI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250612113506-ARIAZHAR profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250616112815-HERI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250620100310-YATI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250620151538-IMAN profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250622140735-WAWAN profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250622163127-SAMSUL profile="PAKET MANTAP" service=pppoe
/ppp secret add name=250626210230-ADI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250701170714-WATI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250704095837-NENI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250704154020-SINTA profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250710165213-MARTINA profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250717140138-MENAH profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250721095023-KUSTIWA profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250722174120-NANA profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250724204016-WINDA profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250726103721-DEDEN profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250803143349-YOGA profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250806154003-CEPI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250809135620-ERNI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250810145100-DEDEH profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250824110757-NAUFALRAIS profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250831173811-YANYAN profile="PAKET HEMAT" service=pppoe
/ppp secret add disabled=yes name=250901095118-NANI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250901115943-ANIE profile="PAKET MANTAP" service=pppoe
/ppp secret add name=250902111545-QUATUL profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250905173726-LUKMAN profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250906110628-ENENG profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250907163740-YUSEDIANA profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250913143424-NURAHMAH profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250919191420-PANGGUNG profile=TEST service=pppoe
/ppp secret add name=250927175052-PANGGUNGBOSUR profile=PAKET4 service=pppoe
/ppp secret add name=251001112727-LOUISE profile="PAKET HEMAT" service=pppoe
/ppp secret add name=251001131207-SRI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=251002122329-KUSMIARSIH profile="PAKET HEMAT" service=pppoe
/ppp secret add name=KAFIR profile="PAKET MANTAP" service=pppoe
/ppp secret add disabled=yes name=251007105218-EVA profile="PAKET HEMAT" service=pppoe
/ppp secret add name=210902133555-ARTI profile="PAKET MANTAP" service=pppoe
/ppp secret add name=251009185936-SONI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=251017172705-FUZI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=251017172705-FUZINUR profile="PAKET HEMAT" service=pppoe
/ppp secret add disabled=yes name=251019150445-SHOBUR profile="PAKET HEMAT" service=pppoe
/ppp secret add name=251102102753-NIA profile="PAKET HEMAT" service=pppoe
/ppp secret add name=251102151517-UJANGRAHMAT profile="PAKET HEMAT" service=pppoe
/ppp secret add name=251103103741-WIDA profile="PAKET HEMAT" service=pppoe
/ppp secret add local-address=10.10.13.1 name=251103182737-YERI profile="PAKET MANTAP" remote-address=10.10.13.178 service=pppoe
/ppp secret add name=251104132447-PIKRI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=251104143339-FUJI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=251104155759-KATINO profile="PAKET HEMAT" service=pppoe
/ppp secret add name=251104195044-EULIS profile="PAKET HEMAT" service=pppoe
/ppp secret add name=251105103714-TOTONG profile="PAKET PUAS" service=pppoe
/ppp secret add name=251105121104-NENGDEDAH profile="PAKET HEMAT" service=pppoe
/ppp secret add name=251105134532-PAIMIN profile="PAKET HEMAT" service=pppoe
/ppp secret add name=251105172045-DIDIN profile="PAKET HEMAT" service=pppoe
/ppp secret add name=251105173702-SIGIT profile="PAKET HEMAT" service=pppoe
/ppp secret add name=251106100416-SITI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=251106143239-ASEPDEDI profile="PAKET MANTAP" service=pppoe
/ppp secret add name=251106143239-ASEPDEPY profile="PAKET MANTAP" service=pppoe
/ppp secret add name=251107095310-YOYOH profile="PAKET HEMAT" service=pppoe
/ppp secret add name=251107145714-TISNA profile="PAKET HEMAT" service=pppoe
/ppp secret add name=251107173707-WINDA profile="PAKET HEMAT" service=pppoe
/ppp secret add name=251108161957-JIMI profile="PAKET PUAS" service=pppoe
/ppp secret add name=251109114922-SITINURLAENI profile="PAKET MANTAP" service=pppoe
/ppp secret add name=220717160400-NERI2 profile="PAKET MANTAP" service=pppoe
/ppp secret add name=251111115915-TASYA profile="PAKET HEMAT" service=pppoe
/ppp secret add name=210902170651-LERY profile="PAKET HEMAT" service=pppoe
/ppp secret add name=251111163823-WINA profile="PAKET MANTAP" service=pppoe
/ppp secret add name=251112091645-YUYUN profile="PAKET HEMAT" service=pppoe
/ppp secret add name=251117160919-LILIS profile="PAKET MANTAP" service=pppoe
/ppp secret add name=251124182744-WILI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=251125120936-WINIARTI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=251128141759-EEN profile="PAKET MANTAP" service=pppoe
/ppp secret add name=251129143806-EROS profile="PAKET HEMAT" service=pppoe
/ppp secret add name=251130130352-NOVI profile="PAKET HEMAT" service=pppoe
/ppp secret add name="251203113041=ELSA" profile="PAKET HEMAT" service=pppoe
/ppp secret add name=251203113041-ELSANUR profile="PAKET HEMAT" service=pppoe
/ppp secret add name=251204095426-RIFA profile="PAKET HEMAT" service=pppoe
/ppp secret add name=251204230928-DEDE profile="PAKET HEMAT" service=pppoe
/ppp secret add name=251206145219-ROMITA profile="PAKET MANTAP" service=pppoe
/ppp secret add disabled=yes name=251206162816-ATTAQWA profile="PAKET PUAS" service=pppoe
/ppp secret add name=240315141544-DEDENKUSNIDAR profile="PAKET MANTAP" service=pppoe
/ppp secret add disabled=yes name=251208161616-LILIS profile="PAKET HEMAT" service=pppoe
/ppp secret add name=251211100126-MIA profile=PAKET2 service=pppoe
/ppp secret add name=251216113837-ULPAH profile="PAKET HEMAT" service=pppoe
/ppp secret add name=251218122553-RENITA profile="PAKET PUAS" service=pppoe
/ppp secret add name=251218140931-DADAN profile="PAKET HEMAT" service=pppoe
/ppp secret add name=251220163813-FIRMANSYAH profile="PAKET MANTAP" service=pppoe
/ppp secret add name="251224110322=YUNI" profile="PAKET HEMAT" service=pppoe
/ppp secret add name=251225125255-WAHYUNI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=251228112206-DIMAS profile="PAKET HEMAT" service=pppoe
/ppp secret add name=251231113740-SANA profile="PAKET HEMAT" service=pppoe
/ppp secret add name=260103122904-RIVALDI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=260107165904-LATIFUDIN profile="PAKET HEMAT" service=pppoe
/ppp secret add name=260109112002-MUMAN profile="PAKET HEMAT" service=pppoe
/ppp secret add name=260109150622-ANIHENDRAYANI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=260113134055-HAIKAL profile="PAKET MANTAP" service=pppoe
/ppp secret add name=260118103427-RINI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=260119114124-FITRIYANI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=260121134333-DIANHERDIANA profile="PAKET HEMAT" service=pppoe
/ppp secret add name=260125133109-RINAMARIANA profile="PAKET HEMAT" service=pppoe
/ppp secret add name=251220163813-DINDIN profile="PAKET MANTAP" service=pppoe
/ppp secret add name=260126203536-AEP profile="PAKET HEMAT" service=pppoe
/ppp secret add name=260127144410-DHIYA profile="PAKET MANTAP" service=pppoe
/ppp secret add name=260129174645-SITIMARYANI profile="PAKET MANTAP" service=pppoe
/ppp secret add name=260131121150-RISYE profile="PAKET HEMAT" service=pppoe
/ppp secret add name=260131165910-AGUNG profile="PAKET HEMAT" service=pppoe
/ppp secret add name=260201121349-RAMDA profile="PAKET HEMAT" service=pppoe
/ppp secret add name=260201141350-WAWAN profile="PAKET HEMAT" service=pppoe
/ppp secret add name=260202114657-RAENIH profile="PAKET HEMAT" service=pppoe
/ppp secret add name=251103182737-YERIYERI profile="PAKET MANTAP" service=pppoe
/ppp secret add name=260206141227-NOVAN profile="PAKET HEMAT" service=pppoe
/ppp secret add name=260214094828-HENDI profile=PAKET2 service=pppoe
/ppp secret add name=260226172607-UJANG profile="PAKET HEMAT" service=pppoe
/ppp secret add name=260227112325-SUDARSIH profile="PAKET MANTAP" service=pppoe
/ppp secret add name=260227135245-ACEP profile="PAKET MANTAP" service=pppoe
/ppp secret add name=260227162520-ADEJUARIYAH profile="PAKET HEMAT" service=pppoe
/ppp secret add name=260228105519-DEVA profile=PAKET2 service=pppoe
/ppp secret add name=260228123401-SETIAWAN profile=PAKET2 service=pppoe
/ppp secret add name=260302144821-LALA profile="PAKET HEMAT" service=pppoe
/ppp secret add name=260303155159-INDRA profile="PAKET MANTAP" service=pppoe
/ppp secret add name=260304162648-TAUFIK profile="PAKET MANTAP" service=pppoe
/ppp secret add name=260312105131-KOKO profile="PAKET MANTAP" service=pppoe
/ppp secret add name=260318131256-ALVIN profile="PAKET PUAS" service=pppoe
/ppp secret add name=260330134851-DEVIA profile="PAKET HEMAT" service=pppoe
/ppp secret add name=260330135611-LINA profile="PAKET HEMAT" service=pppoe
/ppp secret add name=260330152600-CUCUM profile=PAKET2 service=pppoe
/ppp secret add name=260402181107-BAGUS profile="PAKET HEMAT" service=pppoe
/ppp secret add name=260405165907-DADANG profile="PAKET MANTAP" service=pppoe
/ppp secret add name=260408115030-APRIYANI profile=PAKET2 service=pppoe
/ppp secret add comment="Lilis Suryani - Ciburuy" name=20260424150744-LILIS profile=PAKET1 service=pppoe
/ppp secret add comment="Heni Mulyani - Ciburuy" name=20260425131734-HENI profile=PAKET1 service=pppoe
/ppp secret add name=260427110615-RESTI profile=PAKET1 service=pppoe
/ppp secret add comment="RESTI ALYANI - Bojong Suren Girang" name=20260428105151-RESTI profile=PAKET1 service=pppoe
/ppp secret add comment="RONY - Bojong Seureuh" name=20260428133854-RONY profile="PAKET HEMAT" service=pppoe
/ppp secret add name=260504133035-ELAH profile="PAKET HEMAT" service=pppoe
/ppp secret add comment="DINDA CITRA - Pusat" name=20260504183213-DINDA profile="PAKET HEMAT" service=pppoe
/ppp secret add name=260505102240-ENUR profile="PAKET HEMAT" service=pppoe
/ppp secret add name=260505184707-RENI profile=PAKET2 service=pppoe
/ppp secret add name=260506104505-DICKY profile="PAKET MANTAP" service=pppoe
/ppp secret add name=260506114427-ARFISAR profile="PAKET MANTAP" service=pppoe
/ppp secret add name=260506123709-ARUMI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=260507114325-ROSMAYANTI profile=PAKET2 service=pppoe
/ppp secret add name=260511182420-SHIVA profile="PAKET HEMAT" service=pppoe
/ppp secret add name=260512112214-CUCU profile=PAKET2 service=pppoe
/ppp secret add name=260427110615-YULIA profile=PAKET2 service=pppoe
/ppp secret add name=260513085338-RONAULI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=260513090910-TITAPUSPA profile=PAKET3 service=pppoe
/ppp secret add comment="Bojong Suren - Ayu Wahyudi" name=260513122932-AYUWAHYUDI profile=PAKET3 service=pppoe
/ppp secret add comment="Saepul Ramdani" name=260513160117-SAEPULRAMDANI profile=PAKET3 service=pppoe
/ppp secret add name=20260515155812-SRI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=260515174436-NGIUT profile="PAKET PUAS" service=pppoe
/ppp secret add name=260516114442-TOING profile=PAKET3 service=pppoe
/ppp secret add name=260516114819-TOUNG profile=PAKET3 service=pppoe
/ppp secret add name=260516121054-KUSNA profile="PAKET HEMAT" service=pppoe
/ppp secret add name=260516122945-ASEP profile="PAKET MANTAP" service=pppoe
/ppp secret add name=260516145935-IPENG profile="PAKET HEMAT" service=pppoe
/snmp set enabled=yes trap-generators=start-trap trap-version=2
/system clock set time-zone-name=Asia/Jakarta
/system identity set name=PUSAT
/system note set note=488 show-at-login=no
/system routerboard settings set enter-setup-on=delete-key
/system scheduler add interval=30s name=sched_pppoe_count on-event=update_pppoe_count policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2026-01-05 start-time=15:21:31
/system script add dont-require-permissions=no name=reset-pppoe-230114074226-NENDI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230114074226-NENDI>"
/system script add dont-require-permissions=no name=reset-pppoe-210902124240-OJEH owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902124240-OJEH>"
/system script add dont-require-permissions=no name=reset-pppoe-221119172546-YAYAH owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-221119172546-YAYAH>"
/system script add dont-require-permissions=no name=reset-pppoe-210902161926-IDA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902161926-IDA>"
/system script add dont-require-permissions=no name=reset-pppoe-210902132954-MORFIN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902132954-MORFIN>"
/system script add dont-require-permissions=no name=reset-pppoe-230909151072-DINGGO owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230909151072-DINGGO>"
/system script add dont-require-permissions=no name=reset-pppoe-210902125742-IKIN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902125742-IKIN>"
/system script add dont-require-permissions=no name=reset-pppoe-210902133102-ANWAR owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902133102-ANWAR>"
/system script add dont-require-permissions=no name=reset-pppoe-210902123833-IQBAL owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902123833-IQBAL>"
/system script add dont-require-permissions=no name=reset-pppoe-210902132718-UJANG owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902132718-UJANG>"
/system script add dont-require-permissions=no name=reset-pppoe-230909151075-AYI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230909151075-AYI>"
/system script add dont-require-permissions=no name=reset-pppoe-231008170935-RIA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-231008170935-RIA>"
/system script add dont-require-permissions=no name=reset-pppoe-210901143902-FAHRUN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210901143902-FAHRUN>"
/system script add dont-require-permissions=no name=reset-pppoe-210902134333-EUNGGING owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902134333-EUNGGING>"
/system script add dont-require-permissions=no name=reset-pppoe-220818123605-ESA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-220818123605-ESA>"
/system script add dont-require-permissions=no name=reset-pppoe-210902133706-CIKAL owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902133706-CIKAL>"
/system script add dont-require-permissions=no name=reset-pppoe-210902133157-ITANG owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902133157-ITANG>"
/system script add dont-require-permissions=no name=reset-pppoe-221011122722-TANTI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-221011122722-TANTI>"
/system script add dont-require-permissions=no name=reset-pppoe-221119172544-HENI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-221119172544-HENI>"
/system script add dont-require-permissions=no name=reset-pppoe-220307114338-ACEP owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-220307114338-ACEP>"
/system script add dont-require-permissions=no name=reset-pppoe-230114074225-FENI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230114074225-FENI>"
/system script add dont-require-permissions=no name=reset-pppoe-230114074229-REZKA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230114074229-REZKA>"
/system script add dont-require-permissions=no name=reset-pppoe-230909151084-JAJANG owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230909151084-JAJANG>"
/system script add dont-require-permissions=no name=reset-pppoe-210901120842-HENDAR owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210901120842-HENDAR>"
/system script add dont-require-permissions=no name=reset-pppoe-230114074224-RIKA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230114074224-RIKA>"
/system script add dont-require-permissions=no name=reset-pppoe-230311155641-DEBI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230311155641-DEBI>"
/system script add dont-require-permissions=no name=reset-pppoe-11200001-HARIYADI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-11200001-HARIYADI>"
/system script add dont-require-permissions=no name=reset-pppoe-210901115538-EDI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210901115538-EDI>"
/system script add dont-require-permissions=no name=reset-pppoe-210902134719-UCOK owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902134719-UCOK>"
/system script add dont-require-permissions=no name=reset-pppoe-210902162311-TONO owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902162311-TONO>"
/system script add dont-require-permissions=no name=reset-pppoe-221009174256-RUSTINI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-221009174256-RUSTINI>"
/system script add dont-require-permissions=no name=reset-pppoe-210902165403-ALDY owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902165403-ALDY>"
/system script add dont-require-permissions=no name=reset-pppoe-230613081737-ADE owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230613081737-ADE>"
/system script add dont-require-permissions=no name=reset-pppoe-230114190807-SRI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230114190807-SRI>"
/system script add dont-require-permissions=no name=reset-pppoe-210902164511-DUDE owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902164511-DUDE>"
/system script add dont-require-permissions=no name=reset-pppoe-220810121116-MAMAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-220810121116-MAMAN>"
/system script add dont-require-permissions=no name=reset-pppoe-220801153539-DETI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-220801153539-DETI>"
/system script add dont-require-permissions=no name=reset-pppoe-210901143237-MANO owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210901143237-MANO>"
/system script add dont-require-permissions=no name=reset-pppoe-230613081727-RINI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230613081727-RINI>"
/system script add dont-require-permissions=no name=reset-pppoe-210902170557-YANA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902170557-YANA>"
/system script add dont-require-permissions=no name=reset-pppoe-221228123324-IMAS owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-221228123324-IMAS>"
/system script add dont-require-permissions=no name=reset-pppoe-230909151082-ELIS owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230909151082-ELIS>"
/system script add dont-require-permissions=no name=reset-pppoe-210902163224-AYU owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902163224-AYU>"
/system script add dont-require-permissions=no name=reset-pppoe-220720135429-NINA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-220720135429-NINA>"
/system script add dont-require-permissions=no name=reset-pppoe-231008170930-NOVISA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-231008170930-NOVISA>"
/system script add dont-require-permissions=no name=reset-pppoe-230909151051-UKON owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230909151051-UKON>"
/system script add dont-require-permissions=no name=reset-pppoe-210902165036-IRVA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902165036-IRVA>"
/system script add dont-require-permissions=no name=reset-pppoe-230909151076-KOMARIAH owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230909151076-KOMARIAH>"
/system script add dont-require-permissions=no name=reset-pppoe-210902135311-IYAH owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902135311-IYAH>"
/system script add dont-require-permissions=no name=reset-pppoe-220901083021-YADI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-220901083021-YADI>"
/system script add dont-require-permissions=no name=reset-pppoe-210902161800-GUSTI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902161800-GUSTI>"
/system script add dont-require-permissions=no name=reset-pppoe-210901143902-TOKOFAHRUN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210901143902-TOKOFAHRUN>"
/system script add dont-require-permissions=no name=reset-pppoe-230114074223-TUTI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230114074223-TUTI>"
/system script add dont-require-permissions=no name=reset-pppoe-220218062120-ETI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-220218062120-ETI>"
/system script add dont-require-permissions=no name=reset-pppoe-210901115359-RESI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210901115359-RESI>"
/system script add dont-require-permissions=no name=reset-pppoe-230114074209-DAINE owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230114074209-DAINE>"
/system script add dont-require-permissions=no name=reset-pppoe-210902194915-IZAL owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902194915-IZAL>"
/system script add dont-require-permissions=no name=reset-pppoe-240315141542-ADE owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240315141542-ADE>"
/system script add dont-require-permissions=no name=reset-pppoe-230613081734-YADI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230613081734-YADI>"
/system script add dont-require-permissions=no name=reset-pppoe-230613081736-KOMALA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230613081736-KOMALA>"
/system script add dont-require-permissions=no name=reset-pppoe-230906111356-RINA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230906111356-RINA>"
/system script add dont-require-permissions=no name=reset-pppoe-210902124058-MAYA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902124058-MAYA>"
/system script add dont-require-permissions=no name=reset-pppoe-210902135654-DADI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902135654-DADI>"
/system script add dont-require-permissions=no name=reset-pppoe-230108152454-YANA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230108152454-YANA>"
/system script add dont-require-permissions=no name=reset-pppoe-DIDIN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-DIDIN>"
/system script add dont-require-permissions=no name=reset-pppoe-231008170940-YENI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-231008170940-YENI>"
/system script add dont-require-permissions=no name=reset-pppoe-240315141540-DENDI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240315141540-DENDI>"
/system script add dont-require-permissions=no name=reset-pppoe-210902170221-FROZEN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902170221-FROZEN>"
/system script add dont-require-permissions=no name=reset-pppoe-210902124605-DEA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902124605-DEA>"
/system script add dont-require-permissions=no name=reset-pppoe-231008170936-YUNITA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-231008170936-YUNITA>"
/system script add dont-require-permissions=no name=reset-pppoe-240315141543-THENDRA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240315141543-THENDRA>"
/system script add dont-require-permissions=no name=reset-pppoe-230114190806-SABRINA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230114190806-SABRINA>"
/system script add dont-require-permissions=no name=reset-pppoe-230613081731-SHINTA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230613081731-SHINTA>"
/system script add dont-require-permissions=no name=reset-pppoe-210902134955-IISMARTINI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902134955-IISMARTINI>"
/system script add dont-require-permissions=no name=reset-pppoe-231008170932-YUDI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-231008170932-YUDI>"
/system script add dont-require-permissions=no name=reset-pppoe-230909151050-FIKRI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230909151050-FIKRI>"
/system script add dont-require-permissions=no name=reset-pppoe-210902164603-DENI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902164603-DENI>"
/system script add dont-require-permissions=no name=reset-pppoe-230613081729-DWI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230613081729-DWI>"
/system script add dont-require-permissions=no name=reset-pppoe-210901203434-SANSAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210901203434-SANSAN>"
/system script add dont-require-permissions=no name=reset-pppoe-230909151081-YOPPI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230909151081-YOPPI>"
/system script add dont-require-permissions=no name=reset-pppoe-230909151046-SUMPENA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230909151046-SUMPENA>"
/system script add dont-require-permissions=no name=reset-pppoe-210902135558-KOCREK owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902135558-KOCREK>"
/system script add dont-require-permissions=no name=reset-pppoe-220318142406-AHO owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-220318142406-AHO>"
/system script add dont-require-permissions=no name=reset-pppoe-220718133013-INDRA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-220718133013-INDRA>"
/system script add dont-require-permissions=no name=reset-pppoe-230114074228-YAYAT owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230114074228-YAYAT>"
/system script add dont-require-permissions=no name=reset-pppoe-231009185221-IRFAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-231009185221-IRFAN>"
/system script add dont-require-permissions=no name=reset-pppoe-230909151054-ANGGA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230909151054-ANGGA>"
/system script add dont-require-permissions=no name=reset-pppoe-210902163935-NUR owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902163935-NUR>"
/system script add dont-require-permissions=no name=reset-pppoe-221119172543-SUGIARTO owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-221119172543-SUGIARTO>"
/system script add dont-require-permissions=no name=reset-pppoe-220104200010-DESI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-220104200010-DESI>"
/system script add dont-require-permissions=no name=reset-pppoe-210902163107-IIP owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902163107-IIP>"
/system script add dont-require-permissions=no name=reset-pppoe-231008170939-ROCHSI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-231008170939-ROCHSI>"
/system script add dont-require-permissions=no name=reset-pppoe-WARUNGAMAT owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-WARUNGAMAT>"
/system script add dont-require-permissions=no name=reset-pppoe-230114074231-DIKDIK owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230114074231-DIKDIK>"
/system script add dont-require-permissions=no name=reset-pppoe-210902134829-IKI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902134829-IKI>"
/system script add dont-require-permissions=no name=reset-pppoe-221119172541-AHMAD owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-221119172541-AHMAD>"
/system script add dont-require-permissions=no name=reset-pppoe-210902130133-ASEPDEDI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902130133-ASEPDEDI>"
/system script add dont-require-permissions=no name=reset-pppoe-230909151053-PUTRI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230909151053-PUTRI>"
/system script add dont-require-permissions=no name=reset-pppoe-220307114152-TOM owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-220307114152-TOM>"
/system script add dont-require-permissions=no name=reset-pppoe-221119172542-LENI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-221119172542-LENI>"
/system script add dont-require-permissions=no name=reset-pppoe-210901143749-ABANG owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210901143749-ABANG>"
/system script add dont-require-permissions=no name=reset-pppoe-210902123554-KURDI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902123554-KURDI>"
/system script add dont-require-permissions=no name=reset-pppoe-230613081728-YADI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230613081728-YADI>"
/system script add dont-require-permissions=no name=reset-pppoe-231008170937-SIFA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-231008170937-SIFA>"
/system script add dont-require-permissions=no name=reset-pppoe-210901143402-BUALDY owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210901143402-BUALDY>"
/system script add dont-require-permissions=no name=reset-pppoe-221119172548-SUHERMAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-221119172548-SUHERMAN>"
/system script add dont-require-permissions=no name=reset-pppoe-231008170938-ADIB owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-231008170938-ADIB>"
/system script add dont-require-permissions=no name=reset-pppoe-221228123326-AKUR owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-221228123326-AKUR>"
/system script add dont-require-permissions=no name=reset-pppoe-231009185222-LINA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-231009185222-LINA>"
/system script add dont-require-permissions=no name=reset-pppoe-230909151058-RIAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230909151058-RIAN>"
/system script add dont-require-permissions=no name=reset-pppoe-220315114250-EKA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-220315114250-EKA>"
/system script add dont-require-permissions=no name=reset-pppoe-230909151065-ADIBIL owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230909151065-ADIBIL>"
/system script add dont-require-permissions=no name=reset-pppoe-221119172547-WENDI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-221119172547-WENDI>"
/system script add dont-require-permissions=no name=reset-pppoe-210902164954-WINDA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902164954-WINDA>"
/system script add dont-require-permissions=no name=reset-pppoe-231009185223-RENDY owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-231009185223-RENDY>"
/system script add dont-require-permissions=no name=reset-pppoe-210902125942-TEBE owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902125942-TEBE>"
/system script add dont-require-permissions=no name=reset-pppoe-220810190846-SUKAENAH owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-220810190846-SUKAENAH>"
/system script add dont-require-permissions=no name=reset-pppoe-230114074216-FITRIYANI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230114074216-FITRIYANI>"
/system script add dont-require-permissions=no name=reset-pppoe-210902140131-ASEP owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902140131-ASEP>"
/system script add dont-require-permissions=no name=reset-pppoe-221119172545-IKA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-221119172545-IKA>"
/system script add dont-require-permissions=no name=reset-pppoe-230909151083-BAGUS owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230909151083-BAGUS>"
/system script add dont-require-permissions=no name=reset-pppoe-230114074230-HERY owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230114074230-HERY>"
/system script add dont-require-permissions=no name=reset-pppoe-231008170942-MENTARI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-231008170942-MENTARI>"
/system script add dont-require-permissions=no name=reset-pppoe-211209092917-CINDIANDANG owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-211209092917-CINDIANDANG>"
/system script add dont-require-permissions=no name=reset-pppoe-220726185926-NENDEN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-220726185926-NENDEN>"
/system script add dont-require-permissions=no name=reset-pppoe-210901114107-DEDI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210901114107-DEDI>"
/system script add dont-require-permissions=no name=reset-pppoe-230909151056-SUWITO owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230909151056-SUWITO>"
/system script add dont-require-permissions=no name=reset-pppoe-210901203608-ELIS owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210901203608-ELIS>"
/system script add dont-require-permissions=no name=reset-pppoe-230615172244-SRI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230615172244-SRI>"
/system script add dont-require-permissions=no name=reset-pppoe-230909151080-EBIH owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230909151080-EBIH>"
/system script add dont-require-permissions=no name=reset-pppoe-230114074208-ADITYA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230114074208-ADITYA>"
/system script add dont-require-permissions=no name=reset-pppoe-230909151060-RENI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230909151060-RENI>"
/system script add dont-require-permissions=no name=reset-pppoe-210902161520-KEMAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902161520-KEMAN>"
/system script add dont-require-permissions=no name=reset-pppoe-230909151059-IMAS owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230909151059-IMAS>"
/system script add dont-require-permissions=no name=reset-pppoe-210902162958-HANIPAH owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902162958-HANIPAH>"
/system script add dont-require-permissions=no name=reset-pppoe-230909151077-RESTIWI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230909151077-RESTIWI>"
/system script add dont-require-permissions=no name=reset-pppoe-210901143046-SENDUL owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210901143046-SENDUL>"
/system script add dont-require-permissions=no name=reset-pppoe-220512104255-IRPAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-220512104255-IRPAN>"
/system script add dont-require-permissions=no name=reset-pppoe-231008170931-RIFKI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-231008170931-RIFKI>"
/system script add dont-require-permissions=no name=reset-pppoe-230114074222-RESTI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230114074222-RESTI>"
/system script add dont-require-permissions=no name=reset-pppoe-230102125719-IMAT owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230102125719-IMAT>"
/system script add dont-require-permissions=no name=reset-pppoe-210901203309-FERY owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210901203309-FERY>"
/system script add dont-require-permissions=no name=reset-pppoe-230909151069-ERIK owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230909151069-ERIK>"
/system script add dont-require-permissions=no name=reset-pppoe-210902123948-IIN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902123948-IIN>"
/system script add dont-require-permissions=no name=reset-pppoe-210901120736-ALYA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210901120736-ALYA>"
/system script add dont-require-permissions=no name=reset-pppoe-230909151074-HERMAWAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230909151074-HERMAWAN>"
/system script add dont-require-permissions=no name=reset-pppoe-230114074227-WIWI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230114074227-WIWI>"
/system script add dont-require-permissions=no name=reset-pppoe-240315141544-DEDEN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240315141544-DEDEN>"
/system script add dont-require-permissions=no name=reset-pppoe-210902165641-RIDWAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902165641-RIDWAN>"
/system script add dont-require-permissions=no name=reset-pppoe-230114074214-IROB owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230114074214-IROB>"
/system script add dont-require-permissions=no name=reset-pppoe-221126120614-OCANG owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-221126120614-OCANG>"
/system script add dont-require-permissions=no name=reset-pppoe-230909151055-CACAH owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230909151055-CACAH>"
/system script add dont-require-permissions=no name=reset-pppoe-230114074213-CAHYANA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230114074213-CAHYANA>"
/system script add dont-require-permissions=no name=reset-pppoe-211222184753-YAYAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-211222184753-YAYAN>"
/system script add dont-require-permissions=no name=reset-pppoe-231008170943-VIQRI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-231008170943-VIQRI>"
/system script add dont-require-permissions=no name=reset-pppoe-230909151066-AEP owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230909151066-AEP>"
/system script add dont-require-permissions=no name=reset-pppoe-220606150759-NIA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-220606150759-NIA>"
/system script add dont-require-permissions=no name=reset-pppoe-230909151063-RANTI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230909151063-RANTI>"
/system script add dont-require-permissions=no name=reset-pppoe-220604103729-ADAM owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-220604103729-ADAM>"
/system script add dont-require-permissions=no name=reset-pppoe-240315141545-VIKY owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240315141545-VIKY>"
/system script add dont-require-permissions=no name=reset-pppoe-210901120952-CINDI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210901120952-CINDI>"
/system script add dont-require-permissions=no name=reset-pppoe-230909151062-ASEP owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230909151062-ASEP>"
/system script add dont-require-permissions=no name=reset-pppoe-230909151052-UJANG owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230909151052-UJANG>"
/system script add dont-require-permissions=no name=reset-pppoe-210902135358-USIN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902135358-USIN>"
/system script add dont-require-permissions=no name=reset-pppoe-231209182072-SEFTIANY owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-231209182072-SEFTIANY>"
/system script add dont-require-permissions=no name=reset-pppoe-240315141546-GILANG owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240315141546-GILANG>"
/system script add dont-require-permissions=no name=reset-pppoe-210902170410-ELIN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902170410-ELIN>"
/system script add dont-require-permissions=no name=reset-pppoe-220412123320-DEWI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-220412123320-DEWI>"
/system script add dont-require-permissions=no name=reset-pppoe-220322140756-INOY owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-220322140756-INOY>"
/system script add dont-require-permissions=no name=reset-pppoe-HENDRA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-HENDRA>"
/system script add dont-require-permissions=no name=reset-pppoe-210902135124-ATEN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902135124-ATEN>"
/system script add dont-require-permissions=no name=reset-pppoe-210902161308-DAENG owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902161308-DAENG>"
/system script add dont-require-permissions=no name=reset-pppoe-230909151057-DALIT owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230909151057-DALIT>"
/system script add dont-require-permissions=no name=reset-pppoe-210915173502-RIRI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210915173502-RIRI>"
/system script add dont-require-permissions=no name=reset-pppoe-230909151085-REYNALDI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230909151085-REYNALDI>"
/system script add dont-require-permissions=no name=reset-pppoe-230909151086-MARLIAWATI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230909151086-MARLIAWATI>"
/system script add dont-require-permissions=no name=reset-pppoe-220720164405-SULASTRI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-220720164405-SULASTRI>"
/system script add dont-require-permissions=no name=reset-pppoe-240315141547-RAHMAT owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240315141547-RAHMAT>"
/system script add dont-require-permissions=no name=reset-pppoe-230909151087-HANI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230909151087-HANI>"
/system script add dont-require-permissions=no name=reset-pppoe-230909151088-EPIN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230909151088-EPIN>"
/system script add dont-require-permissions=no name=reset-pppoe-230909151089-ENTIN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230909151089-ENTIN>"
/system script add dont-require-permissions=no name=reset-pppoe-230613081738-UYAT owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230613081738-UYAT>"
/system script add dont-require-permissions=no name=reset-pppoe-230613081739-GUGUN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230613081739-GUGUN>"
/system script add dont-require-permissions=no name=reset-pppoe-230613081740-DUDIT owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230613081740-DUDIT>"
/system script add dont-require-permissions=no name=reset-pppoe-230114190808-SIDIK owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230114190808-SIDIK>"
/system script add dont-require-permissions=no name=reset-pppoe-231009185225-DADANG owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-231009185225-DADANG>"
/system script add dont-require-permissions=no name=reset-pppoe-YOFI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-YOFI>"
/system script add dont-require-permissions=no name=reset-pppoe-231008170944-SOLIHIN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-231008170944-SOLIHIN>"
/system script add dont-require-permissions=no name=reset-pppoe-230909151091-ANI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230909151091-ANI>"
/system script add dont-require-permissions=no name=reset-pppoe-9900001-LUTHFI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-9900001-LUTHFI>"
/system script add dont-require-permissions=no name=reset-pppoe-230126060439-RUDI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230126060439-RUDI>"
/system script add dont-require-permissions=no name=reset-pppoe-240315141548-INDRI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240315141548-INDRI>"
/system script add dont-require-permissions=no name=reset-pppoe-230909151092-IMASWATI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230909151092-IMASWATI>"
/system script add dont-require-permissions=no name=reset-pppoe-231008170945-MURNI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-231008170945-MURNI>"
/system script add dont-require-permissions=no name=reset-pppoe-230909151093-SOPAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230909151093-SOPAN>"
/system script add dont-require-permissions=no name=reset-pppoe-240315141549-VIDI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240315141549-VIDI>"
/system script add dont-require-permissions=no name=reset-pppoe-230909151094-RIKA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230909151094-RIKA>"
/system script add dont-require-permissions=no name=reset-pppoe-230909151095-IPAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230909151095-IPAN>"
/system script add dont-require-permissions=no name=reset-pppoe-11200002-ISUR owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-11200002-ISUR>"
/system script add dont-require-permissions=no name=reset-pppoe-230126060440-IIS owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230126060440-IIS>"
/system script add dont-require-permissions=no name=reset-pppoe-220309142259-JUWITA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-220309142259-JUWITA>"
/system script add dont-require-permissions=no name=reset-pppoe-230613081741-DEDI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230613081741-DEDI>"
/system script add dont-require-permissions=no name=reset-pppoe-221212152521-IMAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-221212152521-IMAN>"
/system script add dont-require-permissions=no name=reset-pppoe-240504175810-DIKI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240504175810-DIKI>"
/system script add dont-require-permissions=no name=reset-pppoe-240315141550-JAJANG owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240315141550-JAJANG>"
/system script add dont-require-permissions=no name=reset-pppoe-220107190811-ILHAM owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-220107190811-ILHAM>"
/system script add dont-require-permissions=no name=reset-pppoe-220309142260-INDRI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-220309142260-INDRI>"
/system script add dont-require-permissions=no name=reset-pppoe-240315141551-KANIA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240315141551-KANIA>"
/system script add dont-require-permissions=no name=reset-pppoe-240315141552-AYAT owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240315141552-AYAT>"
/system script add dont-require-permissions=no name=reset-pppoe-230909151096-MIA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230909151096-MIA>"
/system script add dont-require-permissions=no name=reset-pppoe-240315141553-SUMARNA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240315141553-SUMARNA>"
/system script add dont-require-permissions=no name=reset-pppoe-231009185226-RICKY owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-231009185226-RICKY>"
/system script add dont-require-permissions=no name=reset-pppoe-221212153130-SONA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-221212153130-SONA>"
/system script add dont-require-permissions=no name=reset-pppoe-220203105928-AGUNG owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-220203105928-AGUNG>"
/system script add dont-require-permissions=no name=reset-pppoe-230311155640-DIDIN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230311155640-DIDIN>"
/system script add dont-require-permissions=no name=reset-pppoe-240315141554-ITA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240315141554-ITA>"
/system script add dont-require-permissions=no name=reset-pppoe-221101132931-DADI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-221101132931-DADI>"
/system script add dont-require-permissions=no name=reset-pppoe-230126060441-ERVAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230126060441-ERVAN>"
/system script add dont-require-permissions=no name=reset-pppoe-230613081742-SUDRAJAT owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230613081742-SUDRAJAT>"
/system script add dont-require-permissions=no name=reset-pppoe-240315141555-IIN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240315141555-IIN>"
/system script add dont-require-permissions=no name=reset-pppoe-230126060442-RACHMAD owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230126060442-RACHMAD>"
/system script add dont-require-permissions=no name=reset-pppoe-230613081743-AGUS owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230613081743-AGUS>"
/system script add dont-require-permissions=no name=reset-pppoe-230613081744-AANG owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230613081744-AANG>"
/system script add dont-require-permissions=no name=reset-pppoe-230613081745-SEPTIAWAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230613081745-SEPTIAWAN>"
/system script add dont-require-permissions=no name=reset-pppoe-230613081746-IYUS owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230613081746-IYUS>"
/system script add dont-require-permissions=no name=reset-pppoe-240315141556-PINA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240315141556-PINA>"
/system script add dont-require-permissions=no name=reset-pppoe-230909151067-ADE owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230909151067-ADE>"
/system script add dont-require-permissions=no name=reset-pppoe-220109202027-DIKI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-220109202027-DIKI>"
/system script add dont-require-permissions=no name=reset-pppoe-211209092759-LENI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-211209092759-LENI>"
/system script add dont-require-permissions=no name=reset-pppoe-220709164810-TIA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-220709164810-TIA>"
/system script add dont-require-permissions=no name=reset-pppoe-220317135834-OKTAVIANI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-220317135834-OKTAVIANI>"
/system script add dont-require-permissions=no name=reset-pppoe-210902170808-DECKY owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902170808-DECKY>"
/system script add dont-require-permissions=no name=reset-pppoe-230613081747-YAYAT owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230613081747-YAYAT>"
/system script add dont-require-permissions=no name=reset-pppoe-211202114506-ANIS owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-211202114506-ANIS>"
/system script add dont-require-permissions=no name=reset-pppoe-220404134237-SITI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-220404134237-SITI>"
/system script add dont-require-permissions=no name=reset-pppoe-230907102222-YUSUFA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230907102222-YUSUFA>"
/system script add dont-require-permissions=no name=reset-pppoe-210902165444-SELAMET owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902165444-SELAMET>"
/system script add dont-require-permissions=no name=reset-pppoe-230114074218-SARIAH owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230114074218-SARIAH>"
/system script add dont-require-permissions=no name=reset-pppoe-240315141557-RIAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240315141557-RIAN>"
/system script add dont-require-permissions=no name=reset-pppoe-230613081748-PERA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230613081748-PERA>"
/system script add dont-require-permissions=no name=reset-pppoe-240315141558-SITI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240315141558-SITI>"
/system script add dont-require-permissions=no name=reset-pppoe-SAHMAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-SAHMAN>"
/system script add dont-require-permissions=no name=reset-pppoe-230613081749-FITRI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230613081749-FITRI>"
/system script add dont-require-permissions=no name=reset-pppoe-230613081750-SIDIK owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230613081750-SIDIK>"
/system script add dont-require-permissions=no name=reset-pppoe-240315141559-ARNI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240315141559-ARNI>"
/system script add dont-require-permissions=no name=reset-pppoe-210927114345-RISMA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210927114345-RISMA>"
/system script add dont-require-permissions=no name=reset-pppoe-240315141560-AI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240315141560-AI>"
/system script add dont-require-permissions=no name=reset-pppoe-230613081751-SITI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230613081751-SITI>"
/system script add dont-require-permissions=no name=reset-pppoe-230613081752-SUNANDAR owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230613081752-SUNANDAR>"
/system script add dont-require-permissions=no name=reset-pppoe-230909151097-HERI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230909151097-HERI>"
/system script add dont-require-permissions=no name=reset-pppoe-230613081753-WAHYUDIN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230613081753-WAHYUDIN>"
/system script add dont-require-permissions=no name=reset-pppoe-240315141561-EDDY owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240315141561-EDDY>"
/system script add dont-require-permissions=no name=reset-pppoe-230613081754-NENDEN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230613081754-NENDEN>"
/system script add dont-require-permissions=no name=reset-pppoe-230909151098-ENCAR owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230909151098-ENCAR>"
/system script add dont-require-permissions=no name=reset-pppoe-221109122214-ALISKA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-221109122214-ALISKA>"
/system script add dont-require-permissions=no name=reset-pppoe-240315141562-SARDAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240315141562-SARDAN>"
/system script add dont-require-permissions=no name=reset-pppoe-230126060443-WIWIN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230126060443-WIWIN>"
/system script add dont-require-permissions=no name=reset-pppoe-240315141563-ASEP owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240315141563-ASEP>"
/system script add dont-require-permissions=no name=reset-pppoe-230126060444-MUTHIYA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230126060444-MUTHIYA>"
/system script add dont-require-permissions=no name=reset-pppoe-230909151099-RUSLI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230909151099-RUSLI>"
/system script add dont-require-permissions=no name=reset-pppoe-240315141564-GUGUN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240315141564-GUGUN>"
/system script add dont-require-permissions=no name=reset-pppoe-230126060445-AGUS owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230126060445-AGUS>"
/system script add dont-require-permissions=no name=reset-pppoe-230613081755-UJANG owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230613081755-UJANG>"
/system script add dont-require-permissions=no name=reset-pppoe-230909151100-IRVAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230909151100-IRVAN>"
/system script add dont-require-permissions=no name=reset-pppoe-240315141565-NINA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240315141565-NINA>"
/system script add dont-require-permissions=no name=reset-pppoe-210902134550-IPIN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902134550-IPIN>"
/system script add dont-require-permissions=no name=reset-pppoe-230613081757-EULIS owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230613081757-EULIS>"
/system script add dont-require-permissions=no name=reset-pppoe-230909151101-NANDANG owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230909151101-NANDANG>"
/system script add dont-require-permissions=no name=reset-pppoe-240315141568-FITRIYA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240315141568-FITRIYA>"
/system script add dont-require-permissions=no name=reset-pppoe-230613081758-SITI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230613081758-SITI>"
/system script add dont-require-permissions=no name=reset-pppoe-221109135358-ADELIA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-221109135358-ADELIA>"
/system script add dont-require-permissions=no name=reset-pppoe-230613081760-WIDARYANTO owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230613081760-WIDARYANTO>"
/system script add dont-require-permissions=no name=reset-pppoe-221119172549-PURI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-221119172549-PURI>"
/system script add dont-require-permissions=no name=reset-pppoe-240315141566-MUTIARA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240315141566-MUTIARA>"
/system script add dont-require-permissions=no name=reset-pppoe-230613081759-ASEP owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230613081759-ASEP>"
/system script add dont-require-permissions=no name=reset-pppoe-240315141567-PAJAR owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240315141567-PAJAR>"
/system script add dont-require-permissions=no name=reset-pppoe-240315141569-JUJU owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240315141569-JUJU>"
/system script add dont-require-permissions=no name=reset-pppoe-241006135944-FIRMAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-241006135944-FIRMAN>"
/system script add dont-require-permissions=no name=reset-pppoe-240315141570-DANA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240315141570-DANA>"
/system script add dont-require-permissions=no name=reset-pppoe-240315141571-ADE owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240315141571-ADE>"
/system script add dont-require-permissions=no name=reset-pppoe-230613081761-HENDRA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230613081761-HENDRA>"
/system script add dont-require-permissions=no name=reset-pppoe-220808121224-ANTON owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-220808121224-ANTON>"
/system script add dont-require-permissions=no name=reset-pppoe-230114074215-SITI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230114074215-SITI>"
/system script add dont-require-permissions=no name=reset-pppoe-230909151064-VINA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230909151064-VINA>"
/system script add dont-require-permissions=no name=reset-pppoe-230909151068-NUR owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230909151068-NUR>"
/system script add dont-require-permissions=no name=reset-pppoe-240315141572-YENI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240315141572-YENI>"
/system script add dont-require-permissions=no name=reset-pppoe-210902123711-EMAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902123711-EMAN>"
/system script add dont-require-permissions=no name=reset-pppoe-210902135207-ARIS owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902135207-ARIS>"
/system script add dont-require-permissions=no name=reset-pppoe-210902140040-TONI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902140040-TONI>"
/system script add dont-require-permissions=no name=reset-pppoe-210902132104-ARFAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902132104-ARFAN>"
/system script add dont-require-permissions=no name=reset-pppoe-240315141573-ELIS owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240315141573-ELIS>"
/system script add dont-require-permissions=no name=reset-pppoe-241006135945-MIANETA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-241006135945-MIANETA>"
/system script add dont-require-permissions=no name=reset-pppoe-221112092334-NENI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-221112092334-NENI>"
/system script add dont-require-permissions=no name=reset-pppoe-210902124742-RONI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902124742-RONI>"
/system script add dont-require-permissions=no name=reset-pppoe-210902135913-SADELI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902135913-SADELI>"
/system script add dont-require-permissions=no name=reset-pppoe-220510100316-YUDI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-220510100316-YUDI>"
/system script add dont-require-permissions=no name=reset-pppoe-210902135747-YUDA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902135747-YUDA>"
/system script add dont-require-permissions=no name=reset-pppoe-211202112632-HANI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-211202112632-HANI>"
/system script add dont-require-permissions=no name=reset-pppoe-221217135004-SELI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-221217135004-SELI>"
/system script add dont-require-permissions=no name=reset-pppoe-220315160317-ABIN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-220315160317-ABIN>"
/system script add dont-require-permissions=no name=reset-pppoe-230909151047-RULLY owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230909151047-RULLY>"
/system script add dont-require-permissions=no name=reset-pppoe-211106085026-TATANG owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-211106085026-TATANG>"
/system script add dont-require-permissions=no name=reset-pppoe-220108081811-ANDA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-220108081811-ANDA>"
/system script add dont-require-permissions=no name=reset-pppoe-210901121109-WIDI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210901121109-WIDI>"
/system script add dont-require-permissions=no name=reset-pppoe-10300001-RIAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-10300001-RIAN>"
/system script add dont-require-permissions=no name=reset-pppoe-11100001-IIS owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-11100001-IIS>"
/system script add dont-require-permissions=no name=reset-pppoe-220108112546-SUSI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-220108112546-SUSI>"
/system script add dont-require-permissions=no name=reset-pppoe-220108101310-AGUS owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-220108101310-AGUS>"
/system script add dont-require-permissions=no name=reset-pppoe-210902195917-EMAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902195917-EMAN>"
/system script add dont-require-permissions=no name=reset-pppoe-230613081756-KANKAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230613081756-KANKAN>"
/system script add dont-require-permissions=no name=reset-pppoe-210901144241-HENDRA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210901144241-HENDRA>"
/system script add dont-require-permissions=no name=reset-pppoe-10300077-SEPHIA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-10300077-SEPHIA>"
/system script add dont-require-permissions=no name=reset-pppoe-10300078-EKA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-10300078-EKA>"
/system script add dont-require-permissions=no name=reset-pppoe-210902195330-DYAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902195330-DYAN>"
/system script add dont-require-permissions=no name=reset-pppoe-210902193918-ISTANA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902193918-ISTANA>"
/system script add dont-require-permissions=no name=reset-pppoe-220110164540-SUDRAJAT owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-220110164540-SUDRAJAT>"
/system script add dont-require-permissions=no name=reset-pppoe-220402104649-SITIAMINAH owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-220402104649-SITIAMINAH>"
/system script add dont-require-permissions=no name=reset-pppoe-230615172246-EUISLUMAYA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230615172246-EUISLUMAYA>"
/system script add dont-require-permissions=no name=reset-pppoe-230613081733-NINA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230613081733-NINA>"
/system script add dont-require-permissions=no name=reset-pppoe-210902195807-HENDRA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902195807-HENDRA>"
/system script add dont-require-permissions=no name=reset-pppoe-230104175459-ETIYULIANTI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230104175459-ETIYULIANTI>"
/system script add dont-require-permissions=no name=reset-pppoe-230104175460-SITIMASITOH owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230104175460-SITIMASITOH>"
/system script add dont-require-permissions=no name=reset-pppoe-230104175462-IMAMRAHMAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230104175462-IMAMRAHMAN>"
/system script add dont-require-permissions=no name=reset-pppoe-230613081732-NETI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230613081732-NETI>"
/system script add dont-require-permissions=no name=reset-pppoe-230104175463-FIKI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230104175463-FIKI>"
/system script add dont-require-permissions=no name=reset-pppoe-230613081730-RENALDI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230613081730-RENALDI>"
/system script add dont-require-permissions=no name=reset-pppoe-210902195622-BAGAS owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902195622-BAGAS>"
/system script add dont-require-permissions=no name=reset-pppoe-11200003-IWAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-11200003-IWAN>"
/system script add dont-require-permissions=no name=reset-pppoe-230613081726-DIANA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230613081726-DIANA>"
/system script add dont-require-permissions=no name=reset-pppoe-221016145225-IING owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-221016145225-IING>"
/system script add dont-require-permissions=no name=reset-pppoe-210902195553-TOTO owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902195553-TOTO>"
/system script add dont-require-permissions=no name=reset-pppoe-221016171724-IPA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-221016171724-IPA>"
/system script add dont-require-permissions=no name=reset-pppoe-230613081723-EULISYANI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230613081723-EULISYANI>"
/system script add dont-require-permissions=no name=reset-pppoe-211005123816-FATIMAH owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-211005123816-FATIMAH>"
/system script add dont-require-permissions=no name=reset-pppoe-220910200413-WIDANINGSIH owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-220910200413-WIDANINGSIH>"
/system script add dont-require-permissions=no name=reset-pppoe-230615172245-DEWIUTARI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230615172245-DEWIUTARI>"
/system script add dont-require-permissions=no name=reset-pppoe-210902195716-DUDI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902195716-DUDI>"
/system script add dont-require-permissions=no name=reset-pppoe-230613081724-FERI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230613081724-FERI>"
/system script add dont-require-permissions=no name=reset-pppoe-RUMAH owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-RUMAH>"
/system script add dont-require-permissions=no name=reset-pppoe-210902194811-EFI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902194811-EFI>"
/system script add dont-require-permissions=no name=reset-pppoe-220309142257-RUDI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-220309142257-RUDI>"
/system script add dont-require-permissions=no name=reset-pppoe-220309142258-DAMAR owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-220309142258-DAMAR>"
/system script add dont-require-permissions=no name=reset-pppoe-210902194358-IWAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902194358-IWAN>"
/system script add dont-require-permissions=no name=reset-pppoe-211201182657-NOVI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-211201182657-NOVI>"
/system script add dont-require-permissions=no name=reset-pppoe-210902194958-DENI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902194958-DENI>"
/system script add dont-require-permissions=no name=reset-pppoe-210902194446-IMAM owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902194446-IMAM>"
/system script add dont-require-permissions=no name=reset-pppoe-220309142262-ABING owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-220309142262-ABING>"
/system script add dont-require-permissions=no name=reset-pppoe-220309142261-YATNA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-220309142261-YATNA>"
/system script add dont-require-permissions=no name=reset-pppoe-211125155525-LIA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-211125155525-LIA>"
/system script add dont-require-permissions=no name=reset-pppoe-210902195422-SILVY owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902195422-SILVY>"
/system script add dont-require-permissions=no name=reset-pppoe-210902194311-IMAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902194311-IMAN>"
/system script add dont-require-permissions=no name=reset-pppoe-10200001-TITA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-10200001-TITA>"
/system script add dont-require-permissions=no name=reset-pppoe-10400001-SITI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-10400001-SITI>"
/system script add dont-require-permissions=no name=reset-pppoe-10300079-RIDWAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-10300079-RIDWAN>"
/system script add dont-require-permissions=no name=reset-pppoe-10300080-YANTI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-10300080-YANTI>"
/system script add dont-require-permissions=no name=reset-pppoe-10300081-NADIA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-10300081-NADIA>"
/system script add dont-require-permissions=no name=reset-pppoe-10300082-ECEP owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-10300082-ECEP>"
/system script add dont-require-permissions=no name=reset-pppoe-10300083-LIA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-10300083-LIA>"
/system script add dont-require-permissions=no name=reset-pppoe-10100001-AGUNG owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-10100001-AGUNG>"
/system script add dont-require-permissions=no name=reset-pppoe-10100197-YANA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-10100197-YANA>"
/system script add dont-require-permissions=no name=reset-pppoe-10100198-YOPI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-10100198-YOPI>"
/system script add dont-require-permissions=no name=reset-pppoe-10200107-RESTI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-10200107-RESTI>"
/system script add dont-require-permissions=no name=reset-pppoe-10200108-NENI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-10200108-NENI>"
/system script add dont-require-permissions=no name=reset-pppoe-11100108-ABDIKA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-11100108-ABDIKA>"
/system script add dont-require-permissions=no name=reset-pppoe-10100199-RIADI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-10100199-RIADI>"
/system script add dont-require-permissions=no name=reset-pppoe-10500001-SUTISNA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-10500001-SUTISNA>"
/system script add dont-require-permissions=no name=reset-pppoe-101000001-TOMI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-101000001-TOMI>"
/system script add dont-require-permissions=no name=reset-pppoe-230613081748-PERARATNA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230613081748-PERARATNA>"
/system script add dont-require-permissions=no name=reset-pppoe-241109132115-LILIK owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-241109132115-LILIK>"
/system script add dont-require-permissions=no name=reset-pppoe-220715102353-RICKI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-220715102353-RICKI>"
/system script add dont-require-permissions=no name=reset-pppoe-220715102356-ALDI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-220715102356-ALDI>"
/system script add dont-require-permissions=no name=reset-pppoe-230613081724-FERIMAULANA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230613081724-FERIMAULANA>"
/system script add dont-require-permissions=no name=reset-pppoe-220715102355-AWALUDIN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-220715102355-AWALUDIN>"
/system script add dont-require-permissions=no name=reset-pppoe-10200109-DEA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-10200109-DEA>"
/system script add dont-require-permissions=no name=reset-pppoe-210902163107-MAMAHIIP owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902163107-MAMAHIIP>"
/system script add dont-require-permissions=no name=reset-pppoe-241203121051-REVANA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-241203121051-REVANA>"
/system script add dont-require-permissions=no name=reset-pppoe-241205150940-FITRIANA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-241205150940-FITRIANA>"
/system script add dont-require-permissions=no name=reset-pppoe-241206161113-MIASEPTIANI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-241206161113-MIASEPTIANI>"
/system script add dont-require-permissions=no name=reset-pppoe-241213145556-NOER owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-241213145556-NOER>"
/system script add dont-require-permissions=no name=reset-pppoe-241213155647-SAADAH owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-241213155647-SAADAH>"
/system script add dont-require-permissions=no name=reset-pppoe-241213180117-LERRY owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-241213180117-LERRY>"
/system script add dont-require-permissions=no name=reset-pppoe-241213191106-NOVIARYANTI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-241213191106-NOVIARYANTI>"
/system script add dont-require-permissions=no name=reset-pppoe-241214105706-ULAYYA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-241214105706-ULAYYA>"
/system script add dont-require-permissions=no name=reset-pppoe-210902163716-INTAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902163716-INTAN>"
/system script add dont-require-permissions=no name=reset-pppoe-241216110713-ENDI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-241216110713-ENDI>"
/system script add dont-require-permissions=no name=reset-pppoe-241218114812-ASEPSOPANDI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-241218114812-ASEPSOPANDI>"
/system script add dont-require-permissions=no name=reset-pppoe-241218133449-MARIAM owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-241218133449-MARIAM>"
/system script add dont-require-permissions=no name=reset-pppoe-241219114432-DAUS owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-241219114432-DAUS>"
/system script add dont-require-permissions=no name=reset-pppoe-220715102354-AJI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-220715102354-AJI>"
/system script add dont-require-permissions=no name=reset-pppoe-241225104811-CACA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-241225104811-CACA>"
/system script add dont-require-permissions=no name=reset-pppoe-210902194604-KEMBAR owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902194604-KEMBAR>"
/system script add dont-require-permissions=no name=reset-pppoe-210902195251-YANTI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902195251-YANTI>"
/system script add dont-require-permissions=no name=reset-pppoe-210902135936-SUGEUNG owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902135936-SUGEUNG>"
/system script add dont-require-permissions=no name=reset-pppoe-220109070515-TAUFIK owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-220109070515-TAUFIK>"
/system script add dont-require-permissions=no name=reset-pppoe-210902125337-TATA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902125337-TATA>"
/system script add dont-require-permissions=no name=reset-pppoe-211002153847-SARIPUDIN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-211002153847-SARIPUDIN>"
/system script add dont-require-permissions=no name=reset-pppoe-211210102802-ASEP owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-211210102802-ASEP>"
/system script add dont-require-permissions=no name=reset-pppoe-221119172551-RISA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-221119172551-RISA>"
/system script add dont-require-permissions=no name=reset-pppoe-210902162706-ADANG owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902162706-ADANG>"
/system script add dont-require-permissions=no name=reset-pppoe-230114074217-NONO owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230114074217-NONO>"
/system script add dont-require-permissions=no name=reset-pppoe-211225102400-ROHMAT owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-211225102400-ROHMAT>"
/system script add dont-require-permissions=no name=reset-pppoe-221228123323-WIDIA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-221228123323-WIDIA>"
/system script add dont-require-permissions=no name=reset-pppoe-210902134124-AYU owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902134124-AYU>"
/system script add dont-require-permissions=no name=reset-pppoe-210902132834-TOAH owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902132834-TOAH>"
/system script add dont-require-permissions=no name=reset-pppoe-221217133904-RACHMAT owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-221217133904-RACHMAT>"
/system script add dont-require-permissions=no name=reset-pppoe-210902124310-IYEP owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902124310-IYEP>"
/system script add dont-require-permissions=no name=reset-pppoe-250103142605-AYUSHINTA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250103142605-AYUSHINTA>"
/system script add dont-require-permissions=no name=reset-pppoe-250105143745-ISMAIL owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250105143745-ISMAIL>"
/system script add dont-require-permissions=no name=reset-pppoe-230114074220-ASEP owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230114074220-ASEP>"
/system script add dont-require-permissions=no name=reset-pppoe-220417143556-ANI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-220417143556-ANI>"
/system script add dont-require-permissions=no name=reset-pppoe-210901144114-ENDA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210901144114-ENDA>"
/system script add dont-require-permissions=no name=reset-pppoe-210901144009-HASAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210901144009-HASAN>"
/system script add dont-require-permissions=no name=reset-pppoe-210902135508-YOGA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902135508-YOGA>"
/system script add dont-require-permissions=no name=reset-pppoe-210902125836-NAUFAL owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902125836-NAUFAL>"
/system script add dont-require-permissions=no name=reset-pppoe-220620140633-ENDANG owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-220620140633-ENDANG>"
/system script add dont-require-permissions=no name=reset-pppoe-230906111355-EFA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230906111355-EFA>"
/system script add dont-require-permissions=no name=reset-pppoe-210902193817-ROSA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902193817-ROSA>"
/system script add dont-require-permissions=no name=reset-pppoe-220607160905-SEPTI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-220607160905-SEPTI>"
/system script add dont-require-permissions=no name=reset-pppoe-250111090317-TUTI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250111090317-TUTI>"
/system script add dont-require-permissions=no name=reset-pppoe-230304191412-AEP owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230304191412-AEP>"
/system script add dont-require-permissions=no name=reset-pppoe-250120095543-LINA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250120095543-LINA>"
/system script add dont-require-permissions=no name=reset-pppoe-250201113106-OMIH owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250201113106-OMIH>"
/system script add dont-require-permissions=no name=reset-pppoe-250202152946-GUGUM owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250202152946-GUGUM>"
/system script add dont-require-permissions=no name=reset-pppoe-250207112615-YAYANG owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250207112615-YAYANG>"
/system script add dont-require-permissions=no name=reset-pppoe-10100198-YOPIHIDAYAT owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-10100198-YOPIHIDAYAT>"
/system script add dont-require-permissions=no name=reset-pppoe-250212093026-SUNAEDI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250212093026-SUNAEDI>"
/system script add dont-require-permissions=no name=reset-pppoe-250215140432-ASEP owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250215140432-ASEP>"
/system script add dont-require-permissions=no name=reset-pppoe-250221163051-MIASITI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250221163051-MIASITI>"
/system script add dont-require-permissions=no name=reset-pppoe-250222093240-EUISSITI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250222093240-EUISSITI>"
/system script add dont-require-permissions=no name=reset-pppoe-250222104603-VINAJULI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250222104603-VINAJULI>"
/system script add dont-require-permissions=no name=reset-pppoe-210902200033-BUDIZOO owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902200033-BUDIZOO>"
/system script add dont-require-permissions=no name=reset-pppoe-211223071015-DEBI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-211223071015-DEBI>"
/system script add dont-require-permissions=no name=reset-pppoe-211109135251-FERA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-211109135251-FERA>"
/system script add dont-require-permissions=no name=reset-pppoe-230126060436-TATI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230126060436-TATI>"
/system script add dont-require-permissions=no name=reset-pppoe-211109135123-RIYAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-211109135123-RIYAN>"
/system script add dont-require-permissions=no name=reset-pppoe-230126060435-DESY owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230126060435-DESY>"
/system script add dont-require-permissions=no name=reset-pppoe-250223101518-ENENG owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250223101518-ENENG>"
/system script add dont-require-permissions=no name=reset-pppoe-250223101518-ENENGFITRI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250223101518-ENENGFITRI>"
/system script add dont-require-permissions=no name=reset-pppoe-250226183048-SITIKOM owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250226183048-SITIKOM>"
/system script add dont-require-permissions=no name=reset-pppoe-240315141558-SITISURYATI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240315141558-SITISURYATI>"
/system script add dont-require-permissions=no name=reset-pppoe-250228105742-PURNAMAALI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250228105742-PURNAMAALI>"
/system script add dont-require-permissions=no name=reset-pppoe-250228161959-SARI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250228161959-SARI>"
/system script add dont-require-permissions=no name=reset-pppoe-250302105822-ROBBY owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250302105822-ROBBY>"
/system script add dont-require-permissions=no name=reset-pppoe-250302114437-DINIFATIMAH owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250302114437-DINIFATIMAH>"
/system script add dont-require-permissions=no name=reset-pppoe-250302134218-CEPI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250302134218-CEPI>"
/system script add dont-require-permissions=no name=reset-pppoe-250303143516-TATIKARYATI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250303143516-TATIKARYATI>"
/system script add dont-require-permissions=no name=reset-pppoe-250303155354-ANENG owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250303155354-ANENG>"
/system script add dont-require-permissions=no name=reset-pppoe-250305104835-NURSULASTRI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250305104835-NURSULASTRI>"
/system script add dont-require-permissions=no name=reset-pppoe-250305141050-HARYANTO owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250305141050-HARYANTO>"
/system script add dont-require-permissions=no name=reset-pppoe-220717160400-NERI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-220717160400-NERI>"
/system script add dont-require-permissions=no name=reset-pppoe-211116183142-ANTONWINDANI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-211116183142-ANTONWINDANI>"
/system script add dont-require-permissions=no name=reset-pppoe-250310164048-MAHMURI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250310164048-MAHMURI>"
/system script add dont-require-permissions=no name=reset-pppoe-250311155850-PANDU owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250311155850-PANDU>"
/system script add dont-require-permissions=no name=reset-pppoe-250314150512-SINTA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250314150512-SINTA>"
/system script add dont-require-permissions=no name=reset-pppoe-250405124250-PEPI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250405124250-PEPI>"
/system script add dont-require-permissions=no name=reset-pppoe-250409132220-TIARA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250409132220-TIARA>"
/system script add dont-require-permissions=no name=reset-pppoe-250411104651-EVA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250411104651-EVA>"
/system script add dont-require-permissions=no name=reset-pppoe-250412104331-YAYATHIDAYAT owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250412104331-YAYATHIDAYAT>"
/system script add dont-require-permissions=no name=reset-pppoe-250412162047-RAFLI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250412162047-RAFLI>"
/system script add dont-require-permissions=no name=reset-pppoe-250416103529-ADANG owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250416103529-ADANG>"
/system script add dont-require-permissions=no name=reset-pppoe-250419103915-RIO owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250419103915-RIO>"
/system script add dont-require-permissions=no name=reset-pppoe-250419130956-FENI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250419130956-FENI>"
/system script add dont-require-permissions=no name=reset-pppoe-250422120606-RINA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250422120606-RINA>"
/system script add dont-require-permissions=no name=reset-pppoe-250425113021-NONOH owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250425113021-NONOH>"
/system script add dont-require-permissions=no name=reset-pppoe-250427130456-NENI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250427130456-NENI>"
/system script add dont-require-permissions=no name=reset-pppoe-250427121121-REKA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250427121121-REKA>"
/system script add dont-require-permissions=no name=reset-pppoe-250504122116-DEDIH owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250504122116-DEDIH>"
/system script add dont-require-permissions=no name=reset-pppoe-250507112153-VINI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250507112153-VINI>"
/system script add dont-require-permissions=no name=reset-pppoe-250509132105-SEPTIAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250509132105-SEPTIAN>"
/system script add dont-require-permissions=no name=reset-pppoe-210902163618-SANJAYA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902163618-SANJAYA>"
/system script add dont-require-permissions=no name=reset-pppoe-10200130-DEDENUR owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-10200130-DEDENUR>"
/system script add dont-require-permissions=no name=reset-pppoe-10200131-NUNUNG owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-10200131-NUNUNG>"
/system script add dont-require-permissions=no name=reset-pppoe-250526152352-IRPAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250526152352-IRPAN>"
/system script add dont-require-permissions=no name=reset-pppoe-10600001-DIANROHENDI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-10600001-DIANROHENDI>"
/system script add dont-require-permissions=no name=reset-pppoe-10600021-ELAH owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-10600021-ELAH>"
/system script add dont-require-permissions=no name=reset-pppoe-10100219-DEDENMARDANI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-10100219-DEDENMARDANI>"
/system script add dont-require-permissions=no name=reset-pppoe-250601173512-DINDA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250601173512-DINDA>"
/system script add dont-require-permissions=no name=reset-pppoe-250603112655-ALIT owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250603112655-ALIT>"
/system script add dont-require-permissions=no name=reset-pppoe-250605111505-ERNI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250605111505-ERNI>"
/system script add dont-require-permissions=no name=reset-pppoe-250612113506-ARIAZHAR owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250612113506-ARIAZHAR>"
/system script add dont-require-permissions=no name=reset-pppoe-250616112815-HERI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250616112815-HERI>"
/system script add dont-require-permissions=no name=reset-pppoe-250620100310-YATI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250620100310-YATI>"
/system script add dont-require-permissions=no name=reset-pppoe-250620151538-IMAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250620151538-IMAN>"
/system script add dont-require-permissions=no name=reset-pppoe-250622140735-WAWAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250622140735-WAWAN>"
/system script add dont-require-permissions=no name=reset-pppoe-250622163127-SAMSUL owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250622163127-SAMSUL>"
/system script add dont-require-permissions=no name=reset-pppoe-250626210230-ADI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250626210230-ADI>"
/system script add dont-require-permissions=no name=reset-pppoe-250701170714-WATI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250701170714-WATI>"
/system script add dont-require-permissions=no name=reset-pppoe-250704095837-NENI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250704095837-NENI>"
/system script add dont-require-permissions=no name=reset-pppoe-250704154020-SINTA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250704154020-SINTA>"
/system script add dont-require-permissions=no name=reset-pppoe-250710165213-MARTINA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250710165213-MARTINA>"
/system script add dont-require-permissions=no name=reset-pppoe-250717140138-MENAH owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250717140138-MENAH>"
/system script add dont-require-permissions=no name=reset-pppoe-250721095023-KUSTIWA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250721095023-KUSTIWA>"
/system script add dont-require-permissions=no name=reset-pppoe-250722174120-NANA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250722174120-NANA>"
/system script add dont-require-permissions=no name=reset-pppoe-250724204016-WINDA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250724204016-WINDA>"
/system script add dont-require-permissions=no name=reset-pppoe-250726103721-DEDEN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250726103721-DEDEN>"
/system script add dont-require-permissions=no name=reset-pppoe-250803143349-YOGA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250803143349-YOGA>"
/system script add dont-require-permissions=no name=reset-pppoe-250806154003-CEPI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250806154003-CEPI>"
/system script add dont-require-permissions=no name=reset-pppoe-250809135620-ERNI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250809135620-ERNI>"
/system script add dont-require-permissions=no name=reset-pppoe-250810145100-DEDEH owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250810145100-DEDEH>"
/system script add dont-require-permissions=no name=reset-pppoe-250824110757-NAUFAL owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250824110757-NAUFAL>"
/system script add dont-require-permissions=no name=reset-pppoe-250824110757-NAUFALRAIS owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250824110757-NAUFALRAIS>"
/system script add dont-require-permissions=no name=reset-pppoe-250831173811-YANYAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250831173811-YANYAN>"
/system script add dont-require-permissions=no name=reset-pppoe-250901095118-NANI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250901095118-NANI>"
/system script add dont-require-permissions=no name=reset-pppoe-250901115943-ANIE owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250901115943-ANIE>"
/system script add dont-require-permissions=no name=reset-pppoe-250902111545-QUATUL owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250902111545-QUATUL>"
/system script add dont-require-permissions=no name=reset-pppoe-250905173726-LUKMAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250905173726-LUKMAN>"
/system script add dont-require-permissions=no name=reset-pppoe-250906110628-ENENG owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250906110628-ENENG>"
/system script add dont-require-permissions=no name=reset-pppoe-250907163740-YUSEDIANA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250907163740-YUSEDIANA>"
/system script add dont-require-permissions=no name=reset-pppoe-250913143424-NURAHMAH owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250913143424-NURAHMAH>"
/system script add dont-require-permissions=no name=reset-pppoe-250919191420-PANGGUNG owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250919191420-PANGGUNG>"
/system script add dont-require-permissions=no name=reset-pppoe-250927175052-PANGGUNGBOSUR owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250927175052-PANGGUNGBOSUR>"
/system script add dont-require-permissions=no name=reset-pppoe-251001112727-LOUISE owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251001112727-LOUISE>"
/system script add dont-require-permissions=no name=reset-pppoe-251001131207-SRI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251001131207-SRI>"
/system script add dont-require-permissions=no name=reset-pppoe-251002122329-KUSMIARSIH owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251002122329-KUSMIARSIH>"
/system script add dont-require-permissions=no name=reset-pppoe-251007105218-EVA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251007105218-EVA>"
/system script add dont-require-permissions=no name=reset-pppoe-210902133555-ARTI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902133555-ARTI>"
/system script add dont-require-permissions=no name=reset-pppoe-251009185936-SONI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251009185936-SONI>"
/system script add dont-require-permissions=no name=reset-pppoe-251017172705-FUZI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251017172705-FUZI>"
/system script add dont-require-permissions=no name=reset-pppoe-251017172705-FUZINUR owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251017172705-FUZINUR>"
/system script add dont-require-permissions=no name=reset-pppoe-251019150445-SHOBUR owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251019150445-SHOBUR>"
/system script add dont-require-permissions=no name=reset-pppoe-251102102753-NIA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251102102753-NIA>"
/system script add dont-require-permissions=no name=reset-pppoe-251102151517-UJANGRAHMAT owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251102151517-UJANGRAHMAT>"
/system script add dont-require-permissions=no name=reset-pppoe-251103103741-WIDA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251103103741-WIDA>"
/system script add dont-require-permissions=no name=reset-pppoe-251103182737-YERI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251103182737-YERI>"
/system script add dont-require-permissions=no name=reset-pppoe-251104143339-FUJI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251104143339-FUJI>"
/system script add dont-require-permissions=no name=reset-pppoe-251104155759-KATINO owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251104155759-KATINO>"
/system script add dont-require-permissions=no name=reset-pppoe-251104132447-PIKRI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251104132447-PIKRI>"
/system script add dont-require-permissions=no name=reset-pppoe-251104195044-EULIS owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251104195044-EULIS>"
/system script add dont-require-permissions=no name=reset-pppoe-251105103714-TOTONG owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251105103714-TOTONG>"
/system script add dont-require-permissions=no name=reset-pppoe-251105121104-NENGDEDAH owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251105121104-NENGDEDAH>"
/system script add dont-require-permissions=no name=reset-pppoe-251105134532-PAIMIN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251105134532-PAIMIN>"
/system script add dont-require-permissions=no name=reset-pppoe-251105173702-SIGIT owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251105173702-SIGIT>"
/system script add dont-require-permissions=no name=reset-pppoe-251105172045-DIDIN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251105172045-DIDIN>"
/system script add dont-require-permissions=no name=reset-pppoe-251106100416-SITI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251106100416-SITI>"
/system script add dont-require-permissions=no name=reset-pppoe-251106143239-ASEPDEPY owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251106143239-ASEPDEPY>"
/system script add dont-require-permissions=no name=reset-pppoe-251107095310-YOYOH owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251107095310-YOYOH>"
/system script add dont-require-permissions=no name=reset-pppoe-251107145714-TISNA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251107145714-TISNA>"
/system script add dont-require-permissions=no name=reset-pppoe-251107173707-WINDA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251107173707-WINDA>"
/system script add dont-require-permissions=no name=reset-pppoe-251108161957-JIMI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251108161957-JIMI>"
/system script add dont-require-permissions=no name=reset-pppoe-251109114922-SITINURLAENI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251109114922-SITINURLAENI>"
/system script add dont-require-permissions=no name=reset-pppoe-251111115915-TASYA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251111115915-TASYA>"
/system script add dont-require-permissions=no name=reset-pppoe-210902170651-LERY owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-210902170651-LERY>"
/system script add dont-require-permissions=no name=reset-pppoe-251112091645-YUYUN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251112091645-YUYUN>"
/system script add dont-require-permissions=no name=reset-pppoe-251117160919-LILIS owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251117160919-LILIS>"
/system script add dont-require-permissions=no name=reset-pppoe-251124182744-WILI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251124182744-WILI>"
/system script add dont-require-permissions=no name=reset-pppoe-251125120936-WINIARTI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251125120936-WINIARTI>"
/system script add dont-require-permissions=no name=reset-pppoe-251129143806-EROS owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251129143806-EROS>"
/system script add dont-require-permissions=no name=reset-pppoe-251130130352-NOVI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251130130352-NOVI>"
/system script add dont-require-permissions=no name=reset-pppoe-251203113041-ELSANUR owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251203113041-ELSANUR>"
/system script add dont-require-permissions=no name=reset-pppoe-251204095426-RIFA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251204095426-RIFA>"
/system script add dont-require-permissions=no name=reset-pppoe-251204230928-DEDE owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251204230928-DEDE>"
/system script add dont-require-permissions=no name=reset-pppoe-251206145219-ROMITA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251206145219-ROMITA>"
/system script add dont-require-permissions=no name=reset-pppoe-251206162816-ATTAQWA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251206162816-ATTAQWA>"
/system script add dont-require-permissions=no name=reset-pppoe-240315141544-DEDENKUSNIDAR owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240315141544-DEDENKUSNIDAR>"
/system script add dont-require-permissions=no name=reset-pppoe-251208161616-LILIS owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251208161616-LILIS>"
/system script add dont-require-permissions=no name=reset-pppoe-251211100126-MIA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251211100126-MIA>"
/system script add dont-require-permissions=no name=reset-pppoe-251216113837-ULPAH owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251216113837-ULPAH>"
/system script add dont-require-permissions=no name=reset-pppoe-251218122553-RENITA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251218122553-RENITA>"
/system script add dont-require-permissions=no name=reset-pppoe-251218140931-DADAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251218140931-DADAN>"
/system script add dont-require-permissions=no name=reset-pppoe-251220163813-FIRMANSYAH owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251220163813-FIRMANSYAH>"
/system script add dont-require-permissions=no name=reset-pppoe-251225125255-WAHYUNI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251225125255-WAHYUNI>"
/system script add dont-require-permissions=no name=reset-pppoe-251228112206-DIMAS owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251228112206-DIMAS>"
/system script add dont-require-permissions=no name=reset-pppoe-251231113740-SANA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251231113740-SANA>"
/system script add dont-require-permissions=no name=reset-pppoe-260103122904-RIVALDI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260103122904-RIVALDI>"
/system script add dont-require-permissions=no name=update_pppoe_count owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\
    \n    :local active [/ppp active print count-only]\
    \n    /system note set note=\$active\
    \n"
/system script add dont-require-permissions=no name=reset-pppoe-260107165904-LATIFUDIN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260107165904-LATIFUDIN>"
/system script add dont-require-permissions=no name=reset-pppoe-260109112002-MUMAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260109112002-MUMAN>"
/system script add dont-require-permissions=no name=reset-pppoe-260109150622-ANIHENDRAYANI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260109150622-ANIHENDRAYANI>"
/system script add dont-require-permissions=no name=reset-pppoe-260113134055-HAIKAL owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260113134055-HAIKAL>"
/system script add dont-require-permissions=no name=reset-pppoe-260118103427-RINI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260118103427-RINI>"
/system script add dont-require-permissions=no name=reset-pppoe-260119114124-FITRIYANI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260119114124-FITRIYANI>"
/system script add dont-require-permissions=no name=reset-pppoe-260121134333-DIANHERDIANA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260121134333-DIANHERDIANA>"
/system script add dont-require-permissions=no name=reset-pppoe-251220163813-DINDIN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251220163813-DINDIN>"
/system script add dont-require-permissions=no name=reset-pppoe-260125133109-RINAMARIANA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260125133109-RINAMARIANA>"
/system script add dont-require-permissions=no name=reset-pppoe-260126203536-AEP owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260126203536-AEP>"
/system script add dont-require-permissions=no name=reset-pppoe-260127144410-DHIYA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260127144410-DHIYA>"
/system script add dont-require-permissions=no name=reset-pppoe-260129174645-SITIMARYANI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260129174645-SITIMARYANI>"
/system script add dont-require-permissions=no name=reset-pppoe-260131121150-RISYE owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260131121150-RISYE>"
/system script add dont-require-permissions=no name=reset-pppoe-260131165910-AGUNG owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260131165910-AGUNG>"
/system script add dont-require-permissions=no name=reset-pppoe-260201121349-RAMDA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260201121349-RAMDA>"
/system script add dont-require-permissions=no name=reset-pppoe-260201141350-WAWAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260201141350-WAWAN>"
/system script add dont-require-permissions=no name=reset-pppoe-260202114657-RAENIH owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260202114657-RAENIH>"
/system script add dont-require-permissions=no name=reset-pppoe-251103182737-YERIYERI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251103182737-YERIYERI>"
/system script add dont-require-permissions=no name=reset-pppoe-260206141227-NOVAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260206141227-NOVAN>"
/system script add dont-require-permissions=no name=reset-pppoe-260214094828-HENDI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260214094828-HENDI>"
/system script add dont-require-permissions=no name=reset-pppoe-260226172607-UJANG owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260226172607-UJANG>"
/system script add dont-require-permissions=no name=reset-pppoe-260227112325-SUDARSIH owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260227112325-SUDARSIH>"
/system script add dont-require-permissions=no name=reset-pppoe-260227135245-ACEP owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260227135245-ACEP>"
/system script add dont-require-permissions=no name=reset-pppoe-260227162520-ADEJUARIYAH owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260227162520-ADEJUARIYAH>"
/system script add dont-require-permissions=no name=reset-pppoe-260228105519-DEVA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260228105519-DEVA>"
/system script add dont-require-permissions=no name=reset-pppoe-260228123401-SETIAWAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260228123401-SETIAWAN>"
/system script add dont-require-permissions=no name=reset-pppoe-260302144821-LALA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260302144821-LALA>"
/system script add dont-require-permissions=no name=reset-pppoe-260303155159-INDRA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260303155159-INDRA>"
/system script add dont-require-permissions=no name=reset-pppoe-260304162648-TAUFIK owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260304162648-TAUFIK>"
/system script add dont-require-permissions=no name=reset-pppoe-260312105131-KOKO owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260312105131-KOKO>"
/system script add dont-require-permissions=no name=reset-pppoe-260318131256-ALVIN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260318131256-ALVIN>"
/system script add dont-require-permissions=no name=reset-pppoe-260330135611-LINA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260330135611-LINA>"
/system script add dont-require-permissions=no name=reset-pppoe-260330152600-CUCUM owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260330152600-CUCUM>"
/system script add dont-require-permissions=no name=reset-pppoe-260402181107-BAGUS owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260402181107-BAGUS>"
/system script add dont-require-permissions=no name=reset-pppoe-260405165907-DADANG owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260405165907-DADANG>"
/system script add dont-require-permissions=no name=reset-pppoe-260408115030-APRIYANI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260408115030-APRIYANI>"
/system script add dont-require-permissions=no name=reset-pppoe-20260425131734-HENI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-20260425131734-HENI>"
/system script add dont-require-permissions=no name=reset-pppoe-260427110615-YULIA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260427110615-YULIA>"
/tool netwatch add comment=tunnel-gateway-172.26.0.1 host=172.26.0.1 type=simple
