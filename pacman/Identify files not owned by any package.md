https://wiki.archlinux.org/index.php/Pacman/Tips_and_tricks#Identify_files_not_owned_by_any_package

If your system has stray files not owned by any package (a common case if you do not use the package manager to install software), you may want to find such files in order to clean them up.

One method is to use
```sh
pacreport --unowned-files
```
as the root user from pacutils which will list unowned files among other details.

Another is to list all files of interest and check them against pacman:

```sh
# find /etc /usr /opt /var | LC_ALL=C pacman -Qqo - 2>&1 > /dev/null | cut -d ' ' -f 5-
```
