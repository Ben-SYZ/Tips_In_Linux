```sh
sudo pacman -Fy
```
Then you can see which package contains `$filename` with

```sh
pacman -F $filename
```
if you are searching for an exact file name or full path, or

```sh
pacman -Fx $expr
```
to have `$expr` interpreted as a regular expression.

Since you knew you were looking for an equivalent of `apt-file`, you could have looked it up in the Pacman Rosetta.

Alternatively, you can use `pkgfile`. Install it with `pacman -S pkgfile`, then run

```sh
sudo pkgfile -u
```

to update the database. To see what package contains `$filename`, run

```sh
pkgfile $filename
```

```sh
apt search $filename
```
