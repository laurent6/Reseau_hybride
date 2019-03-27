#!/bin/bash
#Authors
#   Laurent BOUQUIN
#   Virgile CHATELAIN
#   Julien  MASSONNEAU
if [ -z "$1" ]; then
    echo "Usage : ./battery.sh <interface> [% of battery]"
    exit 1
fi



# time interval for battery update
time=5

# check if babeld exist
babeld_command="$(dirname $(realpath $0))/babeld"
if [ ! -f "$babeld_command" ]; then
	echo ""$babeld_command" : doesn't exist"
	exit
fi

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
		ifup "$1"
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
echo -n "Battery: "$battery"%   "

while true; do
	while [ "$battery" -gt 0 ]; do
		sleep "$time"
		battery=$(($battery-1))
		echo $battery > battery
		echo -ne "\rBattery: "$battery"%   "
	done

	# battery at 0%
	ifdown "$1"
	echo -e "\n\n"$1" interface downed"
	pkill babeld
	echo "babeld process killed"
	
	echo "----------"
	sleep "$time"
	
	echo "Restarting "$1" interface ..."
	ifup "$1"
	echo -e "Restarting babeld process ..."
	$babeld_command ens3

	while [ "$battery" -lt 100 ]; do
		sleep "$time"
		battery=$(($battery+1))
		echo $battery > battery
		echo -ne "\rBattery: "$battery"%   "
	done
done
