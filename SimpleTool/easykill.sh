#!/bin/bash
# killall process
while true
do
	ps -ef | grep $1
	read -r -p "Are You Sure? [Y/n/s] " input

	case $input in
		[yY])
			echo "Yes"
			echo kill -9 $(pidof $1)
			kill -9 $(pidof $1)
			exit 1
			;;

		[nN])
			echo "No"
			exit 1
			;;
		[sS])
			echo "Some"
			echo "Choose:"
			pidof $1
			echo "--------------------------"
			read -r -p "input:	" pidtokill
			echo "--------------------------"
			ps -ef | grep $pidtokill
			read -r -p "Are You Sure To Kill The Process Above? [Y/n] " input

			case $input in
				[yY])
					kill -9 $pidtokill
					exit 1
					;;
				[nN])
					echo "No"
					exit 1
					;;
				#else
				*)
					echo "Invalid input..."
					exit 1
					;;
			esac
			exit 1
			;;

		*)
			echo "Invalid input..."
			;;
	esac
done
# -r ：在参数输入中，我们可以使用’/’表示没有输入完，换行继续输入，如果我们需要行最后的’/’作为有效的字符，可以通过-r来进行。此外在输入字符中，我们希望/n这类特殊字符生效，也应采用-r选项。

