iwconfig

```
sudo iw dev wlp5s0 interface add wlan1 type __ap
sudo ip link set dev wlan1 address 22:33:44:dd:66:00
sudo iw dev wlan1 del
sudo ip link set  wlx200db030f5a4 down
sudo ip link set  wlx200db030f5a4 up
```

