1. (optional) Select a default controller with `select MAC_address`.

2. Enter `power on` to turn the power to the controller on. It is off by default and will turn off again each reboot.

3. Enter `devices` to get the MAC Address of the device with which to pair.

4. Enter device discovery mode with `scan on` command if device is not yet on the list.

5. Turn the agent on with `agent on` or choose a specific agent: if you press tab twice after `agent` you should see a list of available agents, e.g. DisplayOnly KeyboardDisplay NoInputNoOutput DisplayYesNo KeyboardOnly off on.

6. Enter `pair MAC_address` to do the pairing (tab completion works).

7. If using a device without a PIN, one may need to manually trust the device before it can reconnect successfully. Enter `trust MAC_address` to do so.

8. Enter `connect MAC_address` to establish a connection.

https://wiki.archlinux.org/index.php/Bluetooth_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)

---
power on
scan on
pair E4:...

---

----
Linux 系统接收通过蓝牙传输的文件
本文来自依云's Blog，转载请注明。

首先安装 bluez 包。我用的版本是 5.30。其次安装 blueman。

启动蓝牙服务：

1
systemctl start bluetooth.service
然后使用 blueman-manager 之类的命令启动 blueman。这时会在系统托盘看到蓝牙图标。点右键选择「添加新设备…」，完成配对。

然后，如果是要往手机发文件的话，是没有问题的，但是收的话，会失败。原因是，默认接收文件前会先询问用户要不要接收，而 blueman 不知道怎么搞的根本没反应……

解决方案是：直接启动一个默认接收文件的 obexd 就好了：

```sh
killall obexd
/usr/lib/bluetooth/obexd -r tmpfs -n -a
```

`-r`指定收到的文件存哪里，默认是 `$XDG_CACHE_DIR` 下的 `obexd` 目录，即默认是 `~/.cache/obexd`。这里的路径是相对于用户主目录的。

`-n`是不要以守护模式运行，会把日志输出到终端而不是系统日志。

`-a`就是重点——接收所有文件——了。

obex 这套东西的文档在/usr/share/doc/bluez/dbus-apis/下有。

Linux 下遇到点问题还真是折腾，声称完成某一功能的软件一大堆，结果装好了，要么根本不知道怎么用（gnome-bluetooth、bluedevil），要么适用版本不匹配（obexpushd、ArchWiki 等网上的过时信息），要么有 bug 用不了（blueman）。

https://blog.lilydjwg.me/2015/6/7/receive-files-over-bluetooth-in-linux.96155.html
