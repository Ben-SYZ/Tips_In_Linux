echo 'all params 全部参数'
echo ${#@}
echo 'all params 全部参数'
echo $@
echo 'all params  全部参数'
echo $*
echo 'length of params 参数的长度'
echo $#
echo 'first param 第一个参数'
echo $1
echo 'last param 最后一个参数'
echo ${@:${#@}}
echo 'last 2 param 最后两个参数'
echo ${@:${#@}-1}
echo 'last 2nd param 倒数第二个参数'
echo ${@:${#@}-1:1}
echo 'from 2nd to last param 从第二个到最后一个参数'
echo ${@:2}
echo 'from 2nd, count 2 从第2个参数开始，连续2个参数'
echo ${@:2:2}
