新增加一个用户并将其列入一个已有的用户组中需要用到 useradd 命令。如果还没有这个用户组，可以先创建该用户组。

命令参数如下：

```
useradd -G {group-name} username
#	-G, --groups GROUP1[,GROUP2,...[,GROUPN]]]
```

add to sudoer

```
usermod -a -G sudoer ben
visudo
```


