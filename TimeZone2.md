# Net DHCP

1. dhcpcd.service

# time

1. set timezone

```sh
timedatectl set-timezone /Asia/Shanghai
```

2. sychcronize time by net

```sh
timedatectl set-ntp true
```

3. check status

```sh
timedatectl status
```
