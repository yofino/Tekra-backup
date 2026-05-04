# 2026-05-05 02:01:04 by RouterOS 7.16.1
# software id = 4CAB-TI0E
#
# model = RB4011iGS+
# serial number = HF2098WNNYZ
/interface bridge add name=BRIDGE-BACKBONE
/interface bridge add name=BRIDGE-HOTSPOT
/interface bridge add name=BRIDGE-PORT-OLT
/interface bridge add name=BRIDGE-TR069
/interface bridge add disabled=yes name=bridge-vlan-hotspot
/interface ethernet set [ find default-name=ether2 ] name=ether2-DARI-PUSAT
/interface ethernet set [ find default-name=ether5 ] name=ether5-BRIDGE-VLAN-HOTSPOT
/interface ethernet set [ find default-name=ether6 ] name=ether6-LAN-SWITCH
/interface ethernet set [ find default-name=ether7 ] name=ether7-OLT
/interface ethernet set [ find default-name=sfp-sfpplus1 ] auto-negotiation=no speed=1G-baseT-full
/interface ovpn-client add comment=tunnel-31721 connect-to=id-20.tunnel.web.id mac-address=FE:32:21:AE:89:DE name=tunnel-31721 user=cilisung
/interface l2tp-client add connect-to=103.226.138.15 disabled=no name=REMOTE user=CILIGX
/interface l2tp-client add connect-to=115.178.49.186 disabled=no name=TUNNEL-DARI-CCR1-PUSAT user=CILISUNGGX
/interface l2tp-client add connect-to=210.79.190.25 disabled=no name=TUNNEL-NEW user=CILISUNG
/interface vlan add interface=sfp-sfpplus1 name=VLAN-FROM-PUSAT vlan-id=202
/interface vlan add interface=ether7-OLT name=VLAN-MONITOR-OLT vlan-id=144
/interface vlan add interface=ether8 name=VLAN-PPOE-CILISUNG-HIOSO vlan-id=143
/interface vlan add interface=ether7-OLT name=VLAN-PPPOE-CILISUNG vlan-id=143
/interface vlan add interface=ether7-OLT name=VLAN-PPPOE-SEKEAWI vlan-id=145
/interface vlan add interface=sfp-sfpplus1 name=VLAN-TO-PUSAT vlan-id=203
/interface vlan add interface=ether7-OLT name=vlan100-TR069-E7 vlan-id=100
/interface vlan add interface=ether8 name=vlan100-TR069-E8 vlan-id=100
/ip dhcp-server option add code=43 name=acs value=0x0119687474703A2F2F31302E31302E31302E3233303A37353437
/ip dhcp-server option sets add name=acs options=acs
/ip hotspot profile add dns-name=tekra.hotspot hotspot-address=10.5.50.1 name=hsprof1
/ip pool add name=PAKET-1 ranges=10.10.1.5-10.10.1.254
/ip pool add name=PAKET-2 ranges=10.10.2.5-10.10.2.254
/ip pool add name=PAKET-3 ranges=10.10.3.5-10.10.3.254
/ip pool add name=PAKET-4 ranges=10.10.4.5-10.10.4.254
/ip pool add name=PAKET-5 ranges=10.10.5.5-10.10.5.254
/ip pool add name=TR069 ranges=10.30.64.2-10.30.64.254
/ip pool add name=hs-pool-13 ranges=10.5.50.180-10.5.50.254
/ip pool add name=dhcp_pool8 ranges=10.30.64.2-10.30.64.254
/ip pool add name=dhcp_pool9 ranges=10.30.64.2-10.30.71.254
/ip dhcp-server add address-pool=hs-pool-13 interface=BRIDGE-HOTSPOT name=dhcp1
/ip dhcp-server add address-pool=dhcp_pool9 dhcp-option-set=acs interface=BRIDGE-TR069 name=TR069
/ip hotspot add address-pool=hs-pool-13 addresses-per-mac=unlimited disabled=no interface=BRIDGE-HOTSPOT name=hotspot1 profile=hsprof1
/port set 0 name=serial0
/port set 1 name=serial1
/queue simple add name=PAKET-1 target=10.10.1.0/24
/queue simple add name=PAKET-2 target=10.10.2.0/24
/queue simple add name=PAKET-3 target=10.10.3.0/24
/queue simple add name=PAKET-4 target=10.10.4.0/24
/queue simple add name=PAKET-5 target=10.10.5.0/24
/queue simple add max-limit=8M/8M name="HASTI YULISTIATI" target=10.5.50.14/32
/queue simple add comment=FAJAR max-limit=8M/8M name="SITI INDRIANI" target=10.5.50.46/32
/queue simple add max-limit=30M/30M name="CECEP DEPAN" target=10.5.50.48/32
/queue simple add max-limit=8M/8M name=MIDA target=10.5.50.69/32
/queue type add kind=fq-codel name=FQ-CODEL
/ppp profile add local-address=10.10.1.1 name=PAKET1 parent-queue=PAKET-1 queue-type=FQ-CODEL rate-limit="10M/10M 0/0 0/0 0/0 8 10M/10M" remote-address=PAKET-1
/ppp profile add local-address=10.10.2.1 name=PAKET2 parent-queue=PAKET-2 queue-type=FQ-CODEL rate-limit="16M/16M 0/0 0/0 0/0 8 16M/16M" remote-address=PAKET-2
/ppp profile add local-address=10.10.3.1 name=PAKET3 parent-queue=PAKET-3 queue-type=FQ-CODEL rate-limit="20M/20M 0/0 0/0 0/0 8 20M/20M" remote-address=PAKET-3
/ppp profile add local-address=10.10.4.1 name=PAKET4 parent-queue=PAKET-4 queue-type=FQ-CODEL rate-limit="25M/25M 0/0 0/0 0/0 8 25M/25M" remote-address=PAKET-4
/ppp profile add local-address=10.10.5.1 name=PAKET5 parent-queue=PAKET-4 queue-type=FQ-CODEL rate-limit="30M/30M 0/0 0/0 0/0 8 30M/30M" remote-address=PAKET-5
/ppp profile add local-address=10.10.2.1 name="PAKET HEMAT" parent-queue=PAKET-2 queue-type=FQ-CODEL rate-limit="10M/10M 0/0 0/0 0/0 8 10M/10M" remote-address=PAKET-2
/ppp profile add local-address=10.10.3.1 name="PAKET MANTAP" parent-queue=PAKET-3 queue-type=FQ-CODEL rate-limit="20M/20M 0/0 0/0 0/0 8 20M/20M" remote-address=PAKET-3
/ppp profile add local-address=10.10.5.1 name="PAKET PUAS" parent-queue=PAKET-4 queue-type=FQ-CODEL rate-limit="30M/30M 0/0 0/0 0/0 8 30M/30M" remote-address=PAKET-5
/snmp community set [ find default=yes ] write-access=yes
/interface bridge port add bridge=BRIDGE-HOTSPOT interface=ether6-LAN-SWITCH
/interface bridge port add bridge=BRIDGE-TR069 interface=vlan100-TR069-E7
/interface bridge port add bridge=BRIDGE-TR069 interface=vlan100-TR069-E8
/interface bridge port add bridge=bridge-vlan-hotspot disabled=yes interface=ether5-BRIDGE-VLAN-HOTSPOT
/interface bridge port add bridge=BRIDGE-PORT-OLT interface=VLAN-PPOE-CILISUNG-HIOSO
/interface bridge port add bridge=BRIDGE-BACKBONE interface=VLAN-TO-PUSAT
/interface bridge port add bridge=BRIDGE-BACKBONE interface=ether1
/interface bridge port add bridge=BRIDGE-BACKBONE interface=sfp-sfpplus1
/interface bridge port add bridge=BRIDGE-BACKBONE interface=ether10
/interface bridge port add bridge=BRIDGE-PORT-OLT interface=VLAN-PPPOE-CILISUNG
/ip firewall connection tracking set udp-timeout=10s
/ip neighbor discovery-settings set discover-interface-list=!dynamic
/interface pppoe-server server add disabled=no interface=BRIDGE-PORT-OLT service-name=service1
/interface pppoe-server server add disabled=no interface=VLAN-PPPOE-SEKEAWI service-name=service2
/ip address add address=192.168.101.1/24 interface=VLAN-MONITOR-OLT network=192.168.101.0
/ip address add address=192.168.124.11/24 interface=BRIDGE-BACKBONE network=192.168.124.0
/ip address add address=172.90.10.11/24 interface=VLAN-FROM-PUSAT network=172.90.10.0
/ip address add address=10.30.64.1/21 interface=BRIDGE-TR069 network=10.30.64.0
/ip address add address=192.168.0.1/24 interface=ether9 network=192.168.0.0
/ip dhcp-server network add address=10.5.50.0/24 comment="hotspot network" gateway=10.5.50.1
/ip dhcp-server network add address=10.30.64.0/21 gateway=10.30.64.1
/ip dns set allow-remote-requests=yes servers=8.8.8.8,8.8.4.4
/ip firewall filter add action=passthrough chain=unused-hs-chain comment="place hotspot rules here" disabled=yes
/ip firewall nat add action=passthrough chain=unused-hs-chain comment="place hotspot rules here" disabled=yes
/ip firewall nat add action=masquerade chain=srcnat comment="masquerade hotspot network" src-address=10.5.50.0/24
/ip firewall nat add action=masquerade chain=srcnat out-interface=BRIDGE-BACKBONE
/ip firewall nat add action=masquerade chain=srcnat out-interface=ether2-DARI-PUSAT
/ip firewall nat add action=masquerade chain=srcnat out-interface=VLAN-MONITOR-OLT
/ip firewall nat add action=masquerade chain=srcnat out-interface=VLAN-FROM-PUSAT
/ip firewall nat add action=dst-nat chain=dstnat dst-address=210.79.190.25 dst-port=8321 protocol=tcp to-addresses=10.5.50.1 to-ports=8728
/ip firewall nat
# REMOTE not ready
add action=dst-nat chain=dstnat dst-port=8121 in-interface=REMOTE protocol=tcp to-addresses=10.5.50.1 to-ports=8291
/ip firewall nat add action=dst-nat chain=dstnat dst-port=8080 in-interface=TUNNEL-DARI-CCR1-PUSAT protocol=tcp to-addresses=192.168.101.10 to-ports=80
/ip firewall nat add action=dst-nat chain=dstnat dst-port=53,5353 in-interface=BRIDGE-TR069 protocol=udp to-ports=53
/ip firewall nat add action=dst-nat chain=dstnat dst-address=!10.10.10.230 in-interface=BRIDGE-TR069 protocol=tcp to-addresses=10.10.10.230 to-ports=7547
/ip firewall nat add action=dst-nat chain=dstnat dst-port=!7547 in-interface=BRIDGE-TR069 protocol=tcp to-addresses=10.10.10.230 to-ports=7547
/ip firewall nat add action=dst-nat chain=dstnat comment=tunnel-nat-172.22.0.226-443 dst-address=172.22.0.226 dst-port=443 protocol=tcp to-addresses=192.168.124.1 to-ports=443
/ip hotspot ip-binding add address=172.10.0.4 to-address=172.10.0.4 type=bypassed
/ip hotspot ip-binding add address=10.5.50.14 to-address=10.5.50.14 type=bypassed
/ip hotspot ip-binding add address=10.5.50.46 to-address=10.5.50.46 type=bypassed
/ip hotspot ip-binding add address=10.5.50.48 to-address=10.5.50.48 type=bypassed
/ip hotspot ip-binding add address=10.5.50.69 to-address=10.5.50.69 type=bypassed
/ip hotspot user add name=admin
/ip ipsec profile set [ find default=yes ] dpd-interval=2m dpd-maximum-failures=5
/ip route add disabled=no distance=1 dst-address=8.8.8.8/32 gateway=172.90.10.1 routing-table=main scope=10 suppress-hw-offload=no target-scope=10
/ip route add disabled=no distance=1 dst-address=8.8.4.4/32 gateway=192.168.124.1 routing-table=main scope=10 suppress-hw-offload=no target-scope=10
/ip route add check-gateway=ping disabled=no distance=1 dst-address=0.0.0.0/0 gateway=8.8.8.8 routing-table=main scope=30 suppress-hw-offload=no target-scope=11
/ip route add check-gateway=ping disabled=no distance=2 dst-address=0.0.0.0/0 gateway=8.8.4.4 routing-table=main scope=30 suppress-hw-offload=no target-scope=11
/ip route add disabled=no distance=1 dst-address=10.10.10.230/32 gateway=10.6.0.1 routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/ip route add disabled=no dst-address=0.0.0.0/0 gateway=172.90.10.1 routing-table=main suppress-hw-offload=no
/ip route add disabled=no dst-address=10.10.10.22/32 gateway=10.6.0.1 routing-table=main suppress-hw-offload=no
/ip route add disabled=no distance=2 dst-address=0.0.0.0/0 gateway=192.168.124.1 routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/ip service set telnet disabled=yes
/ip service set ftp disabled=yes
/ip service set www disabled=yes
/ip service set ssh port=18
/ip service set api-ssl disabled=yes
/ppp secret add name=YOFI profile=PAKET1 service=pppoe
/ppp secret add name=FAJAR profile="PAKET MANTAP" service=pppoe
/ppp secret add name=YUSUF profile=PAKET1 service=pppoe
/ppp secret add name=DENIS profile=PAKET1 service=pppoe
/ppp secret add name=AEP profile=PAKET1 service=pppoe
/ppp secret add name=FIRMAN profile=PAKET2 service=pppoe
/ppp secret add name=DAMAN profile=PAKET1 service=pppoe
/ppp secret add name=WIDODO profile=PAKET1 service=pppoe
/ppp secret add name=ANDI profile=PAKET2 service=pppoe
/ppp secret add name=FAKHRI profile=PAKET1 service=pppoe
/ppp secret add name=AGUS profile=PAKET1 service=pppoe
/ppp secret add name=WILDAN profile=PAKET1 service=pppoe
/ppp secret add name=TEST profile=PAKET1 service=pppoe
/ppp secret add name=NARTI profile=PAKET1 service=pppoe
/ppp secret add name=ANI profile=PAKET2 service=pppoe
/ppp secret add name=RATNA profile=PAKET1 service=pppoe
/ppp secret add name=ADE profile=PAKET1 service=pppoe
/ppp secret add name=DAYAT profile=PAKET1 service=pppoe
/ppp secret add name=KALUA profile=PAKET1 service=pppoe
/ppp secret add name=DIANEKA profile=PAKET1 service=pppoe
/ppp secret add name=ASEP profile="PAKET MANTAP" service=pppoe
/ppp secret add name=EFSA profile=PAKET2 service=pppoe
/ppp secret add name=TRIAYU profile=PAKET2 service=pppoe
/ppp secret add name=LILIS profile=PAKET2 service=pppoe
/ppp secret add name=GGCLINK profile=PAKET1 service=pppoe
/ppp secret add name=YETI profile=PAKET2 service=pppoe
/ppp secret add name=FAUZIAH profile=PAKET1 service=pppoe
/ppp secret add name=TATI profile=PAKET1 service=pppoe
/ppp secret add name=IMELDA profile=PAKET1 service=pppoe
/ppp secret add name=ROSSIE profile=PAKET1 service=pppoe
/ppp secret add name=ELIS profile=PAKET2 service=pppoe
/ppp secret add name=231209182065-FIKRI profile=PAKET2 service=pppoe
/ppp secret add name=231209182068-ABDUL profile=PAKET1 service=pppoe
/ppp secret add name=231209182069-GUGUN profile=PAKET1 service=pppoe
/ppp secret add name=231215114527-LAGIYONO profile=PAKET1 service=pppoe
/ppp secret add name=240504175814-SASKIA profile=PAKET1 service=pppoe
/ppp secret add disabled=yes name=NOVITA profile=PAKET2 service=pppoe
/ppp secret add name=NANA profile=PAKET2 service=pppoe
/ppp secret add name=ILHAM profile=PAKET2 service=pppoe
/ppp secret add local-address=10.3.0.1 name=ELLA profile=PAKET3 remote-address=10.3.0.12 service=pppoe
/ppp secret add name=PANDJI profile=PAKET1 service=pppoe
/ppp secret add name=NURLELA profile=PAKET2 service=pppoe
/ppp secret add name=TIKA profile=PAKET1 service=pppoe
/ppp secret add name=TAUFAN profile=PAKET1 service=pppoe
/ppp secret add name=231209182067-MASRUROH profile=PAKET1 service=pppoe
/ppp secret add name=231209182070-DESYA profile=PAKET1 service=pppoe
/ppp secret add name=231209182072-SEFTIANY profile="PAKET MANTAP" service=pppoe
/ppp secret add disabled=yes name=240504175810-DIKI profile=PAKET1 service=pppoe
/ppp secret add name=240504175815-IWAN profile="PAKET HEMAT" service=pppoe
/ppp secret add name=240504175816-WAWAN profile=PAKET1 service=pppoe
/ppp secret add disabled=yes name=240504175819-RANNIA profile=PAKET1 service=pppoe
/ppp secret add name=240504175820-YOSMIANTO profile=PAKET1 service=pppoe
/ppp secret add name=240504175821-SOFYAN profile=PAKET4 service=pppoe
/ppp secret add disabled=yes name=240504175824-AI profile=PAKET1 service=pppoe
/ppp secret add name=240504175808-IWAN profile=PAKET2 service=pppoe
/ppp secret add name=240504175825-YANI profile=PAKET2 service=pppoe
/ppp secret add name=240504175827-BELLA profile=PAKET1 service=pppoe
/ppp secret add name=240504175829-AI profile=PAKET1 service=pppoe
/ppp secret add name=230312143253-JAJANG profile=PAKET1 service=pppoe
/ppp secret add name=11100105-DEFIANA profile=PAKET3 service=pppoe
/ppp secret add name=11100106-SUHENDAR profile="PAKET HEMAT" service=pppoe
/ppp secret add name=231215114525-ROSSIE profile=PAKET1 service=pppoe
/ppp secret add name=231215114521-AIYETI profile=PAKET2 service=pppoe
/ppp secret add name=231215114522-FAUZIAH profile=PAKET1 service=pppoe
/ppp secret add disabled=yes name=230526121403-KALUA profile=PAKET1 service=pppoe
/ppp secret add name=230312143258-ADECANDRA profile=PAKET1 service=pppoe
/ppp secret add name=230312143259-RATNA profile=PAKET1 service=pppoe
/ppp secret add name=230312143256-DAYATHIDAYAT profile=PAKET1 service=pppoe
/ppp secret add name=230526121405-DIANEKA profile=PAKET1 service=pppoe
/ppp secret add name=230613081722-NARTI profile=PAKET1 service=pppoe
/ppp secret add name=231209182058-TAUFAN profile=PAKET1 service=pppoe
/ppp secret add name=231215114524-IMELDA profile=PAKET1 service=pppoe
/ppp secret add name=220815132421-LILIS profile=PAKET2 service=pppoe
/ppp secret add name=231215114523-TATI profile=PAKET1 service=pppoe
/ppp secret add name=220815132420-TRIAYU profile=PAKET2 service=pppoe
/ppp secret add name=230906115927-EFSA profile=PAKET2 service=pppoe
/ppp secret add name=231209182234-ILHAM profile=PAKET2 service=pppoe
/ppp secret add name=231209182052-PANDJI profile=PAKET1 service=pppoe
/ppp secret add name=231209182054-NURLELA profile="PAKET HEMAT" service=pppoe
/ppp secret add name=231209182048-NANA profile=PAKET2 service=pppoe
/ppp secret add name=11100107-CECEP profile="PAKET HEMAT" service=pppoe
/ppp secret add name=101600001-ZENAL profile=PAKET1 service=pppoe
/ppp secret add name=101600010-SITI profile=PAKET1 service=pppoe
/ppp secret add disabled=yes name=101600011-HENDI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=11100108-ABDIKA profile="PAKET HEMAT" service=pppoe
/ppp secret add name=11100109-SUGIYANTI profile=PAKET1 service=pppoe
/ppp secret add name=241111112249-FINNY profile=PAKET2 service=pppoe
/ppp secret add name=241111123837-LINDA profile=PAKET1 service=pppoe
/ppp secret add disabled=yes name=230114074232-ACEP profile=PAKET1 service=pppoe
/ppp secret add name=101600012-NADIA profile=PAKET1 service=pppoe
/ppp secret add name=231215114526-ELIS profile=PAKET2 service=pppoe
/ppp secret add name=240504175826-TUBAGUS profile=PAKET1 service=pppoe
/ppp secret add name=230906115925-INTAN profile=PAKET2 service=pppoe
/ppp secret add name=241205150940-FITRIANA profile=PAKET5 service=pppoe
/ppp secret add name=241216170358-FAUZAN profile=PAKET5 service=pppoe
/ppp secret add name=241220150933-FERDY profile=PAKET1 service=pppoe
/ppp secret add name=250101105349-FAUZI profile=PAKET1 service=pppoe
/ppp secret add disabled=yes name=250103162512-CINTAWATI profile=PAKET1 service=pppoe
/ppp secret add disabled=yes name=240504175822-RATIH profile=PAKET1 service=pppoe
/ppp secret add name=250111130802-WIDANINGSIH profile=PAKET1 service=pppoe
/ppp secret add name=230613081721-ADECECE profile=PAKET1 service=pppoe
/ppp secret add name=230613081715-ROPIK profile=PAKET2 service=pppoe
/ppp secret add name=230304191420-DEWI profile=PAKET1 service=pppoe
/ppp secret add name=230613081717-TATANGTASIR profile=PAKET1 service=pppoe
/ppp secret add name=230304191417-WILDAN profile=PAKET1 service=pppoe
/ppp secret add disabled=yes name=230312143257-ANGGA profile=PAKET1 service=pppoe
/ppp secret add disabled=yes name=231209182060-ENI profile=PAKET1 service=pppoe
/ppp secret add name=230304191412-AEPP profile=PAKET1 service=pppoe
/ppp secret add name=231209182073-SADIAH profile=PAKET1 service=pppoe
/ppp secret add name=230426120002-FAUZI profile=PAKET2 service=pppoe
/ppp secret add name=231209182061-YUNI profile=PAKET2 service=pppoe
/ppp secret add name=230906115926-PURMAGIANI profile=PAKET1 service=pppoe
/ppp secret add name=230304191411-DANIS profile=PAKET1 service=pppoe
/ppp secret add name=230304191414-WIDODO profile=PAKET1 service=pppoe
/ppp secret add name=231209182050-MARSINI profile=PAKET1 service=pppoe
/ppp secret add name=230526121402-DAWAM profile=PAKET1 service=pppoe
/ppp secret add name=230304191413-DAMAN profile=PAKET1 service=pppoe
/ppp secret add name=230304191416-TINA profile=PAKET1 service=pppoe
/ppp secret add name=230304191415-ANDI profile=PAKET1 service=pppoe
/ppp secret add name=221228123325-PERTIWI profile=PAKET1 service=pppoe
/ppp secret add name=230304191419-PAUD profile=PAKET1 service=pppoe
/ppp secret add name=230304191419-CENDRAWASIH profile=PAKET1 service=pppoe
/ppp secret add disabled=yes name=230312143247-ELLY profile=PAKET2 service=pppoe
/ppp secret add name=230613081718-YADI profile=PAKET1 service=pppoe
/ppp secret add name=250118114445-MAMAD profile=PAKET1 service=pppoe
/ppp secret add name=250118131256-FIRMAN profile=PAKET1 service=pppoe
/ppp secret add name=231209182064-RT3 profile=PAKET1 service=pppoe
/ppp secret add name=230906115929-AKIN profile=PAKET2 service=pppoe
/ppp secret add name=230909151061-FABIEZA profile=PAKET2 service=pppoe
/ppp secret add name=231209182053-IMASNENI profile=PAKET3 service=pppoe
/ppp secret add name=230613081720-ENDANG profile=PAKET1 service=pppoe
/ppp secret add name=231209182055-HENISUHAENI profile=PAKET2 service=pppoe
/ppp secret add name=230312143251-AHMAD profile=PAKET1 service=pppoe
/ppp secret add name=230312143255-DICKY profile=PAKET2 service=pppoe
/ppp secret add name=231209182056-TIO profile=PAKET1 service=pppoe
/ppp secret add name=240504175811-DICKY profile=PAKET2 service=pppoe
/ppp secret add name=240504175811-NOFAL profile=PAKET2 service=pppoe
/ppp secret add name=230613081720-ENDANGSUDRAJAT profile=PAKET1 service=pppoe
/ppp secret add name=230906115923-ALDISAPUTRA profile=PAKET2 service=pppoe
/ppp secret add name=230312143249-YASTRI profile=PAKET2 service=pppoe
/ppp secret add name=230312143250-DADANG profile=PAKET1 service=pppoe
/ppp secret add disabled=yes name=231209182062-EGAHELMA profile=PAKET2 service=pppoe
/ppp secret add name=231009185224-DEDE profile=PAKET2 service=pppoe
/ppp secret add name=230906115931-SURYANA profile=PAKET1 service=pppoe
/ppp secret add name=240504175828-ROBBY profile=PAKET1 service=pppoe
/ppp secret add name=240504175817-IMASHALIMAH profile=PAKET1 service=pppoe
/ppp secret add name=230906115928-IMAMARIPIN profile=PAKET2 service=pppoe
/ppp secret add name=240504175813-RAHMAN profile=PAKET1 service=pppoe
/ppp secret add name=240504175823-EUISSITI profile=PAKET1 service=pppoe
/ppp secret add name=240504175812-HERISUPRIADI profile=PAKET1 service=pppoe
/ppp secret add name=230906115930-GERI profile=PAKET2 service=pppoe
/ppp secret add name=230312143246-RINA profile=PAKET2 service=pppoe
/ppp secret add name=240504175818-RITA profile=PAKET1 service=pppoe
/ppp secret add name=230526121404-CECEPDEPAN profile=PAKET4 service=pppoe
/ppp secret add name=230613081719-SYARIFUDIN profile=PAKET1 service=pppoe
/ppp secret add name=CILISUNG profile=PAKET1 service=pppoe
/ppp secret add name=230304191421-HASTI profile=PAKET1 service=pppoe
/ppp secret add name=250311155850-PANDU profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250319111600-YULI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250408102651-AGUSGUNAWAN profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250429110120-MIMIN profile="PAKET HEMAT"
/ppp secret add name=250430114024-SITIHAMIDAH profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250501112352-ALDIPRATAMA profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250506091446-PUTRI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250510112608-TEGUH profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250522110422-IBAH profile="PAKET HEMAT" service=pppoe
/ppp secret add disabled=yes name=250605142032-FAISAL profile="PAKET HEMAT" service=pppoe
/ppp secret add disabled=yes name=250611143454-AGUSKURNIAWAN profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250701112317-ELLY profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250701112317-FITA profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250701125546-JUWANTI profile="PAKET HEMAT" service=pppoe
/ppp secret add disabled=yes name=250701134513-SITIKOMARIAH profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250702164311-DEDEH profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250702174424-OYOK profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250716162747-SETIYAR profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250731103516-RITA profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250802101625-GITA profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250809104542-ATEP profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250901115943-ANIE profile="PAKET HEMAT" service=pppoe
/ppp secret add disabled=yes name=250902160829-ENUNG profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250911145005-DANI profile="PAKET PUAS" service=pppoe
/ppp secret add disabled=yes name=250930124439-DODI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=250930142518-SIDIQ profile="PAKET HEMAT" service=pppoe
/ppp secret add name=251002101559-IIS profile="PAKET MANTAP" service=pppoe
/ppp secret add name=251015105540-AGAN profile="PAKET HEMAT" service=pppoe
/ppp secret add name=251016122355-ORIN profile="PAKET HEMAT" service=pppoe
/ppp secret add name=251105105201-FERA profile="PAKET HEMAT" service=pppoe
/ppp secret add name=251105130114-ROCHMAYANI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=251106161957-AISAH profile="PAKET HEMAT" service=pppoe
/ppp secret add name=251111163823-WINA profile="PAKET MANTAP" service=pppoe
/ppp secret add name=251120172659-MARGARETHA profile=PAKET4 service=pppoe
/ppp secret add name=251125120936-WINIARTI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=251128141759-EEN profile="PAKET MANTAP" service=pppoe
/ppp secret add disabled=yes name=251128151302-NATASYA profile="PAKET HEMAT" service=pppoe
/ppp secret add name=251128162108-IKHWAN profile="PAKET HEMAT" service=pppoe
/ppp secret add name=251128174314-INDRI profile="PAKET MANTAP" service=pppoe
/ppp secret add name=251201140217-HARLAN profile="PAKET MANTAP" service=pppoe
/ppp secret add name=251205104858-AYIHAMDANI profile="PAKET MANTAP" service=pppoe
/ppp secret add name=251206102626-PARWATI profile="PAKET MANTAP" service=pppoe
/ppp secret add name=251209152000-AGUS profile="PAKET MANTAP" service=pppoe
/ppp secret add name=251210144124-PIPIH profile="PAKET HEMAT" service=pppoe
/ppp secret add name=251219110718-ANISA profile="PAKET HEMAT" service=pppoe
/ppp secret add name=251220105317-DELASEPTI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=251221111624-FEBRI profile="PAKET MANTAP" service=pppoe
/ppp secret add name=251225144806-NIDA profile="PAKET HEMAT" service=pppoe
/ppp secret add name=251226191658-NAJMUDIN profile="PAKET MANTAP" service=pppoe
/ppp secret add name=251229105157-NAZWA profile="PAKET MANTAP" service=pppoe
/ppp secret add name=251229120809-MEGA profile="PAKET HEMAT" service=pppoe
/ppp secret add name=260101150238-SITIHASANAH profile="PAKET HEMAT" service=pppoe
/ppp secret add name=260102112236-NENI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=260102132624-WILDAN profile="PAKET HEMAT" service=pppoe
/ppp secret add name=260103190059-WIDIASTUTI profile="PAKET MANTAP" service=pppoe
/ppp secret add name=260104114743-PUTRI profile="PAKET MANTAP" service=pppoe
/ppp secret add name=260104131334-TITI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=260104150834-SITI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=260104155731-SITINURHASANAH profile="PAKET HEMAT" service=pppoe
/ppp secret add name=EPUL profile="PAKET HEMAT" service=pppoe
/ppp secret add name=260105152727-DEBI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=260105171537-IWANSETIAWAN profile="PAKET MANTAP" service=pppoe
/ppp secret add name=260106172244-NOVITA profile="PAKET HEMAT" service=pppoe
/ppp secret add disabled=yes name=260108123338-YATI profile="PAKET HEMAT" service=pppoe
/ppp secret add disabled=yes name=260108160859-HESTIA profile="PAKET MANTAP" service=pppoe
/ppp secret add name=260108173445-ASEPDEDI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=260109170440-KOMARIAH profile="PAKET HEMAT" service=pppoe
/ppp secret add name=260112130002-SUGIONO profile="PAKET HEMAT" service=pppoe
/ppp secret add name=260112141011-AGUNGPERMANA profile="PAKET MANTAP" service=pppoe
/ppp secret add name=260114145947-ZIDAN profile="PAKET PUAS" service=pppoe
/ppp secret add name=260124130101-SRIDWI profile="PAKET MANTAP" service=pppoe
/ppp secret add name=260130140141-FIRZI profile="PAKET MANTAP" service=pppoe
/ppp secret add name=260131125819-IMAN profile="PAKET HEMAT" service=pppoe
/ppp secret add name=260203181552-HELLENA profile="PAKET MANTAP" service=pppoe
/ppp secret add name=260211162621-BAYU profile="PAKET MANTAP" service=pppoe
/ppp secret add name=260216150447-ERNI profile="PAKET MANTAP" service=pppoe
/ppp secret add name=260217101102-ELI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=260220145557-DENI profile=PAKET2 service=pppoe
/ppp secret add name=260228141635-TANTAN profile="PAKET HEMAT" service=pppoe
/ppp secret add name=260301131432-ANGGRAENI profile="PAKET PUAS" service=pppoe
/ppp secret add name=260301134448-KIKI profile=PAKET2 service=pppoe
/ppp secret add name=260303121842-RIRIN profile="PAKET PUAS" service=pppoe
/ppp secret add name=R-20260324124925-ROHMIATI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=20260329125557-ANI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=260330134851-DEVIA profile="PAKET HEMAT" service=pppoe
/ppp secret add name=260330152600-CUCUM profile="PAKET HEMAT" service=pppoe
/ppp secret add comment=LASMI-CILISUNG name=260401135130-LASMI profile="PAKET HEMAT" service=pppoe
/ppp secret add name=260402123134-GUNAWAN profile=PAKET2 service=pppoe
/ppp secret add name=260402181107-BAGUS profile="PAKET HEMAT" service=pppoe
/ppp secret add name=260403212233-IRPAN profile=PAKET2 service=pppoe
/ppp secret add name=260405134433-KIRANA profile="PAKET MANTAP" service=pppoe
/ppp secret add name=260408150643-RISNA profile="PAKET HEMAT" service=pppoe
/ppp secret add comment="NURWINDA - Cilisung RT02 RW05" name=20260414115345-NURWINDA profile="PAKET HEMAT" service=pppoe
/ppp secret add name=260422150730-YANWAR profile=PAKET2 service=pppoe
/ppp secret add name=260501153341-NOER profile="PAKET MANTAP" service=pppoe
/snmp set enabled=yes trap-version=3
/system clock set time-zone-name=Asia/Jakarta
/system identity set name=CILISUNG
/system note set note=172 show-at-login=no
/system routerboard settings set enter-setup-on=delete-key
/system scheduler add interval=30s name=sched_pppoe_count on-event=update_pppoe_count policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2026-01-05 start-time=15:26:44
/system script add dont-require-permissions=no name=reset-pppoe-220815132421-LILIS owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-220815132421-LILIS>"
/system script add dont-require-permissions=no name=reset-pppoe-11100107-CECEP owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-11100107-CECEP>"
/system script add dont-require-permissions=no name=reset-pppoe-231215114525-ROSSIE owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-231215114525-ROSSIE>"
/system script add dont-require-permissions=no name=reset-pppoe-231215114521-AIYETI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-231215114521-AIYETI>"
/system script add dont-require-permissions=no name=reset-pppoe-220815132420-TRIAYU owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-220815132420-TRIAYU>"
/system script add dont-require-permissions=no name=reset-pppoe-230613081722-NARTI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230613081722-NARTI>"
/system script add dont-require-permissions=no name=reset-pppoe-231209182052-PANDJI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-231209182052-PANDJI>"
/system script add dont-require-permissions=no name=reset-pppoe-230312143259-RATNA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230312143259-RATNA>"
/system script add dont-require-permissions=no name=reset-pppoe-231215114524-IMELDA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-231215114524-IMELDA>"
/system script add dont-require-permissions=no name=reset-pppoe-240504175816-WAWAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240504175816-WAWAN>"
/system script add dont-require-permissions=no name=reset-pppoe-230906115927-EFSA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230906115927-EFSA>"
/system script add dont-require-permissions=no name=reset-pppoe-231209182054-NURLELA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-231209182054-NURLELA>"
/system script add dont-require-permissions=no name=reset-pppoe-231209182048-NANA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-231209182048-NANA>"
/system script add dont-require-permissions=no name=reset-pppoe-230312143253-JAJANG owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230312143253-JAJANG>"
/system script add dont-require-permissions=no name=reset-pppoe-231209182072-SEFTIANY owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-231209182072-SEFTIANY>"
/system script add dont-require-permissions=no name=reset-pppoe-231209182069-GUGUN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-231209182069-GUGUN>"
/system script add dont-require-permissions=no name=reset-pppoe-231209182068-ABDUL owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-231209182068-ABDUL>"
/system script add dont-require-permissions=no name=reset-pppoe-11100105-DEFIANA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-11100105-DEFIANA>"
/system script add dont-require-permissions=no name=reset-pppoe-231215114522-FAUZIAH owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-231215114522-FAUZIAH>"
/system script add dont-require-permissions=no name=reset-pppoe-231215114523-TATI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-231215114523-TATI>"
/system script add dont-require-permissions=no name=reset-pppoe-240504175827-BELLA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240504175827-BELLA>"
/system script add dont-require-permissions=no name=reset-pppoe-231209182067-MASRUROH owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-231209182067-MASRUROH>"
/system script add dont-require-permissions=no name=reset-pppoe-240504175824-AI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240504175824-AI>"
/system script add dont-require-permissions=no name=reset-pppoe-230312143256-DAYATHIDAYAT owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230312143256-DAYATHIDAYAT>"
/system script add dont-require-permissions=no name=reset-pppoe-231209182234-ILHAM owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-231209182234-ILHAM>"
/system script add dont-require-permissions=no name=reset-pppoe-11100109-SUGIYANTI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-11100109-SUGIYANTI>"
/system script add dont-require-permissions=no name=reset-pppoe-231209182070-DESYA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-231209182070-DESYA>"
/system script add dont-require-permissions=no name=reset-pppoe-240504175821-SOFYAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240504175821-SOFYAN>"
/system script add dont-require-permissions=no name=reset-pppoe-230526121405-DIANEKA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230526121405-DIANEKA>"
/system script add dont-require-permissions=no name=reset-pppoe-101600010-SITI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-101600010-SITI>"
/system script add dont-require-permissions=no name=reset-pppoe-11100108-ABDIKA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-11100108-ABDIKA>"
/system script add dont-require-permissions=no name=reset-pppoe-240504175829-AI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240504175829-AI>"
/system script add dont-require-permissions=no name=reset-pppoe-ELIS owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-ELIS>"
/system script add dont-require-permissions=no name=reset-pppoe-230312143258-ADECANDRA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230312143258-ADECANDRA>"
/system script add dont-require-permissions=no name=reset-pppoe-240504175825-YANI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240504175825-YANI>"
/system script add dont-require-permissions=no name=reset-pppoe-101600001-ZENAL owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-101600001-ZENAL>"
/system script add dont-require-permissions=no name=reset-pppoe-240504175808-IWAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240504175808-IWAN>"
/system script add dont-require-permissions=no name=reset-pppoe-240504175814-SASKIA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240504175814-SASKIA>"
/system script add dont-require-permissions=no name=reset-pppoe-230526121403-KALUA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230526121403-KALUA>"
/system script add dont-require-permissions=no name=reset-pppoe-241111123837-LINDA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-241111123837-LINDA>"
/system script add dont-require-permissions=no name=reset-pppoe-231215114527-LAGIYONO owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-231215114527-LAGIYONO>"
/system script add dont-require-permissions=no name=reset-pppoe-11100106-SUHENDAR owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-11100106-SUHENDAR>"
/system script add dont-require-permissions=no name=reset-pppoe-231209182058-TAUFAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-231209182058-TAUFAN>"
/system script add dont-require-permissions=no name=reset-pppoe-240504175820-YOSMIANTO owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240504175820-YOSMIANTO>"
/system script add dont-require-permissions=no name=reset-pppoe-240504175815-IWAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240504175815-IWAN>"
/system script add dont-require-permissions=no name=reset-pppoe-241111112249-FINNY owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-241111112249-FINNY>"
/system script add dont-require-permissions=no name=reset-pppoe-101600011-HENDI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-101600011-HENDI>"
/system script add dont-require-permissions=no name=reset-pppoe-ELLA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-ELLA>"
/system script add dont-require-permissions=no name=reset-pppoe-101600012-NADIA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-101600012-NADIA>"
/system script add dont-require-permissions=no name=reset-pppoe-231215114526-ELIS owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-231215114526-ELIS>"
/system script add dont-require-permissions=no name=reset-pppoe-230114074232-ACEP owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230114074232-ACEP>"
/system script add dont-require-permissions=no name=reset-pppoe-240504175826-TUBAGUS owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240504175826-TUBAGUS>"
/system script add dont-require-permissions=no name=reset-pppoe-230906115925-INTAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230906115925-INTAN>"
/system script add dont-require-permissions=no name=reset-pppoe-241216170358-FAUZAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-241216170358-FAUZAN>"
/system script add dont-require-permissions=no name=reset-pppoe-241220150933-FERDY owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-241220150933-FERDY>"
/system script add dont-require-permissions=no name=reset-pppoe-230906115929-AKIN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230906115929-AKIN>"
/system script add dont-require-permissions=no name=reset-pppoe-230613081721-ADECECE owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230613081721-ADECECE>"
/system script add dont-require-permissions=no name=reset-pppoe-250118114445-MAMAD owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250118114445-MAMAD>"
/system script add dont-require-permissions=no name=reset-pppoe-230909151061-FABIEZA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230909151061-FABIEZA>"
/system script add dont-require-permissions=no name=reset-pppoe-230526121402-DAWAM owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230526121402-DAWAM>"
/system script add dont-require-permissions=no name=reset-pppoe-230426120002-FAUZI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230426120002-FAUZI>"
/system script add dont-require-permissions=no name=reset-pppoe-240504175823-EUISSITI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240504175823-EUISSITI>"
/system script add dont-require-permissions=no name=reset-pppoe-230613081717-TATANGTASIR owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230613081717-TATANGTASIR>"
/system script add dont-require-permissions=no name=reset-pppoe-230613081718-YADI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230613081718-YADI>"
/system script add dont-require-permissions=no name=reset-pppoe-230304191414-WIDODO owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230304191414-WIDODO>"
/system script add dont-require-permissions=no name=reset-pppoe-231209182061-YUNI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-231209182061-YUNI>"
/system script add dont-require-permissions=no name=reset-pppoe-231209182062-EGAHELMA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-231209182062-EGAHELMA>"
/system script add dont-require-permissions=no name=reset-pppoe-230906115930-GERI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230906115930-GERI>"
/system script add dont-require-permissions=no name=reset-pppoe-230906115928-IMAMARIPIN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230906115928-IMAMARIPIN>"
/system script add dont-require-permissions=no name=reset-pppoe-230906115923-ALDISAPUTRA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230906115923-ALDISAPUTRA>"
/system script add dont-require-permissions=no name=reset-pppoe-231209182050-MARSINI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-231209182050-MARSINI>"
/system script add dont-require-permissions=no name=reset-pppoe-230312143251-AHMAD owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230312143251-AHMAD>"
/system script add dont-require-permissions=no name=reset-pppoe-230312143249-YASTRI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230312143249-YASTRI>"
/system script add dont-require-permissions=no name=reset-pppoe-230613081715-ROPIK owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230613081715-ROPIK>"
/system script add dont-require-permissions=no name=reset-pppoe-231209182073-SADIAH owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-231209182073-SADIAH>"
/system script add dont-require-permissions=no name=reset-pppoe-250111130802-WIDANINGSIH owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250111130802-WIDANINGSIH>"
/system script add dont-require-permissions=no name=reset-pppoe-240504175818-RITA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240504175818-RITA>"
/system script add dont-require-permissions=no name=reset-pppoe-230304191411-DANIS owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230304191411-DANIS>"
/system script add dont-require-permissions=no name=reset-pppoe-230304191416-TINA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230304191416-TINA>"
/system script add dont-require-permissions=no name=reset-pppoe-230613081720-ENDANGSUDRAJAT owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230613081720-ENDANGSUDRAJAT>"
/system script add dont-require-permissions=no name=reset-pppoe-240504175812-HERISUPRIADI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240504175812-HERISUPRIADI>"
/system script add dont-require-permissions=no name=reset-pppoe-230312143246-RINA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230312143246-RINA>"
/system script add dont-require-permissions=no name=reset-pppoe-250101105349-FAUZI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250101105349-FAUZI>"
/system script add dont-require-permissions=no name=reset-pppoe-230304191420-DEWI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230304191420-DEWI>"
/system script add dont-require-permissions=no name=reset-pppoe-230312143255-DICKY owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230312143255-DICKY>"
/system script add dont-require-permissions=no name=reset-pppoe-240504175828-ROBBY owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240504175828-ROBBY>"
/system script add dont-require-permissions=no name=reset-pppoe-250103162512-CINTAWATI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250103162512-CINTAWATI>"
/system script add dont-require-permissions=no name=reset-pppoe-231209182053-IMASNENI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-231209182053-IMASNENI>"
/system script add dont-require-permissions=no name=reset-pppoe-231209182060-ENI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-231209182060-ENI>"
/system script add dont-require-permissions=no name=reset-pppoe-230906115931-SURYANA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230906115931-SURYANA>"
/system script add dont-require-permissions=no name=reset-pppoe-230304191413-DAMAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230304191413-DAMAN>"
/system script add dont-require-permissions=no name=reset-pppoe-221228123325-PERTIWI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-221228123325-PERTIWI>"
/system script add dont-require-permissions=no name=reset-pppoe-240504175822-RATIH owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240504175822-RATIH>"
/system script add dont-require-permissions=no name=reset-pppoe-231209182064-RT3 owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-231209182064-RT3>"
/system script add dont-require-permissions=no name=reset-pppoe-230304191412-AEPP owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230304191412-AEPP>"
/system script add dont-require-permissions=no name=reset-pppoe-230526121404-CECEPDEPAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230526121404-CECEPDEPAN>"
/system script add dont-require-permissions=no name=reset-pppoe-230613081719-SYARIFUDIN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230613081719-SYARIFUDIN>"
/system script add dont-require-permissions=no name=reset-pppoe-250118131256-FIRMAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250118131256-FIRMAN>"
/system script add dont-require-permissions=no name=reset-pppoe-ANI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-ANI>"
/system script add dont-require-permissions=no name=reset-pppoe-240504175811-NOFAL owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240504175811-NOFAL>"
/system script add dont-require-permissions=no name=reset-pppoe-231209182055-HENISUHAENI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-231209182055-HENISUHAENI>"
/system script add dont-require-permissions=no name=reset-pppoe-230906115926-PURMAGIANI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230906115926-PURMAGIANI>"
/system script add dont-require-permissions=no name=reset-pppoe-240504175813-RAHMAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240504175813-RAHMAN>"
/system script add dont-require-permissions=no name=reset-pppoe-230304191419-CENDRAWASIH owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230304191419-CENDRAWASIH>"
/system script add dont-require-permissions=no name=reset-pppoe-231209182056-TIO owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-231209182056-TIO>"
/system script add dont-require-permissions=no name=reset-pppoe-230304191415-ANDI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230304191415-ANDI>"
/system script add dont-require-permissions=no name=reset-pppoe-230312143247-ELLY owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230312143247-ELLY>"
/system script add dont-require-permissions=no name=reset-pppoe-230312143250-DADANG owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230312143250-DADANG>"
/system script add dont-require-permissions=no name=reset-pppoe-240504175817-IMASHALIMAH owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-240504175817-IMASHALIMAH>"
/system script add dont-require-permissions=no name=reset-pppoe-230312143257-ANGGA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230312143257-ANGGA>"
/system script add dont-require-permissions=no name=reset-pppoe-231009185224-DEDE owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-231009185224-DEDE>"
/system script add dont-require-permissions=no name=reset-pppoe-230304191417-WILDAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230304191417-WILDAN>"
/system script add dont-require-permissions=no name=reset-pppoe-230304191421-HASTI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-230304191421-HASTI>"
/system script add dont-require-permissions=no name=reset-pppoe-250319111600-YULI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250319111600-YULI>"
/system script add dont-require-permissions=no name=reset-pppoe-250311155850-PANDU owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250311155850-PANDU>"
/system script add dont-require-permissions=no name=reset-pppoe-250408102651-AGUSGUNAWAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250408102651-AGUSGUNAWAN>"
/system script add dont-require-permissions=no name=reset-pppoe-250501112352-ALDIPRATAMA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250501112352-ALDIPRATAMA>"
/system script add dont-require-permissions=no name=reset-pppoe-250430114024-SITIHAMIDAH owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250430114024-SITIHAMIDAH>"
/system script add dont-require-permissions=no name=reset-pppoe-250506091446-PUTRI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250506091446-PUTRI>"
/system script add dont-require-permissions=no name=reset-pppoe-250522110422-IBAH owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250522110422-IBAH>"
/system script add dont-require-permissions=no name=reset-pppoe-250510112608-TEGUH owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250510112608-TEGUH>"
/system script add dont-require-permissions=no name=reset-pppoe-250611143454-AGUSKURNIAWAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250611143454-AGUSKURNIAWAN>"
/system script add dont-require-permissions=no name=reset-pppoe-250716162747-SETIYAR owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250716162747-SETIYAR>"
/system script add dont-require-permissions=no name=reset-pppoe-250701112317-FITA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250701112317-FITA>"
/system script add dont-require-permissions=no name=reset-pppoe-250802101625-GITA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250802101625-GITA>"
/system script add dont-require-permissions=no name=reset-pppoe-250731103516-RITA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250731103516-RITA>"
/system script add dont-require-permissions=no name=reset-pppoe-250702164311-DEDEH owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250702164311-DEDEH>"
/system script add dont-require-permissions=no name=reset-pppoe-250702174424-OYOK owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250702174424-OYOK>"
/system script add dont-require-permissions=no name=reset-pppoe-250701134513-SITIKOMARIAH owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250701134513-SITIKOMARIAH>"
/system script add dont-require-permissions=no name=reset-pppoe-250701125546-JUWANTI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250701125546-JUWANTI>"
/system script add dont-require-permissions=no name=reset-pppoe-250605142032-FAISAL owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250605142032-FAISAL>"
/system script add dont-require-permissions=no name=reset-pppoe-250809104542-ATEP owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250809104542-ATEP>"
/system script add dont-require-permissions=no name=reset-pppoe-250902160829-ENUNG owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250902160829-ENUNG>"
/system script add dont-require-permissions=no name=reset-pppoe-250911145005-DANI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250911145005-DANI>"
/system script add dont-require-permissions=no name=reset-pppoe-250901115943-ANIE owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250901115943-ANIE>"
/system script add dont-require-permissions=no name=reset-pppoe-250930142518-SIDIQ owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250930142518-SIDIQ>"
/system script add dont-require-permissions=no name=reset-pppoe-250930124439-DODI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250930124439-DODI>"
/system script add dont-require-permissions=no name=reset-pppoe-251002101559-IIS owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251002101559-IIS>"
/system script add dont-require-permissions=no name=reset-pppoe-251015105540-AGAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251015105540-AGAN>"
/system script add dont-require-permissions=no name=reset-pppoe-251016122355-ORIN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251016122355-ORIN>"
/system script add dont-require-permissions=no name=reset-pppoe-251105130114-ROCHMAYANI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251105130114-ROCHMAYANI>"
/system script add dont-require-permissions=no name=reset-pppoe-251106161957-AISAH owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251106161957-AISAH>"
/system script add dont-require-permissions=no name=reset-pppoe-251105105201-FERA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251105105201-FERA>"
/system script add dont-require-permissions=no name=reset-pppoe-251111163823-WINA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251111163823-WINA>"
/system script add dont-require-permissions=no name=reset-pppoe-251125120936-WINIARTI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251125120936-WINIARTI>"
/system script add dont-require-permissions=no name=reset-pppoe-251128174314-INDRI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251128174314-INDRI>"
/system script add dont-require-permissions=no name=reset-pppoe-251128141759-EEN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251128141759-EEN>"
/system script add dont-require-permissions=no name=reset-pppoe-251128162108-IKHWAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251128162108-IKHWAN>"
/system script add dont-require-permissions=no name=reset-pppoe-251201140217-HARLAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251201140217-HARLAN>"
/system script add dont-require-permissions=no name=reset-pppoe-251120172659-MARGARETHA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251120172659-MARGARETHA>"
/system script add dont-require-permissions=no name=reset-pppoe-251128151302-NATASYA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251128151302-NATASYA>"
/system script add dont-require-permissions=no name=reset-pppoe-251210144124-PIPIH owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251210144124-PIPIH>"
/system script add dont-require-permissions=no name=reset-pppoe-251229105157-NAZWA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251229105157-NAZWA>"
/system script add dont-require-permissions=no name=reset-pppoe-251221111624-FEBRI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251221111624-FEBRI>"
/system script add dont-require-permissions=no name=reset-pppoe-251226191658-NAJMUDIN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251226191658-NAJMUDIN>"
/system script add dont-require-permissions=no name=reset-pppoe-251220105317-DELASEPTI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251220105317-DELASEPTI>"
/system script add dont-require-permissions=no name=reset-pppoe-251225144806-NIDA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251225144806-NIDA>"
/system script add dont-require-permissions=no name=reset-pppoe-251229120809-MEGA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251229120809-MEGA>"
/system script add dont-require-permissions=no name=reset-pppoe-251205104858-AYIHAMDANI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251205104858-AYIHAMDANI>"
/system script add dont-require-permissions=no name=reset-pppoe-251209152000-AGUS owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251209152000-AGUS>"
/system script add dont-require-permissions=no name=reset-pppoe-251206102626-PARWATI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251206102626-PARWATI>"
/system script add dont-require-permissions=no name=reset-pppoe-251219110718-ANISA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-251219110718-ANISA>"
/system script add dont-require-permissions=no name=reset-pppoe-250429110120-MIMIN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-250429110120-MIMIN>"
/system script add dont-require-permissions=no name=reset-pppoe-260101150238-SITIHASANAH owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260101150238-SITIHASANAH>"
/system script add dont-require-permissions=no name=reset-pppoe-260102112236-NENI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260102112236-NENI>"
/system script add dont-require-permissions=no name=reset-pppoe-260102132624-WILDAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260102132624-WILDAN>"
/system script add dont-require-permissions=no name=reset-pppoe-260103190059-WIDIASTUTI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260103190059-WIDIASTUTI>"
/system script add dont-require-permissions=no name=reset-pppoe-260104114743-PUTRI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260104114743-PUTRI>"
/system script add dont-require-permissions=no name=reset-pppoe-260104131334-TITI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260104131334-TITI>"
/system script add dont-require-permissions=no name=reset-pppoe-260104155731-SITINURHASANAH owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260104155731-SITINURHASANAH>"
/system script add dont-require-permissions=no name=update_pppoe_count owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\
    \n    :local active [/ppp active print count-only]\
    \n    /system note set note=\$active\
    \n"
