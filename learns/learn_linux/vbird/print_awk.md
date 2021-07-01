## printf
```sh
printf '打印格式' 实际内容
\a 警告声音输出
\b 倒退键(backspace)
\f 清除屏幕 (form feed)
\n 输出新的一行
\r 亦即 Enter 按键
\t 水平的 [tab] 按键
\v 垂直的 [tab] 按键
\xNN NN 为两位数的数字,可以转换数字成为字符。(ascii 16 进制)

关于 C 程序语言内,常见的变量格式
%ns 那个 n 是数字, s 代表 string ,亦即多少个字符;
%ni 那个 n 是数字, i 代表 integer ,亦即多少整数码数;
%N.nf f 代表 floating (浮点)


printf '%10s %5i %5i %5i %8.2f \n' $(cat printf.txt | grep -v Name
```

##  awk
```sh
awk '条件类型1{动作1} 条件类型2{动作2} ...' filename
awk 主要是处理“每一行的字段内的数据”,而默认的“字段的分隔符号为 "空白键" 或 "[tab]键"

last -n 5 | awk '{print $1 "\t" $3}'

$0 代表“一整列数据”的意思

内置变量

| 变量名称 | 代表意义                        |
|----------|---------------------------------|
| NF       | 每一行 ($0) 拥有的字段总数      |
| NR       | 目前 awk 所处理的是“第几行”数据 |
| FS       | 目前的分隔字符,默认是空白键     |

last -n 5 | awk '{print $1 "\t lines: " NR "\t columns: " NF}'
# 注意双引号
cat /etc/passwd | awk '{FS=":"} $3 < 10 {print $1 "\t " $3}'

#这是因为我们读入第一行的时候,那些变量 $1, $2... 默认还是以空白键为分隔的,
cat /etc/passwd | awk 'BEGIN {FS=":"} $3 < 10 {print $1 "\t " $3}'

条件
cat pay.txt | \
> awk 'NR==1{printf "%10s %10s %10s %10s %10s\n",$1,$2,$3,$4,"Total" }
> NR>=2{total = $2 + $3 + $4
> printf "%10s %10d %10d %10d %10.2f\n", $1, $2, $3, $4, total}'
```


## patch

```sh
# a1 old,	a2 new
diff -Naur a1.txt a2.txt > a.patch
# update
patch -p0 < a.patch
# restore
patch -R -p0 <a.patch
```
