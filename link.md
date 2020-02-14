# ln

`sudo ln -s 源目录 目标快捷方式`
比如你要在/etc下面建立一个叫LXBC553的快捷方式，指向/home/LXBC，那就是
`sudo ln -s /home/LXBC /etc/LXBC553`


删除快捷方式：

```
# 删除软连接文件
rm -rf   symbolic_name 

# 删除软连接和真实数据
rm -rf   symbolic_name/
```



也可以用`unlink symbolic_name` 来删除快捷方式


