# Mounting DrvFs

In order to mount a Windows drive using DrvFs, you can use the regular Linux mount command. For example, to mount a removable drive D: as /mnt/d directory, run the following commands:

```sh
sudo mkdir /mnt/d
sudo mount -t drvfs D: /mnt/d
```

Now, you will be able to access the files of your D: drive under /mnt/d. When you wish to unmount the drive, for example so you can safely remove it, run the following command:

```sh
sudo umount /mnt/d
```
