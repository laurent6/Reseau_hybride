#!/bin/bash

echo "Usage : ./battery.sh [% of battery]"

# time interval for battery update
time=5

# check % of battery
if [ -z "$1" ]; then
		battery=$(($RANDOM%100))
else
	if [[ "$1" =~ [0-9]+$ ]] && [ "$1" -ge 0 ] && [ "$1" -le 100 ]; then
		battery=$1
	else
		echo "Not a integer between 0 and 100"
		exit
	fi
fi

echo $battery > battery
echo -n "Battery: "$battery"%"

while true; do
	while [ "$battery" -gt 0 ]; do
		sleep "$time"
		battery=$(($battery-1))
		echo $battery > battery
		echo -ne "\rBattery: "$battery"%"
	done

	while [ "$battery" -lt 100 ]; do
		sleep "$time"
		battery=$(($battery+1))
		echo $battery > battery
		echo -ne "\rBattery: "$battery"%"
	done
done