
Ubuntu18.04 关闭和开启图形界面

关闭用户图形界面，使用tty登录。

```sh
　　sudo systemctl set-default multi-user.target
#created symlink /etc/systemd/system/default.target -> /lib/systemd/system/multi-user.target
　　sudo reboot
```

开启用户图形界面。

```sh
　　sudo systemctl set-default graphical.target
#created symlink /etc/systemd/system/default.target -> /lib/systemd/system/graphical.target
　　sudo reboot
```


```sh
# disable
systemctl disable gdm3

# re-enable
systemctl start gdm
apt --reinstall install gdm3
```
