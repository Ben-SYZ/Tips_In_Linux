https://wiki.archlinux.org/index.php/Power_management_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)/Suspend_and_hibernate_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)

https://github.com/White-Oak/arch-setup-for-dummies/blob/master/hibernate-to-disk.md


### 添加内核参数
```conf
# /etc/default/grub
resume=UUID=a9954611-ed3c-457e-a4c6-a172842483e1
```

```sh
grub-mkconfig -o /boot/grub/grub.cfg
```

### 配置 initramfs
1. 添加resume钩子或systemd钩子 编辑/etc/mkinitcpio.conf，在HOOKS行中添加resume钩子或systemd钩子： 例如该行原有内容是：

```conf
HOOKS="base udev autodetect modconf block filesystems keyboard fsck"
# to
HOOKS="base udev resume autodetect modconf block filesystems keyboard fsck"
```

#### others
```conf
# /etc/UPower/UPower.conf相关配置.示例，在电量低至%5时自动休眠：

PercentageLow=15  #<=15%低电量
PercentageCritical=10  #<=10%警告电量
PercentageAction=5  #<=5%执行动作（即CriticalPowerAction)的电量
CriticalPowerAction=Hibernate #(在本示例中是电量<=5%）执行休眠
```

2. 重新生成 initramfs 镜像:

```sh
mkinitcpio -P
```
