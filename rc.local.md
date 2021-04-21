# ArchLinux 下开机启动项目添加
[https://www.jianshu.com/p/7fbafa98caf4](https://www.jianshu.com/p/7fbafa98caf4)

```sh
# /usr/lib/systemd/system/rc-local.service

[Unit]
Description="/etc/rc.local Compatibility" 
#Wants=sshdgenkeys.service
#After=sshdgenkeys.service
#After=network.target

[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardInput=tty
RemainAfterExit=yes
SysVStartPriority=99

[Install]
WantedBy=multi-user.target
```

```sh
sudo vim /etc/rc.local 
sudo chmod +x /etc/rc.local
sudo systemctl enable rc-local.service
```
