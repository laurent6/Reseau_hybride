#!/bin/bash

echo "Usage : ./route.sh <host down>"

#variables
hosts="1 2 3 4 5 6"
declare -a route
declare -a nroute

#get route
for host in $hosts; do
		route["$host"]="$(route -6 | grep "2001:db8:3c4d:"$host"::1")"
done

while true; do

	sleep 5
	
	#check new route
	for host in $hosts; do
		nroute["$host"]="$(route -6 | grep "2001:db8:3c4d:"$host"::1")"
		
		if [ "${route["$host"]}" != "${nroute["$host"]}" ]; then
			if [ -z "${route["$host"]}" ]; then
				echo "new route:"
				echo "${nroute["$host"]}"
			else			
				echo "update route:"
				echo "${route["$host"]}"
				
				if [ -z "${nroute["$host"]}" ]; then
					echo "deleted"
				else
					echo "${nroute["$host"]}"
				fi
			fi
			echo ""
		fi
	done

	./ping_test.sh

	for host in $hosts; do
		route["$host"]="${nroute["$host"]}"
	done
	
done


