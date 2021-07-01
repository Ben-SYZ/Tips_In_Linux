from adb tips

```sh
adb shell screencap /sdcard/phone_screenshort.dump
adb pull /sdcard/phone_screenshort.dump
# or
adb shell screencap > ./phone_screenshort.dump

# ps
adb shell screencap -p /sdcard/a.png
```


