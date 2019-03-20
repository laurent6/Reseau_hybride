#!/bin/bash
echo "# time_s 1st_mn_id 2nd_mn_id status bandwidth_bps delay_s delay_var_% ber_proba attenuation_dBm distance_m" > perf.cnn
i=0
j=-60

while [ $i -lt $1 ]
do

	echo "#Stop all connection : " >> perf.cnn
	j=$(($j+60))
	echo ""$j" 1 2 stop 0 0 0 0 92.1281 387.408" >> perf.cnn
	echo ""$j" 2 3 stop 0 0 0 0 92.1281 387.408" >> perf.cnn
	echo ""$j" 3 4 stop 0 0 0 0 92.1281 387.408" >> perf.cnn
	echo ""$j" 4 5 stop 0 0 0 0 92.1281 387.408" >> perf.cnn
	echo ""$j" 5 6 stop 0 0 0 0 92.1281 387.408" >> perf.cnn
	echo ""$j" 6 7 stop 0 0 0 0 92.1281 387.408" >> perf.cnn

    echo "#Start all connection : " >> perf.cnn
    j=$(($j+59))
    echo ""$j" 1 2 start 18000000 0 0 0 95.8241 592.88" >> perf.cnn
    echo ""$j" 2 3 start 18000000 0 0 0 95.8241 592.88" >> perf.cnn
    echo ""$j" 3 4 start 18000000 0 0 0 95.8241 592.88" >> perf.cnn
    echo ""$j" 4 5 start 18000000 0 0 0 95.8241 592.88" >> perf.cnn
    echo ""$j" 5 6 start 18000000 0 0 0 95.8241 592.88" >> perf.cnn
    echo ""$j" 6 7 start 18000000 0 0 0 95.8241 592.88" >> perf.cnn

    j=$(($j+1))
    echo ""$j" 1 2 start 18000000 0 0 0 95.8241 592.88" >> perf.cnn
    echo ""$j" 2 3 start 18000000 0 0 0 95.8241 592.88" >> perf.cnn
    echo ""$j" 3 4 start 18000000 0 0 0 95.8241 592.88" >> perf.cnn
    echo ""$j" 4 5 start 18000000 0 0 0 95.8241 592.88" >> perf.cnn
    echo ""$j" 5 6 start 18000000 0 0 0 95.8241 592.88" >> perf.cnn
    echo ""$j" 6 7 start 18000000 0 0 0 95.8241 592.88" >> perf.cnn
    i=$(($i+1))
done
j=$(($j+59))
echo ""$j" 1 2 start 18000000 0 0 0 95.8241 592.88" >> perf.cnn
echo ""$j" 1 3 start 18000000 0 0 0 95.8241 592.88" >> perf.cnn
echo ""$j" 1 4 start 18000000 0 0 0 95.8241 592.88" >> perf.cnn
echo ""$j" 1 5 start 18000000 0 0 0 95.8241 592.88" >> perf.cnn
echo ""$j" 1 6 start 18000000 0 0 0 95.8241 592.88" >> perf.cnn
echo ""$j" 1 7 start 18000000 0 0 0 95.8241 592.88" >> perf.cnn



echo ""$j" 2 3 start 18000000 0 0 0 95.8241 592.88" >> perf.cnn
echo ""$j" 2 4 start 18000000 0 0 0 95.8241 592.88" >> perf.cnn
echo ""$j" 2 5 start 18000000 0 0 0 95.8241 592.88" >> perf.cnn
echo ""$j" 2 6 start 18000000 0 0 0 95.8241 592.88" >> perf.cnn
echo ""$j" 2 7 start 18000000 0 0 0 95.8241 592.88" >> perf.cnn

echo ""$j" 3 4 start 18000000 0 0 0 95.8241 592.88" >> perf.cnn
echo ""$j" 3 5 start 18000000 0 0 0 95.8241 592.88" >> perf.cnn
echo ""$j" 3 6 start 18000000 0 0 0 95.8241 592.88" >> perf.cnn
echo ""$j" 3 7 start 18000000 0 0 0 95.8241 592.88" >> perf.cnn

echo ""$j" 4 5 start 18000000 0 0 0 95.8241 592.88" >> perf.cnn
echo ""$j" 4 6 start 18000000 0 0 0 95.8241 592.88" >> perf.cnn
echo ""$j" 4 7 start 18000000 0 0 0 95.8241 592.88" >> perf.cnn

echo ""$j" 5 6 start 18000000 0 0 0 95.8241 592.88" >> perf.cnn
echo ""$j" 5 7 start 18000000 0 0 0 95.8241 592.88" >> perf.cnn

echo ""$j" 6 7 start 18000000 0 0 0 95.8241 592.88" >> perf.cnn


j=$(($j+1))
echo "$j EOS" >> perf.cnn
