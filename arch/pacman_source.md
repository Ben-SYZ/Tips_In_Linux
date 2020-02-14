# 得到一台高效利器
```
sudo nano /etc/pacman.conf

after [multilib], add:

[archlinuxcn]
SigLevel = Never
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch
```

```sh
sudo pacman-mirrors -c China
```

```sh
# update
sudo pacman -Syyu
```

## Record Screen

```sh
sudo pacman -S simplescreenrecorder
```

```sh
# remove
pacman -Rs simplescreenrecorder
```

<++>

## screenkey

## Visal studio code

```sh
sudo pacman -S code
```

## pacman highlight
`/etc/pacman.conf`
line 36 uncomment color

## change shell
`fish`

chsh -s /usr/bin/fish

### oh my fish plugin
`curl -L http://get.oh-my.fish | fish`

### config it

```sh
fish_config
```

### oh my fish config

#### show the weather

```sh
omf install wttr
```

#### alias

```sh
alias c clear
funcsave c

alias l "ls -la"
funcsave l

# sudo -E save config??
alias sudo "sudo -E"
funcsave sudo
```

## i3

```sh
sudo pacman -S i3
> all

reboot
```

login window
setting

yeah!! I get in i3

### change font dpi

```sh
echo kXft.dpi: 200 >>  ~/.Xresources
reboot
```

### change in different window

mmod 1 2 3 

### split in vertical or horizental
mmod v h

???mmod t change from vertical to horizental

### full screen
mmod f full screenkey

### change between diff splits
mmode <direction>
mmode k l

## change gnome terminal to alacritty

```sh
alacritty
```

## dmenu

```sh
dmenu
```

$mod d: muti-choice of programs you can run

### set default terminal as alacritty
```sh
vim ~/.config/i3/config
> bindsym $mod+Return exec alacritty
```

```sh
# update i3 config
mod+shift+r
```

#### config alacritty (font size)

```sh
vim ~/.config/alacritty/alacritty.yml
```

## map keyboard
### ~/keys.conf

### xorg

```sh
pacman -S xorg
```

change something of the hardware properties

```sh
xmodmap
```

show the keycode 

```sh
xmodmap -pke > .xmodmap
```

show what key doing `event test`

```sh
xev
```

edit .xmodmap

```
# begin
clear control
clear lock
clear mod1

# end
add continue = Control_L Control_R
add mod1 = Alt_L
```

refresh

```sh
xmodmap ~/.xmodmap
```

## i3 again

```sh
$mod+Shift+q
```

### key mapping
### exec automatically when loading i3
### resize
### remove the ugly blue age


## change theme

```sh
sudo pacman -S lxappearance
lxappearance
```

## change back ground

```sh
pacman -S feh
pacman -S variety

variety
```

## semitransparent
variety support it

```sh
vim ~/.config/alacritty/alacritty.yml
> opacity
```

but i3 does not have this function. (xuan4 ran3 qi4)

```sh
pacman -S compton
compton
```

compton has changed its name? `picom`


## gap at edge

```sh
pacman -S i3-gaps
```

in i3 config

```
# at last
gaps inner 15
```

## exec automatically
`exec_always variety compton`


## usual programs
### Chinese input

```sh
pacman -S fcitx fcitx-im fcitx-configtool (all)
```

#### config

```sh
sudo pacman -S fcitx-[tab]
sudo pacman -S fcitx-sogoupinyin
# sogoupinyin not compatible?
# rime is also good?
```

```sh
vim ~/.xporfile

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"

reboot

<C-d>fcitx
```

### chromium
### edit vedio
kdenlive
### edit photo
gimp
### email
by browser
thunderbird

### office
libreoffice

### vedio
vlc

### virtual box
virtualbox

### chat
#### qq
deepin.com.qq.im
#### wechat
electronic-wechat
### install tool
sudo pacmaan -S transmission qbittorrent
### baidu net disk


### ranger
### game
steam

## polybar
If you have time. your hardware

```sh
# /.config/polybar
cp /usr/share/doc/polybar/config ~/.config/polybar
polybar example
```

```
height
font
```

```sh
#launch.sh
killall polybar
polybar example
```

i3 config

<++>

[toc]
