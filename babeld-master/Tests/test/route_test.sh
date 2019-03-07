#!/bin/bash

#variables
hosts="1 2 3 4 5 6 7"
time_update=5
declare -a route
declare -a nroute

#get route
for host in $hosts; do
		route["$host"]="$(route -6 -n | grep "2001:db8:3c4d:"$host"::1")"
		#check if host have route		
		if [ -z "${route["$host"]}" ]; then		
			echo "no route for 2001:db8:3c4d:"$host"::1"
		else
			echo "${route["$host"]}"
		fi
done

while true; do

	sleep $time_update
	
	#check new route
	for host in $hosts; do
		nroute["$host"]="$(route -6 -n | grep "2001:db8:3c4d:"$host"::1")"
		
		if [ "${route["$host"]}" != "${nroute["$host"]}" ]; then
			#new route
			if [ -z "${route["$host"]}" ]; then
				echo "new route:"
				echo "${nroute["$host"]}"
			#deleted route
			elif [ -z "${nroute["$host"]}" ]; then
				echo "deleted:"
				echo "${route["$host"]}"
			#updated route
			else
				echo "updated route:"
				echo "${route["$host"]}"
				echo "${nroute["$host"]}"
		
			fi
			echo ""
		fi
	done

	for host in $hosts; do
		route["$host"]="${nroute["$host"]}"
	done

	echo "-----UPDATE-----"
	
done


