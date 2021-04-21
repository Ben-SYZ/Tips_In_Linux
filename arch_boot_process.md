1. BIOS(UEFI) -> boot loader(at MBR or EFI)(grub etc.) -> Kernel...

## 1. Firmware
Burned on motherboard

* 启动方式
	+ BIOS
	+ UEFI
* 分区表
	+ GUID
	+ MBR(包含boot loader(启动加载器)和分区表)
		- On an MBR disk, the partitioning and boot data is stored in one place. If this data is overwritten or corrupted, you're in trouble. In contrast, GPT stores multiple copies of this data across the disk, so it's much more robust and can recover if the data is corrupted.


### BIOS
1. 自检
2. 初始化需要启动的硬件(硬盘，键盘...)
3. 启动MBR，并交控制权给它(The first 440 bytes of MBR are the bootstrap code area.) [link](#GUID分区表（GPT）)
4. MBR 接管后，执行它之后的第二阶段代码，如果有，一般是[boot loader](https://wiki.archlinux.org/index.php/Arch_boot_process#Boot_loader)(grub...)
5. 第二阶段代码会读取它的支持文件和配置文件。
	* 什么是Boot loader
		+ It is responsible for **loading the kernel** with the wanted *kernel parameters*, and initial RAM disk based on configuration files.
	* [GRUB 在哪](https://askubuntu.com/questions/142912/where-is-the-boot-loader-installed)
		+ GRUB (some of it) stays in the MBR.
		+ GRUB (rest of it) are several files that are loaded, from /boot/grub (for example: that nice image that appears as a background in GRUB is not stored on the MBR)
		+ 所以我们装grub(BIOS)的时候是`grub-install --target=i386-pc --recheck /dev/sda` 到硬盘的

### UEFI
1. 开机自检
2. UEFI *固件*加载，相关硬件
3. Firmware reads the boot entries in the **NVRAM** to determine *which* EFI application to launch and from *where* (e.g. from which disk and partition).
	+ 启动项(boot entries)可以是硬盘，这时固件(firmware)寻找EFI 系统分区，并尝试在后备启动路径中找到EFI应用程序(`\EFI\BOOT\BOOTX64.EFI (BOOTIA32.EFI)`)
4. 启动EFI应用
	+ boot loader(like grub) 或通过EFISTUB Arch 内核
	+ 其他


#### UEFI 的多重引导(多个EFI)
因为每个操作系统或者提供者都可以维护自己的 EFI 系统分区中的文件，同时不影响其他系统，所以 UEFI 的多重启动只是简单的运行不同的UEFI 程序，对应于特定操作系统的引导程序。这避免了依赖 chainloading 机制
[ref](https://wiki.archlinux.org/index.php/Dual_boot_with_Windows_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)#UEFI_/_BIOS_%E5%90%AF%E5%8A%A8%E7%AE%A1%E7%90%86%E5%99%A8%E9%99%90%E5%88%B6)


## 2. Boot loader(GRUB为例)
GRUB (GRand Unified Bootloader) is a multi-boot loader. 

### 2.1. BIOS 系统
#### GUID分区表（GPT）
BIOS/GPT配置中，必须使用 BIOS 启动分区(1M 分区，type: BIOS boot)。GRUB将`core.img`嵌入到这个分区。

* 此额外分区只由 GRUB 在 BIOS/GPT 分区方式中使用。对于 BIOS/MBR 分区方式，GRUB 会把`core.img`放到 MBR 后面的间隙中去。而在 GPT 分区表中是不能保证在第一个分区之前有这样一个可以使用的间隙的，所以要加这个分区。
* UEFI 系统也不需要这额外分区，因为它不需要嵌入启动扇区。UEFI 系统需要有EFI系统分区。

* 这个分区可以处于磁盘的前 2TB 空间中的任意位置，但需要在安装 GRUB 之前创建好。

* 第一个分区之前的空间也可以用作 BIOS 启动分区，但是这会违反 GPT 对齐规范。可以在 `fdisk` 或 `gdisk` 中创建一个从 34 扇区开始，一直到 2047扇区的分区，然后按照上述方式设置类型。为了让其它分区对齐，可以最后再创建此分区。
```
Device       Start      End  Sectors Size Type
/dev/sda1     2048     4095     2048   1M BIOS boot

```

#### MBR（主引导记录）
Usually the post-MBR gap (after the 512 byte MBR region and before the start of the first partition) in many MBR partitioned systems is 31 KiB when DOS compatibility cylinder alignment issues are satisfied in the partition table. However a post-MBR gap of about 1 to 2 MiB is recommended to provide sufficient room for embedding GRUB's `core.img`

### 2.2. UEFI 系统

您可能注意到在 grub-install 命令中没有一个 `<device_path>` 选项，例如 `/dev/sda`。事实上即使提供了 `<device_path>`，也会被 GRUB 安装脚本忽略，因为 UEFI 启动加载器不使用 MBR 启动代码或启动扇区。而是用EFI分区里的 `EFI/Boot/bootx64.efi`，固件通过启动项(boot entries) 或默认路径启动它

有好多有意思的设定
`/etc/grub.d/40_custom`
https://wiki.archlinux.org/index.php/GRUB_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)

## 3. Kernel
在 boot loader 加载 kernel 和可用的 initramfs 文件，并执行 kernel 之后，kernel 将 initramfs（初始RAM文件系统）压缩包解压缩到（然后清空）rootfs（初始根文件系统，特别是ramfs或tmpfs）。

## 4. initramfs
initramfs 之所以存在，是为了帮系统访问真正的根文件系统（参见 Arch filesystem hierarchy (简体中文)）。也就是说，那些硬件 IDE, SCSI, SATA, USB/FW 所要求的 kernel 模块，如果并没有内置在 kernel 里，就会被 initramfs 负责加载。

udev udev 是 Linux 内核的设备管理器。总的来说，它取代了 devfs 和 hotplug，负责管理 /dev 中的设备节点。同时，udev 也处理所有用户空间发生的硬件添加、删除事件，以及某些特定设备所需的固件加载

内核

## 5. Init 流程
在「早期用户空间」的最终环节里，真正的根文件系统被挂载好后，就会替换掉原来的伪根文件系统。接着 /sbin/init 被执行，同样也替换掉原来的 /init 进程。Arch 御用的 init 就是 systemd (简体中文).

## 6. Getty
init 为每一个 虚拟终端 调用 getty，前者一般有六个，每个虚拟终端都会初始化 tty 并请求输入用户名和密码。当在某虚拟终端输入用户名和密码后，其 getty 会通过 /etc/passwd 检查是否正确，如果正确，就接着调用 login, 此外 getty 也可能会改启动一个显示管理器。

## 7. 显示管理器(Display Manager)
显示管理器, 可以配置为代替原来的 getty 登录命令行提示符。

为了在引导后自动初始化显示管理器，必须通过systemd手动启用服务单元。 有关启用和启动服务单元的更多信息，请参见systemd＃使用单元。

## 8. Login
所谓的 login 程序会为用户启动一个设置了环境变量的「会话」，接着根据 /etc/passwd 的配置启动用户专用 shell。

在成功登录后，刚刚启动登录 shell 之前，login 程序显示 /etc/motd (message of the day) 。在这里，您可以显示服务条款，以提醒用户您的本地政策或您想告诉他们的任何内容。

## 9. Shell
一旦用户专用的 shell 启动了，它会在显示命令行提示符前，执行一个「有可执行性的配置文件」，比如 .bashrc. 如果用户有设定了 Start X at login, 原来那个「有可执行性的配置文件」会调用 startx or xinit.

## 10. GUI、 xinit 或者 wayland
