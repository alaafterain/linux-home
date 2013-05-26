#!/bin/sh
if xmessage -nearmouse -buttons yes:0,no:1 -default yes "$1?"; then
	#sudo shutdown -h now
	gnome-terminal -t "$1" -e "$2"
fi
