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
  # clean routing table
  ifdown ens3 >/dev/null 2>&1
  ifup ens3 >/dev/null 2>&1
  #start babel
  /root/reseau_hybride/babeld-master/babeld ens3 >/dev/null 2>&1 &
}
#find all neighboor
var=($(ping6 -I ens3 ff02::1 -c 5 ))
#filter really neighboor. In ping command we are local adress
filterResult var
declare -a neighInit
neighInit=("${tabFiltered[@]}")
# restart babel to avoid error
restartbabel

# In 5s We look at if we can contact all neighboor.
while true ; do
  for i in "${neighInit[@]}"
    do
      ping -6 -I ens3 $i -c 1 -w 6  >/dev/null
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
