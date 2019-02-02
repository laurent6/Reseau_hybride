#!/bin/bash
if [ -z "$1" ]; then
	BATTERY=$(($RANDOM%100))
else
	BATTERY=$1
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
