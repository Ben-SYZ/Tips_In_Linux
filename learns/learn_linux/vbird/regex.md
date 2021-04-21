| 特殊符号    | 代表意义                                                    |
|-------------|-------------------------------------------------------------|
| `[:alnum:]` | 代表英文大小写字符及数字,亦即 0-9, A-Z, a-z                 |
| `[:alpha:]` | 代表任何英文大小写字符,亦即 A-Z, a-z                        |
| `[:blank:]` | 代表空白键与 [Tab] 按键两者                                 |
| `[:cntrl:]` | 代表键盘上面的控制按键,亦即包括 CR, LF, Tab, Del.. 等等     |
| `[:digit:]` | 代表数字而已,亦即 0-9                                       |
| `[:graph:]` | 除了空白字符 (空白键与 [Tab] 按键) 外的其他所有按键         |
| `[:lower:]` | 代表小写字符,亦即 a-z                                       |
| `[:print:]` | 代表任何可以被打印出来的字符                                |
| `[:punct:]` | 代表标点符号 (punctuation symbol),亦即:" ' ? ! ; : # \$...  |
| `[:upper:]` | 代表大写字符,亦即 A-Z                                       |
| `[:space:]` | 任何会产生空白的字符,包括空白键, [Tab], CR 等等             |
| `[:xdigit:]`| 代表 16 进位的数字类型,因此包括: 0-9, A-F, a-f 的数字与字符 |

```sh
grep [-A] [-B] [--color=auto] '搜寻字串' filename
-A :后面可加数字,为 after 的意思,除了列出该行外,后续的 n 行也列出来;
-B :后面可加数字,为 befer 的意思,除了列出该行外,前面的 n 行也列出来;
-A3 -B2


grep [-acinv] [--color=auto] '搜寻字串' filename
-c :计算找到 '搜寻字串' 的次数
-i :忽略大小写的不同,所以大小写视为相同
-n :顺便输出行号
-v :反向选择,亦即显示出没有 '搜寻字串' 内容的那一行!

[] 来搜寻集合字符
grep -n 't[ae]st' regular_express.txt

'^$' 
-v '^$' ”代表“不要空白行”,

# 重复次数
grep -n 'o\{2[,n]\}' regular_express.txt
```

###  sed
本身也是一个管线命令,可以分析 standard input 的啦
```sh
sed [-nefr] [动作]

-n : 但如果加上 -n 参数后,则只有经过 sed 特殊处理的那一行print

动作说明: [n1[,n2]]function
a : nl /etc/passwd | sed '2a drink tea' # 多行用 \
c : nl /etc/passwd | sed '2,5c No 2-5 numbers'
取代, c 的后面可以接字串,这些字串可以取代 n1,n2 之间的行!
d : nl /etc/passwd | sed '2,$d'
i : cat /etc/passwd | sed '2i drink tea' ”
p : nl /etc/passwd | sed -n '5,7p'
打印,亦即将某个选择的数据印出。通常 p 会与参数 sed -n 一起运行~
s : sed 's/要被取代的字串/新的字串/g'

```

直接修改文件内容

## 11.3 延伸正则表达式
延伸型正则表达式可以通过群组功能“ | ”来进行一次搜寻!
多了 + ？ | ()