/system script add dont-require-permissions=no name=reset-pppoe-260105152727-DEBI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260105152727-DEBI>"
/system script add dont-require-permissions=no name=reset-pppoe-260105171537-IWANSETIAWAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260105171537-IWANSETIAWAN>"
/system script add dont-require-permissions=no name=reset-pppoe-260106172244-NOVITA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260106172244-NOVITA>"
/system script add dont-require-permissions=no name=reset-pppoe-260108123338-YATI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260108123338-YATI>"
/system script add dont-require-permissions=no name=reset-pppoe-260108160859-HESTIA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260108160859-HESTIA>"
/system script add dont-require-permissions=no name=reset-pppoe-260108173445-ASEPDEDI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260108173445-ASEPDEDI>"
/system script add dont-require-permissions=no name=reset-pppoe-260109170440-KOMARIAH owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260109170440-KOMARIAH>"
/system script add dont-require-permissions=no name=reset-pppoe-260112130002-SUGIONO owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260112130002-SUGIONO>"
/system script add dont-require-permissions=no name=reset-pppoe-260112141011-AGUNGPERMANA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260112141011-AGUNGPERMANA>"
/system script add dont-require-permissions=no name=reset-pppoe-260114145947-ZIDAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260114145947-ZIDAN>"
/system script add dont-require-permissions=no name=reset-pppoe-260124130101-SRIDWI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260124130101-SRIDWI>"
/system script add dont-require-permissions=no name=reset-pppoe-260130140141-FIRZI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260130140141-FIRZI>"
/system script add dont-require-permissions=no name=reset-pppoe-260131125819-IMAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260131125819-IMAN>"
/system script add dont-require-permissions=no name=reset-pppoe-260203181552-HELLENA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260203181552-HELLENA>"
/system script add dont-require-permissions=no name=reset-pppoe-260211162621-BAYU owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260211162621-BAYU>"
/system script add dont-require-permissions=no name=reset-pppoe-260216150447-ERNI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260216150447-ERNI>"
/system script add dont-require-permissions=no name=reset-pppoe-260217101102-ELI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260217101102-ELI>"
/system script add dont-require-permissions=no name=reset-pppoe-260220145557-DENI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260220145557-DENI>"
/system script add dont-require-permissions=no name=reset-pppoe-260228141635-TANTAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260228141635-TANTAN>"
/system script add dont-require-permissions=no name=reset-pppoe-260301131432-ANGGRAENI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260301131432-ANGGRAENI>"
/system script add dont-require-permissions=no name=reset-pppoe-260301134448-KIKI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260301134448-KIKI>"
/system script add dont-require-permissions=no name=reset-pppoe-260303121842-RIRIN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260303121842-RIRIN>"
/system script add dont-require-permissions=no name=reset-pppoe-20260329125557-ANI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-20260329125557-ANI>"
/system script add dont-require-permissions=no name=reset-pppoe-260401135130-LASMI owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260401135130-LASMI>"
/system script add dont-require-permissions=no name=reset-pppoe-260402123134-GUNAWAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260402123134-GUNAWAN>"
/system script add dont-require-permissions=no name=reset-pppoe-260403212233-IRPAN owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260403212233-IRPAN>"
/system script add dont-require-permissions=no name=reset-pppoe-260405134433-KIRANA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260405134433-KIRANA>"
/system script add dont-require-permissions=no name=reset-pppoe-260408150643-RISNA owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260408150643-RISNA>"
/system script add dont-require-permissions=no name=reset-pppoe-260422150730-YANWAR owner=keanu policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/interface reset-counters <pppoe-260422150730-YANWAR>"
/tool netwatch add comment=tunnel-gateway-172.22.0.1 host=172.22.0.1 type=simple
