1. set group be 'sambashare' when creating new file/directory

```sh
chmod -R g+s ./
```

2. set default permission(like `umask`) for some directory.

```sh
setfacl -R -d -m group:sambashare:rwx ./
```

* `-d`: default, 继承
* `-m`: 设置后续的 acl 参数给文件使用

??? Question:
~~Default permission for a directory is 0777, for files the permissions are 0666.~~

~~Directory: 777~~
~~file: 666~~

effective is because `setfacl` first, `chmod -x` next

```
group:sambashare:rwx
Directory: 777 && .7. -> .7.
	default:group:sambashare:rwx
file:	   666 && .7. -> .6.
	group:sambashare:rwx		#effective:rw-
```


getfacl ./


