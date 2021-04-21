
```sh
$? 亦为变量,是前一个指令执行完毕后的回传值。
standard output
standard error output

> 2> <

&& 前return 0 继续 || 前return 非零 继续
```


## 撷取命令: cut, grep

```sh
cut -d '分隔字符' -f fields
cut -c 字符区间[12-[20]]


grep [-acinv] [--color=auto] '搜寻字串' filename
-c :计算找到 '搜寻字串' 的次数
-i :忽略大小写的不同,所以大小写视为相同
-n :顺便输出行号
-v :反向选择,亦即显示出没有 '搜寻字串' 内容的那一行!


```

## 排序命令: sort, wc, uniq

```sh
# 排序
sort [-fbMnrtuk] [file or stdin]
-f :忽略大小写的差异,例如 A 与 a 视为编码相同;
-b :忽略最前面的空白字符部分;
-M :以月份的名字来排序,例如 JAN, DEC 等等的排序方法;
-n :使用“纯数字”进行排序(默认是以文字体态来排序的);
-r :反向排序;
-u :就是 uniq ,相同的数据中,仅出现一行代表;
-t :分隔符号,默认是用 [tab] 键来分隔;
-k :以那个区间 (field) 来进行排序的意思


# 重复的数据仅列出一个显示
uniq
-i :忽略大小写字符的不同;
-c :进行计数

wc [-lwm]
-l :仅列出行;
-w :仅列出多少字(英文单字);
-m :多少字符;
```

## 双向重导向: tee
```sh
tee [-a] file
```

## 字符转换命令: tr, col, join, paste, expand
```sh
# tr
tr [-ds] SET1 ...
-d :删除讯息当中的 SET1 这个字串;

last | tr '[a-z]' '[A-Z]'
tr -d '\r'

# col
-x :将 tab 键转换成对等的空白键


# join
join [-ti12] file1 file2
-t :join 默认以空白字符分隔数据,并且比对“第一个字段”的数据,
如果两个文件相同,则将两笔数据联成一行,且第一个字段放在第一个!
-i :忽略大小写的差异;
-1 :这个是数字的 1 ,代表“第一个文件要用那个字段来分析”的意思;
-2 :代表“第二个文件要用那个字段来分析”的意思。

# 先sort !!!
join -t ':' -1 4 /etc/passwd -2 3 /etc/group | head -n 3

# paste
paste [-d] file1 file2
选项与参数:
-d :后面可以接分隔字符。默认是以 [tab] 来分隔的!
- :如果 file 部分写成 - ,表示来自 standard input 的数据的意思。

# expand
这玩意儿就是在将 [tab] 按键转成空白键啦
expand [-t] file
-t :后面可以接数字。一般来说,一个 tab 按键可以用 8 个空白键取代。
# col 仅换8个
```

## 分区命令: split
大文件转小文件
```sh
split [-bl] file PREFIX
选项与参数:
-b :后面可接欲分区成的文件大小,可加单位,例如 b, k, m 等;
-l :以行数来进行分区。
PREFIX :代表前置字符的意思

# 新名：PREFIXaa xxxab xxxac
```

## 参数代换: xargs
```sh
xargs [-0epn] command
选项与参数:
-0 :如果输入的 stdin 含有特殊字符,例如 `, \, 空白键等等字符时,这个 -0 参数
可以将他还原成一般字符。这个参数可以用于特殊状态喔!
-e :这个是 EOF (end of file) 的意思。后面可以接一个字串,当 xargs 分析到这个字串时,
就会停止继续工作!
-p :在执行每个指令的 argument 时,都会询问使用者的意思;
-n :后面接次数,每次 command 指令执行时,要使用几个参数的意思。

# 可以通过 xargs 来提供该指令引用
```

## -
如果需要 stdout/stdin 时,但偏偏又没有文件, 有的只是 - 时,那么那个 - 就会被当成 stdin 或 stdout ~

stdout -> stdin 某些指令需要用到文件名称 (例如 tar) 来进行处理时,该 stdin 与 stdout 可以利用减号 "-" 来替代

```sh
tar -cvf - /home | tar -xvf - -C /tmp/homeback
```

,但打包的数据不是纪录到文件,而是传送到 stdout;







## others
```sh
cat -A 显示出所有特殊按键
```

