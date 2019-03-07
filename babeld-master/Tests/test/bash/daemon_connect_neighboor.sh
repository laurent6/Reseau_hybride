#!/bin/bash
declare -a tabFiltered
isDownLink=1
filterResult()
{

  tab=($(eval echo $(echo \${$1[@]})))
  for i in ${tab[*]}
    do

      if  echo "$i" |grep "fe80" >/dev/null 2>&1;
      then
        res=($(ifconfig |grep "$(cut -d'%' -f1 <<<"$i")"))
        res2=($(echo "$i" | grep "fe80::2" ))

        if  [ -z $res ] && [ -z $res2 ]
        then
        tabFiltered[${#tabFiltered[*]}]=$(cut -d'%' -f1 <<<"$i")
        fi
      fi
    done


}

restartbabel()
{
  killall babeld >/dev/null 2>&1
  rm /var/run/babeld.pid >/dev/null 2>&1
  ifdown ens3 >/dev/null 2>&1
  ifup ens3 >/dev/null 2>&1
  /root/reseau_hybride/babeld-master/babeld ens3 >/dev/null 2>&1 &
}

var=($(ping6 -I ens3 ff02::1 -c 5 ))

filterResult var
declare -a neighInit
neighInit=("${tabFiltered[@]}")
restartbabel

while true ; do
  for i in "${neighInit[@]}"
    do
      ping -6 -I ens3 $i -c 1 -w 1  >/dev/null
      res=$?
      if [ "$res" = 0 ]  && [ "$isDownLink" = 0 ]; then
        isDownLink=1
      fi
      if [ "$res" = 1 ] && [ "$isDownLink" = 1 ]; then
          restartbabel
          isDownLink=0
      fi
    done
    sleep 5s
done
