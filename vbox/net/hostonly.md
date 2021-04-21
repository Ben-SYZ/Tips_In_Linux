
```sh
VBoxManage hostonlyif create vboxnet0
```

<!--
```config
# /etc/dhcpcd.conf
interface enp0s3
static ip_address=192.168.101.5/24
static routers=192.168.101.1
static domain_name_servers=192.168.101.1
```

-->

It seems that at this time .1 is the host IP.

`ip addr` get ip is 192.168.101.101


sudo dhcpcd vboxnet0 -S ip_address=192.168.135.1/24

VBoxManage hostonlyif ipconfig vboxnet0 --ip 192.168.135.2 --netmask 255.255.255.0
