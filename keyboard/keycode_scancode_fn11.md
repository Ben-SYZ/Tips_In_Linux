https://wiki.archlinux.org/index.php/Keyboard_input

I have keycode, but no scancode
sudo showkey -k

---


---
https://wiki.archlinux.org/index.php/Extra_keyboard_keys#Using_showkey


```
/usr/local/share/kbd/keymaps
```

```
/usr/share/X11/xkb/keycodes/evdev
```

<!--
```config
#https://wiki.archlinux.org/index.php/Linux_console/Keyboard_configuration
# tty(virtual console) https://en.wikipedia.org/wiki/Virtual_console
/usr/share/kbd/keymaps/i386/colemak/colemak.map.gz

# own
/usr/local/share/kbd/keymaps/colemak.map
keycode 1 = Caps_Lock
keycode 58 = Escape
```
-->
```config
/etc/vconsole.conf
KEYMAP=colemak
keycode 1 = Caps_Lock
keycode 58 = Escape
```



但是会被X11截断
所以X11要重新设置,直接换
```
/usr/share/X11/xkb/keycodes/evdev
```


从硬件上直接改
```config
#/usr/include/linux/input-event-codes.h 
# /etc/udev/hwdb.d/10-my-modifiers.hwdb
evdev:atkbd:dmi:*
 KEYBOARD_KEY_01=capslock   # esc
 KEYBOARD_KEY_3a=esc        # capslock
```

```sh
# To find device bus, vendor, product:
#https://gist.github.com/chp-io/f6b23248712a7884dddf3e766a8330dc
grep keyboard -B1 /proc/bus/input/devices 
#I: Bus=0011 Vendor=0001 Product=0001 Version=ab54
#N: Name="AT Translated Set 2 keyboard"
```

```config
#loadkeys.service
# /etc/keys.conf
keycode 1 = Caps_Lock
keycode 58 = Escape

# /etc/vconsole.conf
# comment out
# fcitx5 
```
