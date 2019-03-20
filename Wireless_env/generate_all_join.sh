#!/bin/bash
if [ -z $1 ]; then
    echo "./generate_all_join.sh <path_to_debian_image>  <session_name> <nb_host>"
    exit 1
fi
if [ -z $2 ]; then
    echo "./generate_all_join.sh <path_to_debian_image>  <session_name> <nb_host>"
    exit 1
fi
if [ -z $3 ]; then
    echo "./generate_all_join.sh <path_to_debian_image>  <session_name> <nb_host>"
    exit 1
fi

echo "InitNemu(session='$2', workspace='.', hdcopy=False)

# configuration host.
VHostConf('debian', localtime=None, k='fr', display='sdl', vga='std', enable_kvm=None, cpu='kvm64', m='1024')" > init_all_join.py
v=1
nb_host=$(($3+1))
declare -a hWic_array
while [ $v -lt $nb_host ]
do
echo " host$v : configuration"
echo "VHost('host$v', conf='debian', hds=[VFs('$1', 'cow',
tag='host1.img')],
nics=[VNic(), VNic()]) " >> init_all_join.py
echo "VAirWic(\"h"$v"wic\")" >> init_all_join.py
echo "SetAirMode(\"h"$v"wic\", \"adhoc\")" >> init_all_join.py
echo "Link(\"host$v:0\", \"h"$v"wic\")" >> init_all_join.py
echo "VSlirp('slirp$v', net='192.168.0.0/24')
Link(client='host$v:1', core='slirp$v')" >> init_all_join.py
hWic_array[$v]="'h"$v"wic'"
echo "" >> init_all_join.py

  v=$(($v+1))


done
i=0
l=0
echo "Add all link"
for i in $(seq 1 $(($nb_host-1))); do
    for l in  $(seq $(($i+1)) $(($nb_host-1))); do
	echo "Join(\"h"$i"wic\", \"h"$l"wic\")" >> init_all_join.py
    done
done
echo " generate mobilizer"
mob/generate_perf_mobilizer.sh 25 $(($nb_host - 1))
mv -f perf.cnn mob/

echo "Add import mobilizer"
echo -ne "MobNemu('perfMob', nodes=[" >> init_all_join.py
for i in $(seq 1 $nb_host); do

echo -ne "${hWic_array[$i]}" >> init_all_join.py
if [ $i -lt $(($nb_host-1)) ]; then
echo -ne ", " >> init_all_join.py
fi
done
echo "])" >> init_all_join.py
echo "ImportMobNemu('perfMob', 'mob/perf.cnn')" >> init_all_join.py
