
* 正常来说我ben(in sambashare)对当前文件夹，有w permission，所以我可以改hello的名字

```
drwxrwxr-x  7 root sambashare 4.0K Jun 27 00:00 .
drwxr-xr-x  5 root root       4.0K Jun 26 17:34 ..
drwxr-x--- 14 ben  ben        4.0K Jun 24 21:15 Ben
drwxr-xr-x  2 lhb  lhb        4.0K Jun 26 23:54 hello
drwxr-x---  8 lhb  lhb        4.0K Aug 25  2020 LuHongbei
```

`chmod 1775 .`

但是这里有个stick permission，t所以只有lhb和root可以修改
```
drwxrwxr-t  7 root sambashare 4.0K Jun 27 00:00 .
drwxr-xr-x  5 root root       4.0K Jun 26 17:34 ..
drwxr-x--- 14 ben  ben        4.0K Jun 24 21:15 Ben
drwxr-xr-x  2 lhb  lhb        4.0K Jun 26 23:54 hello
drwxr-x---  8 lhb  lhb        4.0K Aug 25  2020 LuHongbei
```

我可以创建，创建的文件是的permission是 ben:ben


-----

特殊位

https://chmodcommand.com/chmod-1770/

特殊位在最前面
4 Setuid 提权，当作root
2 Setgid
1 Sticky Bit 


### setuid S@user
http://cn.linux.vbird.org/linux_basic/Mandrake9.0/0220filemanager.php

* 用途：『当一个档案具有 SUID 的时候，同时 other 的群组具有可执行的权限，那么当 others 群组执行该程序的时候， other 将拥有该档案的 owner 的权限！』。
　　
```
[test@test test]$ ls -l /usr/bin/passwd /etc/shadow 
-r-s--x--x    1 root     root        13476 Aug  7  2001 /usr/bin/passwd 
-rw-------    1 root     root         2423 Jun 25 14:29 /etc/shadow 
```

我们以账号的密码文件来说明好了！注意上面的范例啰！可以看到的是， /etc/shadow 的权限是『只有 root 才能存取』呦！那么你会不会觉得很奇怪？明明我的一般用户可以自己修改密码呀！对不对？那么修改密码一定跟 /etc/shadow 这个档案有关，那么怎么回事呀！？使用者是如何修改 /etc/shadow 这个档案的呢？嗯！没错！就是使用 SUID 的功能啦！上面的例子说明了， /usr/bin/passwd 这个档案具有 SUID 的属性，那么当用户使用 /usr/bin/passwd 这个执行档时，在执行 pass word 修改的期间就具有 /usr/bin/passwd 这个档案的拥有者 root 的所属权限啰！所以，所以当一般使用者执行 passwd 的时候，将具有 root 的权限，所以他们也可以更改 /etc/shadow 的内容啰！那么由此也可以知道，由于这个 Set UID ( SUID ) 的主要功能是在『某个档案执行的期间具有档案拥有者的权限』，因此， s 就是替代上面提到的 x 这个可执行的位置啰！那万一该档案并没有 x 的属性呢？哈哈！问的好！那么该档案的属性就会将小写的 s 变成大写的 S 啦！ ( 这里即使暂时不了解也没有关系，等到过一阵子再回来看一看，你就会了解啦！ )

### setgid S@group
* 新建的不设成自己的组
* 用途：组里合作

### stickbid T@other
* 用途：samba /tmp

