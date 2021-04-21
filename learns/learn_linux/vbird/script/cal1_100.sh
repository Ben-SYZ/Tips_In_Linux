#!/bin/bash
# Program:
# Use loop to calculate "1+2+3+...+100" result.
# History:
# 2015/07/17 VBird First release
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
s=0 # 这是加总的数值变量
i=0 # 这是累计的数值,亦即是 1, 2, 3....
while [ "${i}" != "100" ]
do
i=$(($i+1))
# 每次 i 都会增加 1
s=$(($s+$i)) # 每次都会加总一次!
done
echo "The result of '1+2+3+...+100' is ==> $s"
