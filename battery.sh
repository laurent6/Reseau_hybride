#!/bin/bash
if [ -z "$1" ]; then
		BATTERY=$(($RANDOM%100))
else
	if [[ "$1" =~ [0-9]+$ ]] && [ "$1" -ge 0 ] && [ "$1" -le 100 ]; then
		BATTERY=$1
	else
		echo "Not a integer between 0 and 100"
		exit
	fi
fi

echo $BATTERY > battery

while true; do
	while [ "$BATTERY" -gt 0 ]; do
		sleep 10
		BATTERY=$(($BATTERY-1))
		echo $BATTERY > battery
	done
	
	while [ "$BATTERY" -lt 100 ]; do
		sleep 10
		BATTERY=$(($BATTERY+1))
		echo $BATTERY > battery
	done
done