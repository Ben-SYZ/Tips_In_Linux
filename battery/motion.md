https://segmentfault.com/a/1190000012772062

linux下使用笔记本的相关设置
电源管理
--------

### 电源管理工具

-   桌面环境的电源管理工具

    桌面环境一般都有自己的电源管理工具，可设置对各种使用行为响应的电源动作
    ，如使用电池时的亮度、灭屏时间、挂起时间、睡眠时间、盖上笔记本盖子的响应动作、按下电源键的响应动作等等。

    可参看下文[电源相关行为的响应动作](#%E7%94%B5%E6%BA%90%E7%9B%B8%E5%85%B3%E8%A1%8C%E4%B8%BA%E7%9A%84%E5%93%8D%E5%BA%94%E5%8A%A8%E4%BD%9C)进行一些更为详细或者电源管理工具为提供的设置，推荐配合tlp或laptop-mode-tools使用。

-   [tlp](https://github.com/linrunner/TLP)

    多功能电源管理工具，其默认配置已经针对常见使用情况进行优化，安装后执行`systemctl enable tlp`
    使其开启自启动即可。如需进行更多配置，可修改/etc/default/tlp
    文件。另可再安装tlp-rdw用以设置无线设备。

    可参看[tlp英文文档](http://linrunner.de/en/tlp/docs/tlp-configuration.html#rdw)
    。

-   [laptop-mode-tools](https://github.com/rickysarraf/laptop-mode-tools)

    让内核开启适合的笔记本电脑的模式以达到相关电源控制的目的。功能较多，配置较tlp复杂，和tlp二选一即可。

    可参看[archwiki-Laptop Mode Tools
    (简体中文)](https://wiki.archlinux.org/index.php/Laptop_Mode_Tools_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)\#.E5.9B.BA.E6.80.81.E7.A1.AC.E7.9B.98)
    。

-   [powertop](https://github.com/fenrus75/powertop)
    intel处理器使用的电源管理工具。

    使用`sudo powertop --auto-tune`可启用所有选项，欲开机自启动`auto-tune`参看[powertop(简体中文)](https://wiki.archlinux.org/index.php/Powertop_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87))
    。

    提示：如果使用了tlp和laptop-mode-tools，几乎没必要再启用该工具，前二者功能覆盖了powertop的设置项。

-   thermald

    一个用于防止平台过热的守护进程。此守护进程会监控平台温度，并采用可用的冷却方式来降低温度。该软件安装即可，无需额外设置。

    提示：该工具**可能**过早启用风扇或风扇转速更快，从而带来较原使用情况下更大的噪音，宜根据设备具体情况和个人使用体验考虑是否使用。

### 电源相关行为的响应动作

这些行为及响应动作多能在桌面环境的电源管理工具中进行设置，参看[综合型电源管理工具](#%E7%BB%BC%E5%90%88%E5%9E%8B%E7%94%B5%E6%BA%90%E7%AE%A1%E7%90%86%E5%B7%A5%E5%85%B7)

#### 按键和盖子的响应动作

针对按下电源相关按钮（如挂起/休眠/电源等按键）和盖上笔记本盖子等行为而响应的电源动作。

systemd 能够处理某些电源相关的事件，编辑/etc/systemd/logind.conf
可进行配置，其主要包含以下事件：

-   HandlePowerKey：按下电源键
-   HandleSleepKey：按下挂起键
-   HandleHibernateKey: 按下休眠键
-   HandleLidSwitch：合上笔记本盖
-   HandleLidSwitchDocked：插上扩展坞或者连接外部显示器情况下合上笔记本盖子

取值可以是
ignore、poweroff、reboot、halt、suspend、hibernate、hybrid-sleep、lock
或 kexec。

其中：

-   poweroff和halt均是关机（具体实现有区别）
-   supspend是挂起（暂停），设备通电，内容保存在内存中
-   hybernate是休眠，设备断电（同关机状态），内容保存在硬盘中
-   hybrid-sleep是混合睡眠，设备通电，内容保存在硬盘和内存中
-   lock是锁屏
-   kexec是从当前正在运行的内核直接引导到一个新内核（多用于升级了内核的情况下）
-   ignore是忽略该动作，即不进行任何电源事件响应

注意，系统默认设置为：

    HandlePowerKey=poweroff    #按下电源键关机
    HandleSuspendKey=suspend    #按下挂起键挂起（暂停）
    HandleHibernateKey=hibernate    #按下休眠键休眠
    HandleLidSwitch=suspend    #盖上笔记本盖子挂起

例如要设置盖上笔记本盖子进行休眠，在该文件中配置：

    HandleLidSwitch=hibernate

保存文件后，执行 `systemctl restart systemd-logind` 使其生效。

注意：**一些Linux发行版可能需要自行对休眠进行配置，参考后文休眠配置**，或者借助pm-utils之类的工具实现。\
桌面环境带有的电源管理工具能管理上述（部分）动作的电源响应事件。

#### 电池低电量的响应动作

如希望在电池电量极低的时候自动关机，可以通过修改/etc/UPower/UPower.conf相关配置，示例，在电量低至%5时自动休眠：

    PercentageLow=15  #<=15%低电量
    PercentageCritical=10  #<=10%警告电量
    PercentageAction=5  #<=5%执行动作（即CriticalPowerAction)的电量
    CriticalPowerAction=PowerOff #(在本示例中是电量<=5%）执行休眠

CriticalPowerAction的取值有Poweroff、Hibernate和Hybid-sleep。

更多配置项参考该文件中的说明。

