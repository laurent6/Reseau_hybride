#!/bin/bash

#configuration interffaces
until [[ ${number_host} =~ ^[0-9]+$ ]]; do
echo "What is the host's number ?"
read number_host
done

cat /etc/network/interfaces | grep "ens3" >>/dev/null
if [ $? == 1 ]
then
	echo "auto ens3 
	iface ens3 inet6 static
        	address 2001:db8:3c4d:$number_host::1
        	netmask 64 " >> /etc/network/interfaces
	echo -ne "restart network ..."
	service networking restart
	echo "Done"
else
	cat /etc/network/interfaces | grep "2001:db8:3c4d:$number_host::1" >>/dev/null
	if [ $? == 1 ]; then
		(>&2 echo "Error : another configuration found please del this configuration and restart this installation")
		exit 1
	fi

fi

# Make sure that we can update and install with extern sources.
grep -v "cdrom" /etc/apt/sources.list > /etc/apt/sources.list.tmp
mv -f /etc/apt/sources.list.tmp /etc/apt/sources.list

# compile our protocol
tmp_path=$(pwd)
echo -ne "Compile babel protocol ... " 
cd  ../babeld-master && make >/dev/null
cd test_unit && make >/dev/null
cd $tmp_path
echo "Done"

#update
#apt update -y
#install killall usefull to test protocol
#apt-get install psmisc -y

