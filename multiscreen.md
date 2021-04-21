[https://www.cnblogs.com/WaterGe/p/12133555.html](https://www.cnblogs.com/WaterGe/p/12133555.html)

使用hdmi外接显示器

输入 xrandr 查看当前显示器接口

例如：megicbook 2018锐龙版显示有HDMI-A-0和eDP两个接口，eDP就是笔记本屏幕的显示接口

同步模式可以输入

xrandr --output HDMI-A-0 --mode 1920x1080 --same-as eDP --auto

其中1920x1080是我外接显示器的分辨率

扩展模式则可以输入

xrandr --output eDP --left-of HDMI-A-0 --auto

--left-of 就是eDP在HDMI的左面，对应的命令还有

--right-of 谁在谁的右面

--above 谁在谁的上面

--below 谁在谁的下面
