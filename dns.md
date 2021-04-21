systemctl status systemd-resolved.service

sudo systemd-resolved --flush-caches

 systemctl status systemd-resolved.service

dig baidu.com


---

sudo resolvectl flush-caches

dhcpcd will change /etc/resolv.conf
https://wiki.archlinux.org/index.php/Domain_name_resolution_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)

dhcpcd, NetworkManager, 以及许多别的程序能够覆盖 /etc/resolv.conf里的内容. 这样的行为通常是可取的, 但是有些时候DNS设置需要手动配置(比如使用静态IP时). 有几种方法可以实现. 如果你使用NetworkManager, 参见 this thread .

---

If you use DHCP and you do not want your DNS servers automatically assigned every time you start your network, be sure to add the following to the last section of /etc/dhcpcd.conf:

nohook resolv.conf

https://bbs.archlinux.org/viewtopic.php?id=45394


---

openresolv own dns server

/etc/resolveconf.conf

resolvconf -u

https://tangxinfa.github.io/article/archlinux-4e0b89e351b34e0a7f51616295ee9898.html
