#/bin/sh
#DEV=vmnet8
DEV=wlan0
tc qdisc del dev $DEV root
#iptables -X -t mangle
#iptables -F -t mangle

tc qdisc add dev $DEV root handle 1:0 htb
tc class add dev $DEV parent 1:0 classid 1:1 htb rate 200kbit
tc filter add dev $DEV parent 1:0 protocol ip handle 1 fw classid 1:1
tc filter add dev $DEV parent 1:0 protocol ip prio 1 u32 match ip src 192.168.2.11 flowid 1:1
#tc filter add dev $DEV parent 1:0 protocol ip prio 1 u32 match ip src 172.16.50.1 flowid 1:1
#tc filter add dev $DEV parent 1:0 protocol ip prio 1 u32 match ip sport 3724 0xffff flowid 1:1

tc qdisc show dev $DEV
tc class show dev $DEV
tc filter show dev $DEV
#iptables -L -t mangle
