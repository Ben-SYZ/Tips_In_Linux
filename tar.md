# *.tar.gz*格式和*.gz*格式文件解压命令

1. tar.gz文件解压

```sh
tar -zxvf java.tar.gz
```

或者解压到指定的目录里

```sh
tar -zxvf java.tar.gz -C ./java
```


2. gz文件的解压 gzip 命令

```sh
gzip -d java.gz
```

---
将文件全部打包成tar包：

```sh
tar -cvf log.tar log2012.log    仅打包，不压缩！ 
tar -zcvf log.tar.gz log2012.log   打包后，以 gzip 压缩 
tar -jcvf log.tar.bz2 log2012.log  打包后，以 bzip2 压缩 
```


---
http://blog.lujun9972.win/blog/2016/12/21/%E4%BD%BF%E7%94%A8tar%E4%BB%A3%E6%9B%BFcp%E8%BF%9B%E8%A1%8C%E6%8B%B7%E8%B4%9D/index.html
```sh
tar cvf - * | (cd /dest/dir && tar xvfp -)
```
这里第一个tar将文件打包后写入标准输出,然后通过管道传递给第二个tar,由第二个tar进行解压. 注意到第二个tar里面使用了 -p, 以保证文件权限不会被更改.

使用这种方式的好处除了可以保持文件的硬连接,创建时间,修改时间以及所有权以外,还可以做到 通过ssh复制到远程服务器上!

```sh
tar -cvf - * | ssh remote_host 'cd /dest;tar xvfp -'
```

这在没有`rsync`或`scp`时非常好用(不过这种情况应该很少见吧^_^).

当然,这种技巧也可以与find命令相结合

```sh
find . -depth |xargs tar cvf - | (cd ../tar_cp/ && tar xvfp -)
```
