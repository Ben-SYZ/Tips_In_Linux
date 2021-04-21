# screen lock
## Use `xautolock` to monitor screen activity
Then call the actual lock service.

```service
# /etc/systemd/system/xautolock@.service
[Unit]
Description=xautolock called i3lock or fancy-lock per 5 minutes, not suspend.
After=graphical.target

[Service]
Type=simple
# https://unix.stackexchange.com/questions/85244/setting-display-in-systemd-service-file
Environment=XAUTHORITY=/home/%I/.Xauthority
Environment=DISPLAY=:0
ExecStart=/usr/bin/xautolock -time 1 -locker "/usr/bin/systemctl start i3lock@%I.service" -detectsleep

[Install]
WantedBy=graphical.target
```

## `screenlock` service
### Steps
1. `xset -s 5`
2. `i3lock or fancylock`
3. `xset -s 5`

### Can be called by
1. `sleep.target`
2. `xautolock` service


```service
# /etc/systemd/system/i3lock@.service
[Unit]
Description=i3lock
Before=sleep.target

[Service]
User=%I
Type=forking
Environment=DISPLAY=:0
ExecStartPre=/usr/bin/xset s 5
ExecStart=/usr/bin/i3lock -i /home/%I/Pictures/LockScreen.png
#ExecStart=/usr/bin/i3lock-fancy
ExecStopPost=/usr/bin/xset s 290

[Install]
WantedBy=sleep.target
```


