

## X X11 Xorg Xserver xinit
[link](https://www.zhihu.com/question/47160292)

* X: X Window System(X視窗 **系統**)
* X11: X視窗系統 的最新 **标准**
* xorg: X11的一個最廣爲使用的 **實現**
* x server是X標準/協議的一部分（很可能x session也是）
	+ X11的規範中，圖形界面被設計爲Client-Server結構（經提醒，X的C/S結構和HTTP/WWW之類的C/S在表象上有區別【但接受了它的設定以後，其實是一回事】）：其中x server負責輸出（給顯卡）、接收鍵盤/鼠標的原始輸入等；而每個工作在x上的應用程序是一個x client，x server在接收到輸入後會將輸入發送到對應的x client。（另請見評論第一條。）
* x section: 一個x session代表了你某次啓動的X上的（可見和不可見的）所有東西；
* xinit是X的一個工具/軟件。它的功能就是啓動一個x server及啓動一個x client（

* DM WM DE (略)

./wm_de_dm.md


## `Xorg.conf`
### what is Identifier
[link](https://superuser.com/questions/1014502/how-to-find-the-identifier-value-for-an-xorg-conf-device-graphics-card-secti)

```sh
 X :1 -configure
 # /root/xorg.conf.new
```

The Identifier is a name that you give the Device. It is not evaluated by Xorg, *it is only used when you want to refer to that Device in any other Section, like Monitor or Screen.* For Devices that have no section in xorg.conf, *Xorg self-assigns names*, as you found out, starting with Card0. If you had two graphics cards, it would use Card1 for the second one.

### xorg.conf
```conf
Section "ServerLayout"
  Identifier "layout"
  Screen 0 "iGPU" # Device below
  Option "AllowNVIDIAGPUScreens"
EndSection

Section "Device"
  Identifier "iGPU"
  Driver "modesetting"
  BusID "PCI:0:2:0"
EndSection

Section "Screen"
  Identifier "iGPU"
  Device "iGPU"
EndSection

Section "Device"
  Identifier "dGPU"
  Driver "nvidia"
EndSection
```


