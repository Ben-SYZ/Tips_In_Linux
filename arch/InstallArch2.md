# 装完arch linux你该做什么(install Arch2)
| command                 | mean                             |
|-------------------------|----------------------------------|
| pacman -Syu[y]          | update programs(force)           |
| pacman -S base-devel    | 基础的工具                       |
| useradd -m -G wheel ben | -m 添加家目录 -G 添加到wheel     |
| visudo                  | 用vi 编辑sudoer(可以在之前ln -s) |


## 图形界面
xorg

```sh
sudo pacman -S xorg xorg-server
```

```sh
xorg-xinit
```

```
all
```


## 窗口管理器
deepin

sudo pacman -S deepin deepin-extra(计算器日历等)

启动
startx, display manager

pacman -Qs lightdm 查看dm（**display manager**）（login 界面）

### 配置
vim /etc/lightdm/lightdm.conf

找`greeter session = example-gtk-gnome` 取消注释改成lightdm-deepin-greeter

### 自启动
arch 自带：system d

```
sudo systemctl enable lightdm
```
### 启动
sudo systemctl start lightdm

### aur
yay
```
yay -S google-chrome
```

### firefox
pacman -S firefox
---

## suggest app
`tlp` 省电
字体
theniceboy/.config

## net netease-cloud-music
ysy -S netease-cloud-music

dwm

frame buffer 看图片
aski
