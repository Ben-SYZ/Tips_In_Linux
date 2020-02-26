## hdd stop spin
## automatic, by `tlp`

```sh
# /etc/tlp.conf
DISK_SPINDOWN_TIMEOUT_ON_AC="0 12"
DISK_SPINDOWN_TIMEOUT_ON_BAT="0 12"
```

## manual, by `hdparm`
[https://blog.csdn.net/magaiou/article/details/92770845](https://blog.csdn.net/magaiou/article/details/92770845)

从 `man hdparm` 可知：

```sh
# -S 从1到240的值指定5秒的倍数，从而产生5秒到20分钟的超时。从241到251的值指定30分钟的1到11个单位，从而产生30分钟到5.5小时的超时。值252表示超时21分钟。
hdparm -S[num] /dev/hd*

# -y 强制IDE驱动器立即进入低功耗待机模式，通常会导致其降速。
hdparm -y /dev/hd*

# -Y 强制IDE驱动器立即进入最低功耗睡眠模式，导致其完全关闭。
hdparm -Y /dev/hd*
```


