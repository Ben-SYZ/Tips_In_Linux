#https://stackoverflow.com/questions/47071256/how-to-update-upgrade-a-package-using-pip
 for i in $(pip list -o | awk 'NR > 2 {print $1}'); do sudo pip install -U $i; done
