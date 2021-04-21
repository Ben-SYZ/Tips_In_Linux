
## client
curlftpfs ftp://example.com/ ~/example

## server
https://www.thegeekdiary.com/anonymous-user-fails-to-upload-file-to-vsftp-server/
vsftpd

ftp root: /srv/ftp/

**owner should be root:root** or then log in anonymous user will fail for security concern.
```
mkdir /srv/ftp/anon_upload
chown ftp:root
chmod 0777
```

```config
anonymous_enable=YES
write_enable=YES
anon_upload_enable=YES
anon_mkdir_write_enable=YES
dirmessage_enable=YES
xferlog_enable=YES
connect_from_port_20=YES
chown_uploads=YES
chown_username=ftp
chown_upload_mode=0660
anon_umask=022
listen=YES
pam_service_name=vsftpd

```




