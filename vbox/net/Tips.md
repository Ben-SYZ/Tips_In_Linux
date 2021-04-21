
Host C: resize mode


------
Net

1. port forwarding
```
VBoxManage modifyvm "VM name" --<net card> "<lable>,<tcp/udp>,<host ip>,<host port>,<guest ip>,<guest port>"
VBoxManage modifyvm "VM name" --natpf1 "guestssh,tcp,,2222,,22"
VBoxManage modifyvm "VM name" --natpf1 delete "guestssh"
```

2. create Nat net card
```
VBoxManage natnetwork add --netname natnet1 --network "192.168.15.0/24" --enable [--dhcpcd on]
# gateway 192.168.15.1
VBoxManage natnetwork remove --netname natnet1

# To start the NAT service
VBoxManage natnetwork start/stop --netname natnet1


# port forwarding
VBoxManage natnetwork modify --netname natnet1 --port-forward-4 "ssh:tcp:[]:1022:[192.168.15.5]:2"
VBoxManage natnetwork modify --netname natnet1 --port-forward-4 delete ssh

VBoxManage natnetwork modify --netname natnet2 --port-forward-4 "winssh:tcp:[]:22224:[192.168.100.4]:22"
VBoxManage natnetwork modify --netname natnet2 --port-forward-4 "archssh:tcp:[]:22225:[192.168.100.5]:22"
```
