### positions
1. `~/.config/fcitx5/config`
	+ `./conf/classicui.conf` UI
	+ `./config` setting
2. `~/.local/share/fcitx5/`
	+ rime 字库，候选字数量
	+ theme 主题库

所以，现在config下都是配置文件了，.local 下都是数据文件了


### packages
```
fcitx5-configtool-git
fcitx5-git
fcitx5-qt5-git
fcitx5-rime-git
```

### 字库
```
fcitx5-pinyin-moegirl-rime
fcitx5-pinyin-zhwiki-rime
```

```sh
cp /usr/share/rime-data/zhwiki.dict.yaml /usr/share/rime-data/moegirl.dict.yaml ~/.local/share/fcitx5/rime/

# config
# ~/.local/share/fcitx5/rime/luna_pinyin.extended.dict.yaml   
```

### theme
```
https://github.com/search?q=fcitx5+theme&type=Repositories

git clone https://github.com/sxqsfun/fcitx5-sogou-themes
# copy to ~/.local/share/fcitx5/themes
# check name the ./xxx/theme.conf

# ~/.config/fcitx5/conf/classicui.conf
# replace the name
```
