https://www.cnblogs.com/BlackStorm/p/Ubuntu-Switch-Keyboard-Layouts-Such-As-Colemak-Workman-Norman.html

```sh
setxkbmap us -variant colemak
setxkbmap us -variant workman
setxkbmap us -variant norman
```

```sh
# ubuntu
sudo dpkg-reconfigure keyboard-configuration

# arch
loadskeys colemak
```
