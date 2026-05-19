# mar/13/1970 12:24:16 by RouterOS 6.49.19
# software id = SIYI-QL6J
#
# model = RB750Gr3
# serial number = CC210DED5E8F
/ip firewall filter
add action=fasttrack-connection chain=forward comment=\
    "Fasttrack Video Streaming" connection-state=established,related \
    disabled=yes port=1935,554,1755,5004-5005 protocol=tcp
add action=accept chain=forward comment="Fasttrack Video Streaming" \
    connection-state=established,related disabled=yes port=\
    1935,554,1755,5004-5005 protocol=tcp
add action=fasttrack-connection chain=forward comment="Fasttrack Games List" \
    connection-state=established,related disabled=yes dst-address-list=\
    List-IP-Games
add action=accept chain=forward comment="Fasttrack Games List" \
    connection-state=established,related disabled=yes dst-address-list=\
    List-IP-Games
add action=fasttrack-connection chain=forward comment="Fasttrack VOIP" \
    connection-state=established,related disabled=yes port=\
    10000-20000,4569,5060 protocol=udp
add action=accept chain=forward comment="Fasttrack VOIP" connection-state=\
    established,related disabled=yes port=10000-20000,4569,5060 protocol=udp
add action=accept chain=input comment=Estab-Related-Untrack connection-state=\
    established,related,untracked disabled=yes protocol=tcp
add action=accept chain=input comment=Estab-Related-Untrack connection-state=\
    established,related,untracked disabled=yes protocol=udp
add action=accept chain=input comment=Estab-Related-Untrack connection-state=\
    established,related,untracked disabled=yes protocol=icmp
add action=accept chain=input comment=Estab-Related-Untrack connection-state=\
    established,related,untracked disabled=yes
add action=drop chain=input comment="Drop Invalid-Connection" \
    connection-state=invalid disabled=yes protocol=tcp
add action=drop chain=input comment="Drop Invalid-Connection" \
    connection-state=invalid disabled=yes protocol=icmp
add action=drop chain=input comment="Drop Invalid-Connection" \
    connection-state=invalid disabled=yes protocol=udp
add action=drop chain=forward comment="Drop Invalid-Connection" \
    connection-state=invalid disabled=yes
add action=accept chain=input comment="Limited Ping" disabled=yes limit=\
    30,60:packet protocol=icmp
add action=drop chain=input disabled=yes protocol=icmp
add action=add-src-to-address-list address-list="port scanners" \
    address-list-timeout=2w chain=input comment=\
    "Mark Source ip port scanner to Address list " disabled=yes protocol=tcp \
    psd=21,3s,3,1
add action=add-src-to-address-list address-list="port scanners" \
    address-list-timeout=2w chain=input comment="NMAP FIN Stealth scan" \
    disabled=yes protocol=tcp tcp-flags=fin,!syn,!rst,!psh,!ack,!urg
add action=add-src-to-address-list address-list="port scanners" \
    address-list-timeout=2w chain=input comment="SYN/FIN scan" disabled=yes \
    protocol=tcp tcp-flags=fin,syn
add action=add-src-to-address-list address-list="port scanners" \
    address-list-timeout=2w chain=input comment="SYN/RST scan" disabled=yes \
    protocol=tcp tcp-flags=syn,rst
add action=add-src-to-address-list address-list="port scanners" \
    address-list-timeout=2w chain=input comment="FIN/PSH/URG scan" disabled=\
    yes protocol=tcp tcp-flags=fin,psh,urg,!syn,!rst,!ack
add action=add-src-to-address-list address-list="port scanners" \
    address-list-timeout=2w chain=input comment="ALL/ALL scan" disabled=yes \
    protocol=tcp tcp-flags=fin,syn,rst,psh,ack,urg
add action=add-src-to-address-list address-list="port scanners" \
    address-list-timeout=2w chain=input comment="NMAP NULL scan" disabled=yes \
    protocol=tcp tcp-flags=!fin,!syn,!rst,!psh,!ack,!urg
add action=drop chain=input comment="Drop port scanners" disabled=yes \
    src-address-list="port scanners"
