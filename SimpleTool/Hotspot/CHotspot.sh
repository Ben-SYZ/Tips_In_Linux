#########################################################################
# File Name: CHotspot.sh
# Author: Song Yuzhen
# mail: bensongsyz@gmail.com
# Created Time: 2019-06-18
#########################################################################
#!/bin/bash

sudo ip link set wlan1  down

sudo iw dev wlan1 del
