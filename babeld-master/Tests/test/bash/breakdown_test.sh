#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage : ./route.sh <nb_host>"
	exit 1
fi

var=$1
let $var 2>/dev/null
ret=$?
if [[ $ret -eq 1 ]]; then
	echo "arg must be unsigned Integer"
	exit 1
fi
#variables
hosts=$(seq 1 $var)
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

	./ping_test.sh $var

	for host in $hosts; do
		route["$host"]="${nroute["$host"]}"
	done

done
