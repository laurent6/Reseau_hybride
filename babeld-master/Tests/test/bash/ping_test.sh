#!/bin/bash

hosts="1 2 3 4 5 6 7"
failed=0

for host in $hosts; do
	ping -6 -w 1 -c 1 2001:db8:3c4d:"$host"::1 &> /dev/null
	if [ "$?" = 0 ]; then
		echo "Host address 2001:db8:3c4d:"$host::1" reachable"
	else
		echo "Host address 2001:db8:3c4d:"$host::1" unreachable"
		failed=1
	fi
done

echo ""
if [ "$failed" -eq 1 ]; then
	echo "One or more hosts unreachable"
else
	echo "All hosts reachable"
fi