#!/bin/zsh
COUNTER=0
while [ "$COUNTER" -lt 5 ]
do
    echo $COUNTER;COUNTER=$(expr "$COUNTER" + 1);echo expr
    echo $COUNTER
done
