```
DISPLAY=":0.0"
XAUTHORITY="/home/ben/.Xauthority"
XDG_RUNTIME_DIR="/run/user/1000"
DBUS_SESSION_BUS_ADRESS=unix:path=/run/user/1000/bus
*/1 * * * * date>>~/crontest
*/1 * * * * /home/ben/.config/i3/BatteryNotification.sh
```

% in cron means new line


```crontab
# Way 1
#DATEValue=date +%R
#* * * * *	/usr/bin/notify-send -t 5000 "$($DATEValue)" && exit 0

# Way 2
*/30 * * * *	/usr/bin/notify-send -t 5000 "$(/usr/bin/date +\%R)" && exit 0
```

https://unix.stackexchange.com/questions/29578/how-can-i-execute-date-inside-of-a-cron-tab-job
