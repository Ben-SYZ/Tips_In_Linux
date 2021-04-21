```config
Port 22
Port 2201

Match User *,!<username> LocalPort 2201
	DenyUsers *

Match User <username>, LocalPort 2201
	PasswordAuthentication yes
```
