# Unervisal time
[https://blog.csdn.net/qq_40197828/article/details/79334158](https://blog.csdn.net/qq_40197828/article/details/79334158)


## 打开注册表编辑器

```
regedit
```

## 新建表项

在 `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\TimeZoneInformation`中新建`RealTimeIsUniversal`项目


* 64 位系统，“QWORD（64位）值”。
* 32 位系统，“DWORD（32位）值”。

它的大体意思是，硬件时间被作为全球统一时间。


## 修改表项值
然后双击这一条目，弹出“编辑 QWORD（64位）值”的对话框，确保选中了“十六进制”，然后将“数值数据”改为“1”。最后点击“确定”。
