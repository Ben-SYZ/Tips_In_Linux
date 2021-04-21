Then you'll need to load the network block device module:

```
sudo rmmod nbd
sudo modprobe nbd max_part=16
```

Attach the .vdi image to one of the nbd you just created:

```
sudo qemu-nbd -c /dev/nbd0 drive.vdi
```
Now you will get a /dev/nbd0 block device, along with several /dev/nbd0p* partition device nodes.

```
sudo mount /dev/nbd0p1 /mnt
```
Once you are done, unmount everything and disconnect the device:

```
sudo qemu-nbd -d /dev/nbd0
```
