# https://cloud.tencent.com/developer/article/1174717

# https://www.raspberrypi.org/documentation/configuration/wireless/access-point-routed.md
# access point
sudo apt install hostapd
sudo systemctl unmask hostapd
sudo systemctl enable hostapd

# dns dhcp
sudo apt install dnsmasq

# netfilter-persistent  iptables-persistent
# iptables
sudo DEBIAN_FRONTEND=noninteractive apt install -y netfilter-persistent iptables-persistent

# ==========
# ip

#/etc/dhcpcd.conf
#interface wlan0
#    static ip_address=192.168.101.1/24
#    nohook wpa_supplicant

# enable routing, out net
# /etc/sysctl.d/routed-ap.conf
#net.ipv4.ip_forward=1


# -----------
# iptables
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
sudo netfilter-persistent save
# in /etc/iptables/

# -----------
# dhcpcd

#/etc/dnsmasq.conf
#interface=wlan0 # Listening interface
#dhcp-range=192.168.101.2,192.168.4.20,255.255.255.0,24h
#                # Pool of IP addresses served via DHCP
#domain=wlan     # Local wireless DNS domain
#address=/gw.wlan/192.168.101.1
                # Alias for this router


# hostapd
#/etc/hostapd/hostapd.conf
#country_code=CN
#interface=wlan0
#ssid=NameOfNetwork
#hw_mode=g
#channel=7
#macaddr_acl=0
#auth_algs=1
#ignore_broadcast_ssid=0
#wpa=2
#wpa_passphrase=AardvarkBadgerHedgehog
#wpa_key_mgmt=WPA-PSK
#wpa_pairwise=TKIP
#rsn_pairwise=CCMP

###====ReOpen
### /etc/dhcpcd.conf
sudo systemctl disable dnsmasq.service hostapd.service
reboot


#====
#list the connected devices on my wifi access point?
#https://unix.stackexchange.com/questions/40087/is-there-a-way-to-list-the-connected-devices-on-my-wifi-access-point
iw dev wlan0 station dump
sudo arp

cat /var/lib/misc/dnsmasq.leases

