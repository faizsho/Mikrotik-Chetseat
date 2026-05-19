# dec/14/2024 20:18:54 by RouterOS 6.49.4
# software id = HHJH-UFWL
#
#
#
/ip firewall mangle
add action=mark-connection chain=prerouting comment=";;;;;;;;;;;;;;;;;;;ICMP" \
    dst-address-list=!kecuali new-connection-mark=icmp-conn passthrough=yes \
    protocol=icmp src-address-list=lokal
add action=mark-packet chain=prerouting connection-mark=icmp-conn \
    new-packet-mark=icmp-packet passthrough=no
add action=mark-connection chain=prerouting comment=Google disabled=yes \
    dst-address=!8.8.0.0/16 dst-address-list=Google new-connection-mark=\
    Google passthrough=yes src-address-list=lokal
add action=mark-routing chain=prerouting comment=Google-Pisah \
    connection-mark=Google disabled=yes dst-address-list=!kecuali \
    new-routing-mark=Belok passthrough=yes src-address-list=lokal
add action=mark-connection chain=prerouting comment="Common Traffic" \
    dst-address-list=!kecuali dst-port=\
    21,22,23,80,81,88,443,554,182,5060,8000-8081,843,8777 \
    new-connection-mark=common-conn passthrough=yes protocol=tcp \
    src-address-list=lokal
add action=mark-connection chain=prerouting new-connection-mark=common-conn \
    packet-size=251-9999 passthrough=yes protocol=tcp
add action=mark-connection chain=prerouting dst-address-list=!kecuali \
    dst-port=5060,1935,1194,1701,1723,500,4500,6881-6889 new-connection-mark=\
    common-conn passthrough=yes protocol=udp src-address-list=lokal
add action=mark-connection chain=prerouting new-connection-mark=common-conn \
    packet-size=251-9999 passthrough=yes protocol=udp
add action=mark-packet chain=prerouting connection-mark=common-conn \
    new-packet-mark=common-packet passthrough=no
add action=mark-connection chain=prerouting comment="Small Traffic" \
    new-connection-mark=small-conn packet-size=0-250 passthrough=yes \
    protocol=!icmp
add action=mark-packet chain=prerouting connection-mark=small-conn \
    new-packet-mark=small-packet passthrough=no
add action=change-ttl chain=postrouting comment="Hotspot Protect" disabled=\
    yes dst-address-list=Voucher new-ttl=set:1 passthrough=no
add action=mark-connection chain=prerouting comment=Telegram-STB disabled=yes \
    dst-address-list=Telegram new-connection-mark=Tele-STB passthrough=yes \
    src-address=192.168.76.2/31
add action=mark-routing chain=prerouting disabled=yes dst-address-list=\
    Telegram new-routing-mark=Backup passthrough=no src-address=\
    192.168.76.2/31
add action=mark-routing chain=prerouting disabled=yes new-routing-mark=JKT \
    passthrough=no src-address=10.16.20.2
add action=mark-connection chain=prerouting comment="TOTAL ALL" disabled=yes \
    dst-address-list="!IP MENGGUNAKAN PORT RANDOM" new-connection-mark=\
    "TOTAL ALL" passthrough=yes protocol=!icmp src-address-list=lokal
add action=mark-packet chain=forward connection-mark="TOTAL ALL" disabled=yes \
    dst-address-list=lokal in-interface-list=WAN new-packet-mark=\
    "DOWNLOAD ALL" passthrough=yes protocol=!icmp src-address-list=\
    "!IP MENGGUNAKAN PORT RANDOM"
add action=mark-packet chain=forward connection-mark="TOTAL ALL" disabled=yes \
    dst-address-list="!IP MENGGUNAKAN PORT RANDOM" new-packet-mark=\
    "UPLOAD ALL" out-interface-list=WAN passthrough=yes protocol=!icmp \
    src-address-list=lokal
add action=add-dst-to-address-list address-list="IP MENGGUNAKAN PORT RANDOM" \
    address-list-timeout=1m chain=prerouting comment=GAME disabled=yes \
    dst-address-list=!kecuali dst-port=\
    !21,22,23,81,88,5060,843,182,8777,1935,53,8000-8081,443,80 protocol=tcp \
    src-address-list=lokal
add action=add-dst-to-address-list address-list="IP MENGGUNAKAN PORT RANDOM" \
    address-list-timeout=1m chain=prerouting disabled=yes dst-address-list=\
    !kecuali dst-port=\
    !21,22,23,81,88,5060,843,182,8777,1935,53,8000-8081,443,80 protocol=udp \
    src-address-list=lokal
add action=mark-packet chain=forward disabled=yes dst-address-list=lokal \
    in-interface-list=WAN new-packet-mark="PORT SELAIN PORT UMUM(GAME) DOWN" \
    passthrough=yes src-address-list="IP MENGGUNAKAN PORT RANDOM"
add action=mark-packet chain=forward disabled=yes dst-address-list=\
    "IP MENGGUNAKAN PORT RANDOM" new-packet-mark=\
    "PORT SELAIN PORT UMUM(GAME) UP" out-interface-list=WAN passthrough=yes \
    src-address-list=lokal
