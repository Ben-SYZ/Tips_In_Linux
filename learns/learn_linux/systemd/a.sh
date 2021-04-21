sudo systemctl daemon-reload
sudo systemctl restart xautolock@ben.service
sudo systemctl status xautolock@ben.service

#sudo systemctl restart i3lock@ben.service
sudo systemctl status i3lock@ben.service

# /etc/systemd/system/xautolock@.service
# /etc/systemd/system/i3lock@.service
