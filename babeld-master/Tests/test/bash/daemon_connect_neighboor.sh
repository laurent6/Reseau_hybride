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
  killall -9 babeld >/dev/null 2>&1
  rm /var/run/babeld.pid >/dev/null 2>&1
  # clean routing table
  ifdown ens3 >/dev/null 2>&1
  ifup ens3 >/dev/null 2>&1
  #start babel
  ps -a | grep "babeld" >/dev/null 2>&1
  if [ "$?" = 1 ]
  then
    /root/reseau_hybride/babeld-master/babeld ens3 >/dev/null 2>&1 &
    ps -a | grep "babeld" >/dev/null 2>&1
    if [ "$?" = 1 ]
    then
      echo "Failed to start babel protocol"
      exit 1
    fi
  else
    echo "Error kill babel protocol"
    exit 1
  fi

}
#find all neighboor
var=($(ping6 -I ens3 ff02::1 -c 5 ))
#filter really neighboor. In ping command we are local adress

echo "Make sure that all link are up "
read -p "Press to enter to continue ..."
echo -ne "Scan neighboor ..."
filterResult var
echo " Done"
declare -a neighInit
neighInit=("${tabFiltered[@]}")
if [ ${#tabFiltered[@]} = 0 ]
then
  echo "No connectivity found"
  exit 1
fi
# restart babel to avoid error
echo -ne "First restart Babel ... "
restartbabel
echo " Done"

# In 5s We look at if we can contact all neighboor.
firstTime=false
echo " Begin listening link "
while true ; do
  res=1
  for i in "${neighInit[@]}"
  do
        ping -6 -I ens3 $i -c 1 -w 1 >/dev/null
        if [ "$?" = 0 ]
        then
          res=0
          firstTime=true
        fi
  done
  if [ "$res" = 1 ] && [ "$firstTime" = true ]; then
      echo -ne "Connectivity Down Restart Babel and clear routing table ... "
      restartbabel
      firstTime=false
      echo  " Done"
  fi
done
