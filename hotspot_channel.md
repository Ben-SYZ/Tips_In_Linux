https://wiki.gentoo.org/wiki/Hostapd


channel 就是信道， 在2.4GHz 下有挺多通道可以走 2412 ... 2484 MHz

挑一个不拥堵的信道
```sh
iw dev wlan0 scan|grep 'primary channel' |awk '{print $4}' |sort -n |uniq -c
```


```sh
iw list # list channel


iw reg set US #???
iw reg get US #???
```




