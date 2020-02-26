# Set default editror
## set the default editor in `bash` 
Add the following statement to `~/.bashrc`

```sh
export EDITOR=/usr/bin/nvim
```

## set default editor for `linux`
when I use `sudo visudo`, the setting for bash is not available. So I check the `/etc/alternatives/README` and `man update-alternatives`. I get the following 2 ways.

interactive

```sh
sudo update-alternatives --config editor
```

non-interactive

```sh
sudo update-alternatives --set editor /usr/local/bin/nvim
```

however 2 way said above is not available(not registered) for the programs which is built by myself.

## Final result
Force change it.
[shallowsky.com/blog/linux/ubuntu-default-browser.html](shallowsky.com/blog/linux/ubuntu-default-browser.html)

```sh
rm /etc/alternatives/editor
ln -s /usr/local/bin/nvim /etc/alternatives/editor
```

however `man editor` still link to `nano`
