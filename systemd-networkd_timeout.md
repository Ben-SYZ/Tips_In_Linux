/etc/systemd/system/systemd-networkd-wait-online.service.d/wait-for-only-one-interface.conf
```conf
[Service]
ExecStart=
ExecStart=/usr/lib/systemd/systemd-networkd-wait-online --any
TimeoutSec=10
```
