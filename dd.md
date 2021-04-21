```sh
fdisk 2020-02-13-raspbian-buster-lite.img -l

#Disk 2020-02-13-raspbian-buster-lite.img: 1.74 GiB, 1849688064 bytes, 3612672 sectors
#Units: sectors of 1 * 512 = 512 bytes
#Sector size (logical/physical): 512 bytes / 512 bytes
#I/O size (minimum/optimal): 512 bytes / 512 bytes
#Disklabel type: dos
#Disk identifier: 0x738a4d67
#
#Device                               Boot  Start     End Sectors  Size Id Type
#2020-02-13-raspbian-buster-lite.img1        8192  532479  524288  256M  c W95 FAT32 (LBA)
#2020-02-13-raspbian-buster-lite.img2      532480 3612671 3080192  1.5G 83 Linux
```

* 8192*512(B)/1024(KB)/1024(M)=4M
* 532479-8191=524288
* 524288*512(B)/1024(KB)/1024(M)=256M

* 532480*512/1024/1024=260M
	+ 65*4M
* (3612671-532479)*512/1024/1024=1504M
	+ 376*4M

dd if=2020-02-13-raspbian-buster-lite.img of=boot.img bs=4M skip=1 count=64 status=progress
dd if=2020-02-13-raspbian-buster-lite.img of=root.img bs=4M skip=65 count=376 status=progress


cat boot.img root.img > raspbian.img
