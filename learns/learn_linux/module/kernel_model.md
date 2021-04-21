https://wiki.archlinux.org/index.php/Kernel_module

Kernel modules are pieces of code that can be loaded and unloaded into the kernel upon demand. They extend the functionality of the kernel without the need to reboot the system.

## Obtaining information
Modules are stored in `/usr/lib/modules/kernel_release`. You can use the command `uname -r` to get your current kernel release version.

To show what kernel modules are currently loaded:
```sh
$ lsmod
```
To show information about a module:
```sh
$ modinfo module_name
```
To list the options that are set for a loaded module:
```sh
$ systool -v -m module_name
```
To display the comprehensive configuration of all the modules:
```sh
$ modprobe -c | less
```
To display the configuration of a particular module:
```sh
$ modprobe -c | grep module_name
```
List the dependencies of a module (or alias), including the module itself:
```sh
$ modprobe --show-depends module_name
```

## Automatic module loading with systemd
Today, all necessary modules loading is handled automatically by `udev`

manual:`/etc/modules-load.d`

## Manual module handling
To load a module:
```sh
modprobe module_name
```
To load a module by filename (i.e. one that is not installed in `/usr/lib/modules/$(uname -r)/)`:
```sh
insmod filename [args]
```
To unload a module:
```sh
modprobe -r module_name
```
Or, alternatively:
```sh
rmmod module_name
```
