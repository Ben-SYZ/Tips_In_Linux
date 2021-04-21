[the Default Applications wiki page](https://wiki.archlinux.org/index.php/Default_applications#perl-file-mimeinfo)

### 建立.desktop
在.desktop文件中`terminal=True` 会使用xterm打开（比如Vim）,但是我没有装xterm，想用alacritty或者其他terminal来打开，所以有两个解决办法：

1. 在`~/.local/share/applications`新建一个desktop entry 其中一行如下（也可以通过nemo添加，但是文件名和`Name`项要手动改不然之后认不出）
```desktop
# 文件名: 用于在mimeapps.list设置
# userapp-alacritty-nvim.desktop
Exec=alacritty -e nvim %f
# Name: 用于 nemo 下次选
Name=alacritty nvim
```

ps. 从终端启动程序
安装软件包 dex，并运行 dex /path/to/application.desktop. 

[ref](https://wiki.archlinux.org/index.php/Desktop_entries_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)#%E4%BB%8E%E7%BB%88%E7%AB%AF%E5%90%AF%E5%8A%A8%E7%A8%8B%E5%BA%8F)


2. 链接一个 xterm
```
ln -s /usr/bin/alacritty $HOME/.local/bin/xterm
```

### 然后设置默认的打开软件

文件类型名
```sh
#perl-file-mimeinfo
mimetype ./
#./:    inode/directory
```

设置默认打开方式
```sh
#https://bbs.archlinux.org/viewtopic.php?id=222344
xdg-mime query default inode/directory
xdg-mime default ranger.desktop inode/directory
```

最后的效果是在`~/.config/mimeapps.list`中改变的

```config
# 方式1 文件名
text/markdown=userapp-alacritty-nvim.desktop

# 方式2
text/markdown=nvim.desktop

# 另外文件管理
#inode/directory=ranger.desktop
#inode/directory=nemo.desktop
```

## 其他 nemo 'open in terminal'
```sh
gsettings set org.cinnamon.desktop.default-applications.terminal exec alacritty
```

[ref](https://unix.stackexchange.com/questions/336368/how-to-configure-nemos-right-click-open-in-terminal-to-launch-gnome-terminal)


