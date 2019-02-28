#!/bin/bash

echo "Usage : ./battery.sh <interface> [% of battery]"

# time interval for battery update
time=5

# check interface
if [ -z "$1" ]; then
	echo "Please, specify an interface"
	exit
else
	ifconfig $1 > /dev/null
	if [ "$?" -eq 1 ]; then
		echo ""$1": No such device"
		exit
	else
		echo "Restarting networking service ..."
		service networking restart
	fi
fi

# check % of battery
if [ -z "$2" ]; then
		battery=$(($RANDOM%100))
else
	if [[ "$2" =~ [0-9]+$ ]] && [ "$2" -ge 0 ] && [ "$2" -le 100 ]; then
		battery=$2
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

	echo -e "\n"$1" interface downed"
	ifconfig $1 down
	sleep "$time"
	echo "Restarting "$1" interface ..."
	service networking restart

	while [ "$battery" -lt 100 ]; do
		sleep "$time"
		battery=$(($battery+1))
		echo $battery > battery
		echo -ne "\rBattery: "$battery"%"
	done
done