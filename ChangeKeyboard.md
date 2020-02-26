https://www.cnblogs.com/BlackStorm/p/Ubuntu-Switch-Keyboard-Layouts-Such-As-Colemak-Workman-Norman.html

# Change keyboard layout as colemak, and `<Esc>` with `<CapsLock>`

[toc]

## TLDR

```sh
# /etc/vconsole.conf
KEYMAP = colemak

# /usr/share/X11/xkb/keycodes/evdev
# exchange the keycodes of <esc> and <capslock>
```

## change to colemak
### In tty mode(include graphic)

```sh
# temporary
loadskeys colemak

# permanet
/etc/vconsole.conf
KEYMAP = colemak
```

### In graphic mode

```sh
# temporary
setxkbmap us -variant colemak
setxkbmap us -variant workman
setxkbmap us -variant norman
setxkbmap us
setxkbmap -layout us colemak

# permanet
# write the above to graphic config file
# like ~/.xinitrc
```

## map `Esc` with `CapsLock`

```sh
setxkbmap us -variant colemak
xmodmap -pke > .xmodmap
```

### show what key doing `event test`, change `esc` and `capslock`

```sh
xev
```

### add the following to i3

```
exec_always sleep 1; xmodmap ~/.xmodmap
```

### however i3 has something wrong, I need xmodmap by myself

```sh
# /usr/share/X11/xkb/keycodes/evdev
# exchange the keycodes of <esc> and <capslock>
```

```sh
# ubuntu
sudo dpkg-reconfigure keyboard-configuration
```
