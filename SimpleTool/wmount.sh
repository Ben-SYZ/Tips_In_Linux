#!/usr/bin/bash

if [ "$#" != "2" ];then
	echo "Usage: `basename $0` X: dir"
	exit
fi

dirname=$2
if [ ! -d $dirname  ];then
	echo "mkdir $dirname"
	mkdir $dirname
fi

mount -t drvfs $1 $2
