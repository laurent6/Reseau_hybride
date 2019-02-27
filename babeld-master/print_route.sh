#!/bin/bash

t1=(date +%s)

while true ; do 
	ip -6 route 
	sleep 5s	
	t2=(date +%s)
	echo ""
	echo " Update" 
	echo ""
	sleep 1s
	clear
done 
