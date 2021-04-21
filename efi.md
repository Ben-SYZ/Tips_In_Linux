pacman -S linux
<!--
没必要装grub，linuz 是在linux里的
sudo grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=manjaro --recheck
-->

grub-mkconfig -o /boot/grub/grub.cfg


https://wiki.archlinux.org/index.php/GRUB_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)

if os-prober cannot work well try to install lsb-release
