echo -e "power on\n" | bluetoothctl
/usr/lib/bluetooth/obexd -n -a
echo -e "power off\n" | bluetoothctl

