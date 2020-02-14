# 命令行中连接 Wifi
## 检查是哪一个接口来支持无线连接的：

```sh
iwconfig
```

假定是wlan0，我的是wlp5s0

## 启动接口服务

```sh
sudo ip link set wlan0 up
```

## 扫描附近的无线网络了：

```sh
sudo iw dev wlan0 scan | less
```

## 连接

### 没有加密：

```sh
sudo iw dev wlan0 connect [网络 SSID]
```

### WEP 加密的：

```sh
sudo iw dev wlan0 connect [网络 SSID] key 0:[WEP 密钥]
```

### WPA or WPA2
1. `/etc/wpasupplicant/wpa_supplicant.conf` 文件，增加如下行：

network={    ssid="[网络 ssid]"    psk="[密码]"    priority=1}

`/etc/wpasupplicant/wpa_supplicant.conf`
```sh
country=CN
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
network={
	ssid="SSID"
	psk="Passwd"
	key_mgmt=WPA-PSK
	priority=9
	id_str="identify which wifi is"
}

network={
	ssid="SSID"
	psk="Passwd"
	key_mgmt=WPA-PSK
	priority=8
	id_str="identify which wifi is"
}
```

2. `sudo wpa_supplicant -i wlan0 -c /etc/wpa_supplicant/wpa_supplicant.conf`

## 通过 DHCP 获取IP

```sh
sudo dhcpcd wlan0
```

