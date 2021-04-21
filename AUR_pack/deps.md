yay -S python-bs4 --asdeps

当有软件勾上它时，卸载那个软件，会带着它一起走


```sh
# ../pacman/list_package_name.md
pacman -Rns $(pacman -Qdtq)
pacman -D electron --asdeps
```
