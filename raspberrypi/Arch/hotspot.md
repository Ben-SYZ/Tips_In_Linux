## 1. bridge
```config
# https://wiki.archlinux.org/index.php/Software_access_point#Wi-Fi_link_layer
interface=wlp5s0
bridge=br0
ssid=XXXXXX
driver=nl80211
country_code=US

hw_mode=g
channel=7
max_num_sta=5
wpa=2
auth_algs=1

wpa_pairwise=CCMP
wpa_key_mgmt=WPA-PSK
wpa_passphrase=XXXXXXXXXX
logger_stdout=-1
logger_stdout_level=2
```

[link](https://wiki.archlinux.org/index.php/Network_bridge)
```sh
ip link add name bridge_name type bridge
ip link set bridge_name up
ip link set enp4s0 master bridge_name
ip link set wlp5s0 master bridge_name
bridge link

ip link set enp4s0 nomaster
ip link set wlp5s0 nomaster
ip link delete bridge_name type bridge
# change bridge_name to br0, then there is no need to add wlp5s0
```



## 2. NAT
**CARE**: before start dnsmasq,
```sh
sudo ip addr add 192.168.102.1/24 dev wlp5s0
# start automatically( more elegant ) when boot, check ./autoconnect.md
```

如果发现得到ip后马上掉线了，stop wpa_supplicant

```config
# /etc/hostapd/hostapd.conf
# comment bridge=br0
```



```config
# /etc/dnsmasq.conf
bind-interfaces
interface=wlp5s0 # Listening interface
dhcp-range=192.168.102.2,192.168.102.20,255.255.255.0,24h
                # Pool of IP addresses served via DHCP
domain=wlan    # Local wireless DNS domain
address=/gw.wlan/192.168.102.1
                # Alias for this router
dhcp-host=e8:9e:b4:12:dd:0b,192.168.102.1
dhcp-host=50:04:b8:46:76:fa,192.168.102.2
```

### Q&A
可以连同局域网，但是不能连通internet，

1. 
```sh
sudo sysctl net.ipv4.ip_forward=1
```

2. automatically systemd-networkd

