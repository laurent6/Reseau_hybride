#!/bin/bash
BATTERY=$(($RANDOM%100))
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
