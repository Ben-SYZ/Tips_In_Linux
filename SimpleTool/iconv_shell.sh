#!/usr/bin/bash
#echo "$#" != "2"

if [ "$#" != "2" ];then
	echo "Usage: `basename $0` dir filter"
	echo "Usage: If filter contains '*' '?', use \"\" to bracket it."
	exit
fi

dir=$1
filter=$2
echo $1
for file in `find $dir -name "$2"`;do
	echo "$file"
	iconv -f GB2312 -t UTF-8 $file -o $file
done
