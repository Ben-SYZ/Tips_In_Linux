ls -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localetime
sudo hwclock --systohc
timedatectl set-local-rtc false
timedatectl set-timezone Asia/Shanghai
timedatectl status
