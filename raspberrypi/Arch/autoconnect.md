<!--
https://wiki.archlinux.org/index.php/Netctl_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)

cp /etc/netctl/wlp5s0 /etc/netctl/

netctl start wlp5s0
netctl enable wlp5s0
-->

## Turn on the 2 adapter, and assign them IP
[link](https://wiki.archlinux.org/index.php/Systemd-networkd)

```config
/etc/systemd/network/wlan.network
[Match]
Name=wl*

[Network]
Address=192.168.101.1/24
DHCP=no

#[Route]
#Gateway=192.168.101.1# AFFECT THE ROUTE TABLE( exist if ping destination are not reachable )
##DNSSEC=no
```

```sh
/etc/systemd/network/eth.network
[Match]
Name=eth*

[Network]
DHCP=yes
#DNSSEC=no
```

## dnsmasq and hotspot
```config
# /etc/hostapd/hostapd.conf
interface=wlan0
#interface=wlan0_ap
#bridge=br0
ssid=xxxxxxxxxxx
#driver=nl80211
country_code=US

# 2.4g
hw_mode=g
# 5g(not work)
#hw_mode=a
channel=7
max_num_sta=5
wpa=2
auth_algs=1

wpa_pairwise=CCMP
wpa_key_mgmt=WPA-PSK
wpa_passphrase=xxxxxx
logger_stdout=-1
logger_stdout_level=0
```

```config
# /etc/dnsmasq.conf

bind-interfaces
#interface=wlan0_ap # Listening interface
interface=wlan0 # Listening interface
dhcp-range=192.168.101.2,192.168.101.20,255.255.255.0,24h
                # Pool of IP addresses served via DHCP
domain=wlan     # Local wireless DNS domain
address=/gw.wlan/192.168.101.1
               # Alias for this router

dhcp-option=3,192.168.101.1 #gateway
dhcp-host=xx:xx:xx:xx:xx:xx,192.168.101.1
dhcp-host=xx:xx:xx:xx:xx:xx,192.168.101.2
dhcp-host=xx:xx:xx:xx:xx:xx,192.168.101.3
dhcp-host=xx:xx:xx:xx:xx:xx,192.168.101.10
```
