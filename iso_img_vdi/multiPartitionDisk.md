
https://superuser.com/questions/211338/how-to-mount-a-multi-partition-disk-image-in-linux

```sh
$ sudo kpartx -v -a file.iso
add map loop0p1 (253:17): 0 8382464 linear 7:1 2048
$ mount /dev/mapper/loop0p1 ./mnt_point
...  do something with the partition  ...
$ umount ./mnt_point
$ kpartx -d -v file.iso
del devmap : loop0p1
loop deleted : /dev/loop0
```
or:
```
$ sudo partx -a -v file.iso
partition: none, disk: file.iso, lower: 0, upper: 0
Trying to use '/dev/loop0' for the loop device
/dev/loop0: partition table type 'dos' detected
range recount: max partno=1, lower=0, upper=0
/dev/loop0: partition #1 added
$ mount /dev/loop0p1 ./mnt_point
...  do something with the partition  ...
$ umount /dev/loop0p1 ./mnt_point
$ sudo partx -d -v /dev/loop0
partition: none, disk: /dev/loop0, lower: 0, upper: 0
/dev/loop0: partition #1 removed
```

relative, vdi: qemu
