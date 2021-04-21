sudo mkfontdir
sudo mkfontscale
fc-cache -f -v


unicode search:
	gucharmap

gnome-font-viewer: view



---
https://wiki.archlinux.org/index.php/Localization_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)/Simplified_Chinese_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)#%E4%B8%AD%E6%96%87%E5%AD%97%E4%BD%93

fontconfig position: ~/.config/fontconfig/fonts.conf

Notion: deepin will create `~/.config/fontconfig/conf.d.deepin` remember to remove it.

config file will load automatically, you can test by make some errors in the file.

after install you can try with `fc-match "monospace"`

