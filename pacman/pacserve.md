#### install pacserve

```sh
yay -S pacserve
```

#### start

```sh
sysetmctl start pacserv
sysetmctl start pacserv-port
```

#### config

```sh
# 如果没有别的地方可以下db的话
ln -s /var/lib/pacman/sync/*.db /var/cache/pacman/pkg
```

```config
#/etc/pacman.conf
[core]
Include  = /etc/pacman.d/pacserve
Include = /etc/pacman.d/mirrorlist
...

# /etc/pacman.d/pacserve
# Adjust the port to match options in /etc/conf.d/pacserve
Server = http://localhost:15678/pacman/$repo/$arch
Server = http://[IP of B,C]:15678/pacman/$repo/$arch
# 或者不用Include, 直接把 Server 放到pacman.conf中
```


#### 原理和走的流程
pacserv 就像是建一个pacman的mirror,如果是虚拟机-物理机，物理机上装了就可以，虚拟机添加Server 就可以
https://xyne.archlinux.ca/projects/pacserve/

A B C 三台主机

```conf
[core]
Include  = /etc/pacman.d/pacserve
Include = /etc/pacman.d/mirrorlist
```

1. A查Include 1, 去另外几台机子BC上查`core.db`，如果有，就从那里下
2. A查Include 2, 在那里下

也会从`pacserve` 中去找BC的上级 `mirrorlist` 下，如果改过BC的 `mirrorlist` 得重启 `pacserve`，具体是哪个上级(自己A的还是BC的`mirrorlist` )优先不清楚。(如果同是`Include`,不会强制要求从1中下, `Server` 就会了)

<!--
TODO: 
deepinarch have alacritty
misaka do not have alacritty

install at vbox-arch

then
3 use different mirrorlist, wireshark
-->


