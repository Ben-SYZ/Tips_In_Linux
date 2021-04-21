
[[ is a bash built-in, and cannot be used in a #!/bin/sh script. 

[  ] == test
当"[ ]"中使用"-n"或者"-z"这些选项判断变量是否为空时，必须在变量的外侧加上双引号，才更加保险，与"test命令"的使用方法相同。

不过，使用"[[ ]]"时则不用考虑这样的问题


## 组合判断
`[[ && || ]]`
`[ -a -o ]`

## 比大小
### 数字
`[[ -gt -lt ]]`
`[ -gt -lt ]`


## 字符ASCII
`[[ < ]]`


---
https://blog.fpmurphy.com/2012/09/difference-between-and-in-shell-scripts.html
[[ $str == foo* ]]

is true if the str variable starts with foo but in the following conditional expression
[[ $str == "foo*" ]]

is only true if the str variable contains the literal four character string foo*.
