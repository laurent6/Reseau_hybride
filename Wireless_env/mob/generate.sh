#!/bin/bash
echo "# time_s 1st_mn_id 2nd_mn_id status bandwidth_bps delay_s delay_var_% ber_proba attenuation_dBm distance_m" > perf.cnn
i=0
j=0
while [ $i -lt $1 ]
do
    echo "" >> perf.cnn
    echo "#Stop all connection : " >> perf.cnn
    j=$(($i*60))
    echo ""$j" 1 2 stop 00000000 0 0 0 94.4872 508.303" >> perf.cnn
    echo ""$j" 1 4 stop 00000000 0 0 0 94.4872 508.303" >> perf.cnn
    echo ""$j" 1 5 stop 00000000 0 0 0 94.4872 508.303" >> perf.cnn
    echo ""$j" 5 7 stop 00000000 0 0 0 94.4872 508.303" >> perf.cnn
    echo ""$j" 5 6 stop 00000000 0 0 0 94.4872 508.303" >> perf.cnn
    echo ""$j" 4 3 stop 00000000 0 0 0 94.4872 508.303" >> perf.cnn
    echo ""$j" 3 7 stop 00000000 0 0 0 94.4872 508.303" >> perf.cnn


    echo "" >> perf.cnn
    echo "#Start all connection : " >> perf.cnn
    i=$(($i+1))
    j=$(($i*60))
    echo ""$j" 1 2 start 18000000 0 0 0 94.4872 508.303" >> perf.cnn
    echo ""$j" 1 4 start 18000000 0 0 0 94.4872 508.303" >> perf.cnn
    echo ""$j" 1 5 start 18000000 0 0 0 94.4872 508.303" >> perf.cnn
    echo ""$j" 5 7 start 18000000 0 0 0 94.4872 508.303" >> perf.cnn
    echo ""$j" 5 6 start 18000000 0 0 0 94.4872 508.303" >> perf.cnn
    echo ""$j" 4 3 start 18000000 0 0 0 94.4872 508.303" >> perf.cnn
    echo ""$j" 3 7 start 18000000 0 0 0 94.4872 508.303" >> perf.cnn
    i=$(($i+1))
done

echo "" >> perf.cnn
echo "#Stop all connection : " >> perf.cnn
j=$(($i*60))
echo ""$j" 1 2 stop 00000000 0 0 0 94.4872 508.303" >> perf.cnn
echo ""$j" 1 4 stop 00000000 0 0 0 94.4872 508.303" >> perf.cnn
echo ""$j" 1 5 stop 00000000 0 0 0 94.4872 508.303" >> perf.cnn
echo ""$j" 5 7 stop 00000000 0 0 0 94.4872 508.303" >> perf.cnn
echo ""$j" 5 6 stop 00000000 0 0 0 94.4872 508.303" >> perf.cnn
echo ""$j" 4 3 stop 00000000 0 0 0 94.4872 508.303" >> perf.cnn
echo ""$j" 3 7 stop 00000000 0 0 0 94.4872 508.303" >> perf.cnn

echo "" >> perf.cnn
j=$(($j+1))
echo ""$j" EOS" >> perf.cnn
