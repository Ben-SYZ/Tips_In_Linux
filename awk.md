~ 匹配正则
!~ 不匹配正则
== 等于
!= 不等于

变量
```sh
variable="line one\nline two"
awk -v var="$variable" 'BEGIN {print var}'
line one
line two
```
