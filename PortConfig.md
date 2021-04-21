# check the port configuration when port forwarding(端口转发)

```sh
netstat -pant

ss -pant
```


```sh
lsof :8090
sudo fuser 53/tcp
```

REMEMBER

```sh
#/etc/ssh/sshd_config
gateway = yes
```

