sudo rfkill unblock bluetooth
sudo systemctl start bluetooth
echo -e "power on\n" | bluetoothctl
/usr/lib/bluetooth/obexd -n -r ~/Downloads/bluetooth -a
echo -e "power off\n" | bluetoothctl
sudo systemctl stop bluetooth
sudo rfkill block bluetooth
# power on
# scan on
# pair <device>

