sysetmctl edit getty@tty1

```conf
#/etc/systemd/system/getty@tty1.service.d/override.conf
[Service]
ExecStart=
ExecStart=-/usr/bin/agetty --autologin <username> --noclear %I $TERM
```

https://wiki.archlinux.org/index.php/Getty_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)#%E8%87%AA%E5%8A%A8%E7%99%BB%E5%BD%95%E5%88%B0%E8%99%9A%E6%8B%9F%E6%8E%A7%E5%88%B6%E5%8F%B0

https://wiki.archlinux.org/index.php/Getty#Automatic_login_to_virtual_console

i3 start with i3clock
