以下命令以root用户执行
1.创建一个启动service脚本

```sh
vim /etc/systemd/system/rc-local.service
```

```
[Unit]
Description="/etc/rc.local Compatibility" 

[Service]
Type=oneshot
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardInput=tty
RemainAfterExit=yes
SysVStartPriority=99

[Install]
WantedBy=multi-user.target
```

2.创建 /etc/rc.local 文件

```sh
vim /etc/rc.local
```

```sh
#!/bin/sh
# /etc/rc.local
if test -d /etc/rc.local.d; then
    for rcscript in /etc/rc.local.d/*.sh; do
        test -r "${rcscript}" && sh ${rcscript}
    done
    unset rcscript
fi
```

3.添加执行权限

```sh
chmod a+x /etc/rc.local
```

4.添加/etc/rc.local.d文件夹

```sh
mkdir /etc/rc.local.d
```

5.设置开机自启

```sh
systemctl enable rc-local.service
```

结尾：
sh脚本放在/etc/rc.local.d/里面就可以了
