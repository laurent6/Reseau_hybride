#!/bin/bash

echo "Usage : ./battery.sh <interface> [% of battery]"

# check interface
ifconfig $1 > /dev/null
if [ "$?" -eq 1 ]; then
	echo ""$1": No such device"
	exit
else
	ifconfig $1 up
fi

# check % of battery
if [ -z "$2" ]; then
		BATTERY=$(($RANDOM%100))
else
	if [[ "$2" =~ [0-9]+$ ]] && [ "$2" -ge 0 ] && [ "$2" -le 100 ]; then
		BATTERY=$2
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

	ifconfig $1 down
	sleep 20
	ifconfig $1 up

	while [ "$BATTERY" -lt 100 ]; do
		sleep 10
		BATTERY=$(($BATTERY+1))
		echo $BATTERY > battery
	done
done