add action=mark-packet chain=forward comment=GAME-RAW disabled=yes \
    dst-address-list=lokal in-interface-list=WAN new-packet-mark=\
    "PORT SELAIN PORT UMUM(GAME) DOWN" passthrough=yes src-address-list=\
    GAME-RAW
add action=mark-packet chain=forward disabled=yes dst-address-list=GAME-RAW \
    new-packet-mark="PORT SELAIN PORT UMUM(GAME) UP" out-interface-list=WAN \
    passthrough=yes src-address-list=lokal
add action=mark-connection chain=prerouting connection-rate=0-999k disabled=\
    yes dst-address-list="IP MENGGUNAKAN PORT RANDOM" new-connection-mark=\
    Game passthrough=yes src-address-list=lokal
add action=add-dst-to-address-list address-list="PORT BERAT" \
    address-list-timeout=15m chain=prerouting comment="PORT RANDOM BERAT" \
    connection-rate=1M-999M disabled=yes dst-address-list=\
    "IP MENGGUNAKAN PORT RANDOM" src-address-list=lokal
add action=add-dst-to-address-list address-list="PORT BERAT" \
    address-list-timeout=15m chain=prerouting connection-bytes=\
    1000000-999000000 disabled=yes dst-address-list=\
    "IP MENGGUNAKAN PORT RANDOM" src-address-list=lokal
add action=mark-packet chain=forward disabled=yes dst-address-list=lokal \
    in-interface-list=WAN new-packet-mark="PORT BERAT DOWN" passthrough=no \
    src-address-list="PORT BERAT"
add action=mark-packet chain=forward disabled=yes dst-address-list=\
    "PORT BERAT" new-packet-mark="PORT BERAT UP" out-interface-list=WAN \
    passthrough=no src-address-list=lokal
add action=mark-connection chain=prerouting comment=ICMP disabled=yes \
    new-connection-mark=ICMP passthrough=yes protocol=icmp
add action=mark-packet chain=forward connection-mark=ICMP disabled=yes \
    in-interface-list=WAN new-packet-mark="ICMP DOWN" passthrough=no
add action=mark-packet chain=forward connection-mark=ICMP disabled=yes \
    new-packet-mark="ICMP UP" out-interface-list=WAN passthrough=no
add action=mark-connection chain=prerouting comment=SPEEDTEST disabled=yes \
    dst-address-list=speedtest new-connection-mark=speedtest passthrough=yes \
    src-address-list=lokal
add action=mark-packet chain=forward connection-mark=speedtest disabled=yes \
    in-interface-list=WAN new-packet-mark="SPEEDTEST DOWN" passthrough=no
add action=mark-packet chain=forward connection-mark=speedtest disabled=yes \
    new-packet-mark="SPEEDTEST UP" out-interface-list=WAN passthrough=no
add action=add-dst-to-address-list address-list="UMUM BERAT" \
    address-list-timeout=25s chain=prerouting comment="TRAFIC UMUM BERAT" \
    connection-bytes=5000000-999000000 connection-mark="TOTAL ALL" \
    connection-rate=512k-999M disabled=yes dst-address-list=\
    "!IP MENGGUNAKAN PORT RANDOM" src-address-list=lokal
add action=mark-connection chain=prerouting connection-bytes=\
    5000000-999000000 connection-mark="TOTAL ALL" connection-rate=512k-999M \
    disabled=yes dst-address-list=!Youtube new-connection-mark="UMUM BERAT" \
    passthrough=yes
add action=mark-packet chain=forward connection-mark="UMUM BERAT" disabled=\
    yes in-interface-list=WAN new-packet-mark="UMUM BERAT DOWN" passthrough=\
    no
add action=mark-packet chain=forward connection-mark="UMUM BERAT" disabled=\
    yes new-packet-mark="UMUM BERAT UP" out-interface-list=WAN passthrough=no
add action=mark-connection chain=prerouting comment="STREAMING VIDEO" \
    disabled=yes dst-address-list=Youtube new-connection-mark=YOUTUBE \
    passthrough=yes src-address-list=lokal
add action=mark-packet chain=forward connection-mark=YOUTUBE disabled=yes \
    in-interface-list=WAN new-packet-mark="STREAMING VIDEO DOWN" passthrough=\
    no
add action=mark-packet chain=forward connection-mark=YOUTUBE disabled=yes \
    new-packet-mark="STREAMING VIDEO UP" out-interface-list=WAN passthrough=\
    no
add action=mark-routing chain=prerouting comment=Youtube-Pisah \
    connection-mark=YOUTUBE disabled=yes dst-address-list=!kecuali \
    new-routing-mark=Belok passthrough=no src-address-list=lokal
add action=mark-routing chain=prerouting comment=Berat-Pisah connection-mark=\
    "UMUM BERAT" disabled=yes dst-address-list=!kecuali new-routing-mark=\
    Belok passthrough=no src-address-list=lokal
add action=mark-routing chain=prerouting comment=Speedtest-Pisah \
    connection-mark=speedtest disabled=yes dst-address-list=!kecuali \
    new-routing-mark=Belok passthrough=no src-address-list=lokal
