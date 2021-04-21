1. add Nat
```sh
VBoxManage natnetwork add --netname natnet2 --network "192.168.246.0/24" --enable  --dhcp on
#VBoxManage natnetwork modify --netname natnet2 --dhcp on
```

2. add dns
```sh
VBoxManage modifyvm "Windows 10 VL" --natdnshostresolver1 on
VBoxManage modifyvm "Arch Linux" --natdnshostresolver1 on
```
3. static ip
+ windows 
+ linux

```config
# /etc/dhcpcd.conf
interface enp0s3
static ip_address=192.168.246.2/24
static routers=192.168.246.1
static domain_name_servers=192.168.246.2
```

4. port forwarding
```sh
# port forwarding
VBoxManage natnetwork modify --netname natnet2 --port-forward-4 "ssh:tcp:[]:1022:[192.168.15.5]:2"
VBoxManage natnetwork modify --netname natnet2 --port-forward-4 delete ssh

VBoxManage natnetwork modify --netname natnet2 --port-forward-4 "winssh:tcp:[]:22224:[192.168.246.4]:22"
VBoxManage natnetwork modify --netname natnet2 --port-forward-4 "archssh:tcp:[]:22225:[192.168.246.5]:22"
```
