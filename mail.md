
<!--
exim
send mail

s-nail


mail -s 'subject' ben
...

mail can only sent to normal users no root

-->

```sh
yay -S sendmail
# send mails locally

yay -S s-nail
# receive mail locally
```


```sh
yay -S ssmtp
usermod -G mail -a $USER

```

```config
# /etc/ssmtp/ssmtp.conf
mailhub=smtp.163.com:465
hostname=<$HOST>
TLS_CA_FILE=/etc/ssl/certs/ca-certificates.crt
UseTLS=Yes
AuthUser=<your account name, xxxx@163.com>
AuthPass=<generate by 163 mail, not your password>
AuthMethod=LOGIN
FromLineOverride=YES
```


```config
# /etc/ssmtp/revaliases
# sender configuration, otherwise you need to append 'From' every time
<$USER>:xxxx@163.com:smtp.163.com:465
```


```sh
echo -e 'Subject: xxxx\n\n xxxxxx. \n\n xxxxx' | sendmail <receiver mail>
```


