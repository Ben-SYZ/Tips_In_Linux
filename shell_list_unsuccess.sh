#!/bin/bash
#https://cloud.tencent.com/developer/article/1455227
declare -A PLAYERLIST
PLAYERLIST=(  )
#PLAYERLIST=( [netease-cloud-music]='stopped' [chromium]='paused' )

#echo "${PLAYERLIST[*]}"
#
#for status in ${PLAYERLIST[@]};
#do
#	echo "$status";
#done

playerctl --all-players metadata --format '{{playerName}} {{lc(status)}}'|\
	while read in; do 
		playerName=$(echo "$in" | cut -f 1 -d " ");
		playerStatus=$(echo "$in" | cut -f 2 -d " ");
		#echo [$playerName]=\'$playerStatus\';
		PLAYERLIST=( [netease-cloud-music]='stopped' [chromium]='paused' )
		break
		#echo $in;
	done
echo "${PLAYERLIST[*]}"