add action=drop chain=input comment=\
    ";;;;;;;;;;;;;;;;;;;;;;;;;Drop All Port Scanners" disabled=yes \
    src-address-list=port_scanners
add action=drop chain=forward comment="Drop Port Scanner ke Akses Lokal" \
    disabled=yes src-address-list=port_scanners
add action=accept chain=forward comment=Estab-Related-Untrack \
    connection-state=established,related,untracked disabled=yes protocol=tcp
add action=accept chain=forward comment=Estab-Related-Untrack \
    connection-state=established,related,untracked disabled=yes protocol=udp
add action=accept chain=forward comment=Estab-Related-Untrack \
    connection-state=established,related,untracked disabled=yes protocol=icmp
add action=accept chain=forward comment=Estab-Related-Untrack \
    connection-state=established,related,untracked disabled=yes
add action=jump chain=forward comment="Anti DDoS Attacks" connection-state=\
    new disabled=yes jump-target=block-ddos
add action=drop chain=forward connection-state=new disabled=yes \
    dst-address-list=ddosed src-address-list=ddoser
add action=return chain=block-ddos disabled=yes dst-limit=\
    50,50,src-and-dst-addresses/10s
add action=add-dst-to-address-list address-list=ddosed address-list-timeout=\
    10m chain=block-ddos disabled=yes
add action=add-src-to-address-list address-list=ddoser address-list-timeout=\
    10m chain=block-ddos disabled=yes
add action=drop chain=input comment="Drop Invalid-Connection" \
    connection-state=invalid disabled=yes protocol=tcp
add action=drop chain=input comment="Drop Invalid-Connection" \
    connection-state=invalid disabled=yes protocol=icmp
add action=drop chain=input comment="Drop Invalid-Connection" \
    connection-state=invalid disabled=yes protocol=udp
add action=drop chain=input comment="Drop Invalid-Connection" \
    connection-state=invalid disabled=yes
add action=drop chain=input disabled=yes dst-port=\
    21,53,161-162,445,5353,3128,8080,8291,8728,8729 in-interface-list=WAN \
    protocol=tcp src-address=!103.134.220.0/22
add action=drop chain=input disabled=yes dst-port=\
    21,53,161-162,445,5353,3128,8080,8291,8728,8729 in-interface-list=WAN \
    protocol=udp src-address=!103.134.220.0/22
add action=drop chain=forward comment=\
    "Memcrashed - Amplification Attacks UDP 11211" disabled=yes dst-port=\
    11211 protocol=udp
add action=drop chain=input comment="drop ftp BRUTE FORCErs" disabled=yes \
    dst-port=21 protocol=tcp src-address-list=ftp_blacklist
add action=accept chain=output content="530 Login incorrect" disabled=yes \
    dst-limit=1/1m,9,dst-address/1m protocol=tcp
add action=add-dst-to-address-list address-list=ftp_blacklist \
    address-list-timeout=3h chain=output content="530 Login incorrect" \
    disabled=yes protocol=tcp
add action=drop chain=input comment="drop ssh BRUTE FORCErs" disabled=yes \
    dst-port=22-23 protocol=tcp src-address-list=ssh_blacklist
add action=add-src-to-address-list address-list=ssh_blacklist \
    address-list-timeout=1w3d chain=input connection-state=new disabled=yes \
    dst-port=22-23 protocol=tcp src-address-list=ssh_stage3
add action=add-src-to-address-list address-list=ssh_stage3 \
    address-list-timeout=1m chain=input connection-state=new disabled=yes \
    dst-port=22-23 protocol=tcp src-address-list=ssh_stage2
add action=add-src-to-address-list address-list=ssh_stage2 \
    address-list-timeout=1m chain=input connection-state=new disabled=yes \
    dst-port=22-23 protocol=tcp src-address-list=ssh_stage1
add action=add-src-to-address-list address-list=ssh_stage1 \
    address-list-timeout=1m chain=input connection-state=new disabled=yes \
    dst-port=22-23 protocol=tcp
add action=drop chain=forward comment="drop ssh brute downstream" disabled=\
    yes dst-port=22-23 protocol=tcp src-address-list=ssh_blacklist
