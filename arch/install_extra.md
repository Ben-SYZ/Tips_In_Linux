/etc/vconsole.conf

```
keycode 1 = Caps_Lock
keycode 58 = Escape
```

## grub

* EFI
```
pacman -S grub efibootmgr intel-ucode os-prober
```

intel-ucode: update cpu 驱动 amd-ucode
os-prober: find other OS

* bios

```
pacman -S grub-bios
```

我用的是grub,因为syslinux没成功,虽然丑,但是挺简单的


```
mkdir /boot/grub
grub-mkconfig > /boot/grub/grub.cfg
```

### 确认架构并安装
[https://www.cnblogs.com/liangxiaofeng/p/4953891.html](https://www.cnblogs.com/liangxiaofeng/p/4953891.html)

```
uname -m
```

* EFI

```
grub-install --target=x86_64-efi --efi-directory=/boot
```

* BIOS

```
grub-install --target=i386-pc --recheck /dev/sda

grub-mkconfig -o /boot/grub/grub.cfg
```

<++>

## programs

```sh
pacman -S neovim vi zsh wps_supplicant dhcpcd
```



