```sh
sudo cryptsetup open /dev/sdb2 benbackup
sudo mount /dev/mapper/benbackup /mnt

#sudo umount /mnt
#sudo cryptsetup close /dev/sdb2


./synchome.sh /home/ben/ backup/home/current [-w]
cd ./backup/home
btrfs subvolume snapshot -r current $(date +'%Y%m%d_%H%M')
btrfs subvolume delete ...

./syncroot.sh / backup/root/current [-w]
cd ./backup/root/
btrfs subvolume snapshot -r current $(date +'%Y%m%d_%H%M')
```
