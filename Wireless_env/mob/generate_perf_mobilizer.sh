#!/bin/bash
if [ -z $1 ]; then
    echo "./generate.sh <nb_time>  <nb_hosts>"
    exit 1
fi
if [ -z $2 ]; then
    echo "./generate.sh <nb_time> <nb_hosts>"
    exit 1
fi
echo "# time_s 1st_mn_id 2nd_mn_id status bandwidth_bps delay_s delay_var_% ber_proba attenuation_dBm distance_m" > perf.cnn
v=0
j=-60
f=1
nb_host=$2
j=$(($j+60))
	echo "#Stop all connection : " >> perf.cnn
  for i in $(seq 1 $nb_host); do
      for l in  $(seq $(($i+1)) $nb_host); do
  	echo ""$j"" $i"" $l" stop 0 0 0 0 92.1281 387.408" >> perf.cnn
      done
  done


while [ $v -lt $1 ]
do

    if [ $j != 0 ]; then
	echo "#Stop all connection : " >> perf.cnn
	j=$(($j+60))
	i=0
	f=1
          for i in $(seq 1 $(($nb_host-1))); do
	    #echo ""$j" 1 2 stop 0 0 0 0 92.1281 387.408" >> perf.cnn
	    echo ""$j"" $i"" $(($i+1))" stop 0 0 0 0 92.1281 387.408" >> perf.cnn
	done
    fi

    i=0
    f=1
    echo "#Start all connection : " >> perf.cnn
    j=$(($j+59))
    for i in $(seq 1 $(($nb_host-1))); do
	    #echo ""$j" 1 2 stop 0 0 0 0 92.1281 387.408" >> perf.cnn
	    echo ""$j"" $i"" $(($i+1))" start 18000000 0 0 0 95.8241 592.88" >> perf.cnn
	done
    j=$(($j+1))
    i=0
    f=1
    for i in $(seq 1 $(($nb_host-1))); do
	    #echo ""$j" 1 2 stop 0 0 0 0 92.1281 387.408" >> perf.cnn
	    echo ""$j"" $i"" $(($i+1))" start 18000000 0 0 0 95.8241 592.88" >> perf.cnn
	done

    v=$(($v+1))
done
j=$(($j+59))
for i in $(seq 1 $nb_host); do
    for l in  $(seq $(($i+1)) $nb_host); do
	echo ""$j"" $i"" $l" start 18000000 0 0 0 95.8241 592.88" >> perf.cnn
    done
done



j=$(($j+1))
echo "$j EOS" >> perf.cnn
