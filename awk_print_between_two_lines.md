
man page
line 1944 Example section
       15. Write all lines between occurrences of the strings start and
           stop:

               /start/, /stop/



man page 547
@Extended description#patterns
   Patterns
       A pattern is any valid expression, a range specified by two expressions separated by a comma, or one of the two special  patterns  BEGIN  or END.


---

https://stackoverflow.com/questions/17991209/awk-using-a-regex-statement-with-slashes-inside-action-braces

A string inside forward slashes is a regex string in `awk` like `/test/` not an operation just like the `match()` function is a function and not an operation. The syntax `/test/{print $0}` is short hand if `($0~/test/){print $0}` where ~ is the regexp comparison operator. This is when the condition is outside the block however. 



---

```sh
$ awk -F ':' '/usr/ {print $1}' demo.txt
root
daemon
bin
sys
```

上面代码中，print命令前面是一个正则表达式，只输出包含usr的行。

https://www.ruanyifeng.com/blog/2018/11/awk.html




----
To be read
https://www.linuxprobe.com/awk-begin-end.html
