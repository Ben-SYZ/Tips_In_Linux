grub uefi

```sh
grub-install --target=x86_64-efi --efi-directory=esp --bootloader-id=GRUB
```
1. 挂载 EFI 系统分区，在本节之后的内容里，把 esp 替换成挂载点。
2. 选择一个启动引导器标识，这里叫做 GRUB。这将在 esp/EFI/ 中创建一个与标识同名的目录来储存 EFI 二进制文件，而且这个名字还会在 UEFI 启动菜单中表示 GRUB 启动项。
3. 执行下面的命令来将 GRUB EFI 应用 grubx64.efi 安装到 esp/EFI/GRUB/，并将其模块安装到 /boot/grub/x86_64-efi/。
