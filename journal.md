谁说不清理啦。我的普通日志文件 logrotate 保留52周，journald 的保留2G，只有 pacman 的无限保留（因为只有一个不大的文件）。

sudo journalctl --vacuum-size=2G

---

```sh
sudo journalctl -p 3 -x
```


To get all errors for running services using journalctl:

$ journalctl -p 3 -xb

where -p 3 means priority err, -x provides extra message information, and -b means since last boot

https://unix.stackexchange.com/questions/332886/how-to-get-see-error-message-in-journald

```sh
sudo journalctl -u [yourunit]
```
