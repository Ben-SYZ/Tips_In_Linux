https://wiki.archlinux.org/index.php/SSMTP

install ssmtp

https://blog.csdn.net/qq_20732247/article/details/107089175

```config
/etc/ssmtp/ssmtp.conf

root=<username>@163.com
mailhub=smtp.163.com:465
hostname=<your hostname>
AuthUser=<username>@163.com
AuthPass=<password> 				# 163服务密码
#TLS_CA_FILE=/etc/ssl/certs/ca-certificates.crt
UseTLS=Yes
#AuthMethod=LOGIN
#FromLineOverride=YES

# 不能 UseSTARTTLS=Yes
```


发件人配置

```config
/etc/ssmtp/revaliases

root:bensongsyz@163.com:smtp.163.com:465
pi:bensongsyz@163.com:smtp.163.com:465
```

Try:
```sh
echo -e 'Subject: test2\n\nhello' | sendmail -v xxx@gmail.com
```
