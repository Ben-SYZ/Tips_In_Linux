8a0c7dbe .home/.zshrc (Ben 2020-08-06 15:11:54 +0800 221) if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
8a0c7dbe .home/.zshrc (Ben 2020-08-06 15:11:54 +0800 222)   exec startx
8a0c7dbe .home/.zshrc (Ben 2020-08-06 15:11:54 +0800 223) fi
