
Ubuntu18.04 关闭和开启图形界面

关闭用户图形界面，使用tty登录。

　　sudo systemctl set-default multi-user.target
　　sudo reboot

开启用户图形界面。

　　sudo systemctl set-default graphical.target
　　sudo reboot
