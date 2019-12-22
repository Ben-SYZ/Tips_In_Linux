##文件名+内容
`grep -r "查询内容"  文件目录`

##只显示包含内容的文件名
`grep -r -l "查询内容"  文件目录`

##文件名+内容
`find 文件目录  -type f |xargs grep "查询内容"`

eg：
```sh
grep -r "version.app.xinyartech.com"  /data/nginx/conf.d
grep -r -l "version.app.xinyartech.com"  /data/nginx/conf.d
find /data/nginx/conf.d  -type f |xargs grep "version.app.xinyartech.com";
```
