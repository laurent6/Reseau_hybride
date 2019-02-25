#!/bin/bash

t1=(date +%s)

while true ; do 
	ip -6 route 
	sleep 5s	
	t2=(date +%s)
	echo "\n\n\n\n\n\n\n"
	echo $t2 - $t1 
	echo "\n\n\n\n\n\n\n"
	sleep 1s
	clear
done 
