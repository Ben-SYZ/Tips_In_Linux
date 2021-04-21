[link](https://wiki.archlinux.org/index.php/Security#Lock_out_user_after_three_failed_login_attempts) 

```sh
faillock --reset --user username
```
```config
# /etc/security/faillock.conf
deny 6
```
