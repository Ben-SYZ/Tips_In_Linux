# An Easy Way To Remove Programs Installed From Source In Linux
[https://www.ostechnix.com/an-easy-way-to-remove-programs-installed-from-source-in-linux/](https://www.ostechnix.com/an-easy-way-to-remove-programs-installed-from-source-in-linux/)

## Install Position(take `neovim` as example)

```
/usr/local/stow/neovim/
```

## Make Symbolic Link

```sh
cd /usr/local/stow/
sudo stow neovim
```

## Remove Symbolic Link

```sh
sudo stow --delete neovim
```

### Further: Remove Apps

```sh
sudo rm -fr /usr/local/stow/neovim
```

