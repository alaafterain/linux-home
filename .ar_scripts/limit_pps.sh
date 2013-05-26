#/bin/sh
tc qdisc del dev wlan0 root
iptables -X -t mangle
iptables -F -t mangle

tc qdisc add dev wlan0 root handle 1:0 htb
tc class add dev wlan0 parent 1:0 classid 1:1 htb rate 200kbit
tc filter add dev wlan0 parent 1:0 protocol ip handle 1 fw classid 1:1
tc filter add dev wlan0 parent 1:0 protocol ip prio 1 u32 match ip sport 35353 0xffff flowid 1:1
tc filter add dev wlan0 parent 1:0 protocol ip prio 1 u32 match ip dport 35353 0xffff flowid 1:1
tc filter add dev wlan0 parent 1:0 protocol ip prio 1 u32 match ip sport 1900 0xffff flowid 1:1
tc filter add dev wlan0 parent 1:0 protocol ip prio 1 u32 match ip dport 1900 0xffff flowid 1:1
#iptables -t mangle -A PREROUTING -p udp -j MARK --set-mark 1
#iptables -t mangle -A PREROUTING -p udp -m udp --sport $1 -j MARK --set-mark 1
#iptables -t mangle -A PREROUTING -p udp -m udp --dport $1 -j MARK --set-mark 1
#iptables -t mangle -A PREROUTING -p udp -m udp --sport $2 -j MARK --set-mark 1
#iptables -t mangle -A PREROUTING -p udp -m udp --dport $2 -j MARK --set-mark 1

tc qdisc show dev wlan0
tc class show dev wlan0
tc filter show dev wlan0
iptables -L -t mangle
