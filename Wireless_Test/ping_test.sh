#!/bin/bash

hosts="1 2 3 4 5 6"
failed=0

for host in $hosts; do
	ping -6 -c 1 2001:db8:3c4d:"$host"::1 &> /dev/null
	if [ "$?" = 0 ]; then
		echo "Host address 2001:db8:3c4d::"$host" reachable"
	else
		echo "Host address 2001:db8:3c4d::"$host" unreachable"
		failed=1
	fi
done

echo ""
if [ "$failed" -eq 1 ]; then
	echo "Failed test"
else
	echo "Successful test"
fi

