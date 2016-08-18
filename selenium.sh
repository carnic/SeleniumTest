#!/bin/bash

#CNAME="$1"
#CID=$(docker inspect   --format {{.Id}} $CNAME)
#FILE_NAME="AutomationTest.sh"

#if [ -n "$CID" ] ; then
#    if [ -f  /var/lib/docker/image/aufs/layerdb/mounts/$CID/mount-id ] ; then
#        F1=$(cat /var/lib/docker/image/aufs/layerdb/mounts/$CID/mount-id)
#       d1=/var/lib/docker/aufs/mnt/$F1
#    fi
#    if [ ! -d "$d1" ] ; then
#        d1=/var/lib/docker/aufs/diff/$CID
#    fi
#    echo $d1
#fi

# Below code will work on node

#cp /var/tmp/$FILE_NAME $d1/var/tmp/
#docker cp $CNAME:/var/tmp/$FILE_NAME $d1/var/tmp/$FILE_NAME
#docker exec -it $CNAME /bin/sh -l -c "chmod +x /var/tmp/AutomationTest.sh"
#docker exec -it $CNAME /bin/sh -l -c "/var/tmp/AutomationTest.sh"

#docker cp $CNAME:/root/TestSuite/test_result.log /var/tmp/test_result.log
#sudo chmod 0777 /var/tmp/test_result.log

#echo "FAILED"

result=$(sed '$!d' /var/tmp/test_result.log)
#echo $result
if [ "$result" = "OK" ]; 
then
  echo "OK1";
else
  failedTests=$(echo $result| grep -o -E '[0-9]+')
#perc=$( echo "$failedTests/3" | bc -l)
#echo "Perci"
#echo $perc
#PerTestCasePass=$( echo "$perc * 100" | bc)
#echo $PerTestCasePass
#n=$(echo |awk '{ print 80*10.69}')
#n=$(echo |awk '{ print 100*$perc}')
#echo "Number"
#echo $n
#echo $(($passTestPerc)) | bc
#echo $(( $failedTests / 3 * 100))
#if [ $(( $failedTests / 3 * 100)) -gt 10 ];
#if [ if [ $(( $failedTests * 100 / 3)) -gt 10 ]; -gt 10 ];
  if [ $(( $failedTests * 100 / 3)) -gt 10 ];
  then
                #echo $result; 
		echo "FAILED";
  else
   	# echo $result; 
	echo "OK2";
  fi 
fi

