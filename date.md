```sh
  ➜  date -d "1970-01-01"
Thu Jan  1 12:00:00 AM CST 1970

➤ /etc/systemd
  ➜  date -d "Thu Jan  1 12:00:00 AM CST 1970 +14871 days"
Sun Sep 19 12:00:00 AM CST 2010

```


```sh
timedatectl set-local-rtc 1
sudo ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
sudo pacman -S ntp
sudo systemctl enable --now ntpd.service
```
