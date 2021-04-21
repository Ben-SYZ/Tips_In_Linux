sudo showkey --scancodes

```config
# https://wiki.archlinux.org/index.php/Map_scancodes_to_keycodes
# https://blog.lilydjwg.me/2019/10/28/poker-ii.214858.html
# /etc/udev/hwdb.d/10-my-modifiers.hwdb
evdev:atkbd:dmi:*
 KEYBOARD_KEY_01=capslock   # esc
 KEYBOARD_KEY_3a=esc        # capslock
# KEYBOARD_KEY_38=leftmeta        # leftalt
# KEYBOARD_KEY_7d=leftalt        # leftwin
# KEYBOARD_KEY_e05b=leftalt        # leftwin
```

sudo systemd-hwdb update
sudo udevadm trigger

