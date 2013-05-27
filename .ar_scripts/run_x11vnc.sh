#!/bin/bash
/usr/bin/x11vnc -auth /var/run/lightdm/root/:1 -rfbauth /home/zhouyuan/.vnc/passwd -forever -display :1
