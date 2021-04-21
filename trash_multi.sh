i=0
sleep 2
while true
do
	i=$(( $i+1 ))
	#echo $i
#sleep 2
#sleep 0.01
#xdotool key t
#sleep 0.01
#xdotool key r
#sleep 0.01
#xdotool key a
#sleep 0.01
#xdotool key s
#sleep 0.01
#xdotool key h
#sleep 0.01
#xdotool key minus
#sleep 0.01
#xdotool key r
#sleep 0.01
#xdotool key e
#sleep 0.01
#xdotool key s
#sleep 0.01
#xdotool key t
#sleep 0.01
#xdotool key o
#sleep 0.01
#xdotool key r
#sleep 0.01
#xdotool key e
#sleep 0.01
#xdotool key space
#sleep 0.01
#xdotool key dollar
#sleep 0.01
#xdotool key H
#sleep 0.01
#xdotool key O
#sleep 0.01
#xdotool key M
#sleep 0.01
#xdotool key E
#sleep 0.01
#xdotool key slash
#sleep 0.01
#xdotool key D
#sleep 0.01
#xdotool key o
#sleep 0.01
#xdotool key w
#sleep 0.01
#xdotool key n
#sleep 0.01
#xdotool key l
#sleep 0.01
#xdotool key o
#sleep 0.01
#xdotool key a
#sleep 0.01
#xdotool key d
#sleep 0.01
#xdotool key s
#sleep 0.01
#xdotool key Return
sleep 0.01
xdotool key Up
sleep 0.01
xdotool 0
xdotool key Return
sleep 0.1

	xdotool key 0
	xdotool key Return
	[ $i -gt 20 ] && exit 0
done
