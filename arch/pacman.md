# pacman 
	aux 库？？

## -S
synchronize

```s
pacman -S vlc
```

### update
```sh
pacman -Sy
```

### update package database (force)

```sh
pacman -Syy
```

### upgrade

```sh
pacman -Su
```

### update and upgrade

```sh
pacman -Syu
```

### search

支持正则表达式
```sh
pacman -Ss vim
```

### remove packages
没网时可以重装。

```
sudo pacman -Sc
```

## -R

```sh
pacman -R vim
```

这样不好，因为会涉及依赖（dependencies),(auto install)

删除依赖
### remove dependencies

```sh
pacman -Rs vim
```

### remove global config

```sh
pacman -Rns vim
```

## -Q

```sh
pacman -Q | wc -l
```

wc: 统计有几个

### show my own programs

```sh
pacman -Qe|wc -l
```

### do not show the version

```sh
pacman -Qeq
```

### show the packages installed locally

```sh
pacman -Qs vim
```


## remove the dependencies

### show 

```sh
pacman -Qdt
```

### pipe

```sh
pacman -R $(pacman -Qdtq)
```

## config

```sh
vim /etc/pacman.conf
```

```
color
CheckSpace
ILoceCandy :game pacman
```

## change source list

```
[archlinuxcn]
SigLevel = Optional TrustedOnly
Include = /etc/pacman.d/archlinuxcn
```

```
[archlinuxcn]
SigLevel = Never
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch
```

## Search uninstall

```
pacman -Ss packages
```

