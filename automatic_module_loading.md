https://wiki.archlinux.org/index.php/Kernel_module#Loading

```
/etc/modules-load.d/virtio-net.conf
# Load virtio_net.ko at boot
virtio_net
```


https://bbs.archlinux.org/viewtopic.php?id=146231

> Modules to be autoloaded at boot are now specified in /etc/modules-load.d/, and modules to be blacklisted are now specified in /etc/modprobe.d/.


