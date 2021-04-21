```sh
pacman -Qei | awk '/^Name/ { name=$3 } /^Groups/ { if ( $3 != "base" && $3 != "base-devel" && $3 != "xorg" && $4 != "xorg" ) { print name } }'


pacman -Qdtq

pacman -D electron --asdeps
```
