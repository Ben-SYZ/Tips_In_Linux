#########################################################################
# File Name: iw.sh
# Author: Song Yuzhen
# mail: bensongsyz@gmail.com
# Created Time: 2019-06-18
#########################################################################
#!/bin/bash

sudo iw dev wlp5s0 interface add wlan1 type __ap
sudo ip link set dev wlan1 address 22:33:44:dd:66:00
sudo ip link set  wlan1 up

sudo create_ap wlan1 wlp5s0 ほんま・めいこ HonmaMeiko
