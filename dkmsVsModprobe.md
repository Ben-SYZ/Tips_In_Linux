https://askubuntu.com/questions/978313/what-is-the-difference-between-modprobe-and-dkms

## Modprobe
Loads and runs a kernel module

## dkms
Compiles and installs a kernel module from source for the specified kernel (current running kernel if none are specified.

## To autoload modules at boot(No this file)
Edit the file `/etc/modules`. add each module you want to load one per line.
