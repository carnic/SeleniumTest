!/bin/bash

CNAME="$1"
#WANNAME="$2"
CID=$(docker inspect   --format {{.Id}} $CNAME)
FILE_NAME="AutomationTest.sh"

if [ -n "$CID" ] ; then
    if [ -f  /var/lib/docker/image/aufs/layerdb/mounts/$CID/mount-id ] ; then
        F1=$(cat /var/lib/docker/image/aufs/layerdb/mounts/$CID/mount-id)
       d1=/var/lib/docker/aufs/mnt/$F1
    fi
    if [ ! -d "$d1" ] ; then
        d1=/var/lib/docker/aufs/diff/$CID
    fi
    echo $d1
fi

# Below code will work on node
#sed -i '2i line="http://10.80.34.148:2392/"' /var/tmp/$FILE_NAME
url="$3"
sed -i "2i $url" /var/tmp/$FILE_NAME
cp /var/tmp/$FILE_NAME $d1/var/tmp/
docker cp $CNAME:/var/tmp/$FILE_NAME $d1/var/tmp/$FILE_NAME
docker exec -it $CNAME /bin/sh -l -c "chmod +x /var/tmp/AutomationTest.sh"
docker exec -it $CNAME /bin/sh -l -c "/var/tmp/AutomationTest.sh"

docker cp $CNAME:/root/TestSuite/test_result.log /var/tmp/test_result.log
sudo chmod 0777 /var/tmp/test_result.log
#CHostname=$(docker inspect --format '{{ .Config.Hostname }}' $WANNAME)
#ssh-keygen -R $CHostname
#echo "FAILED"

#result=$(sed '$!d' /var/tmp/test_result.log)
#echo $result
#if [ "$result" = "OK" ]; 
#then
#  echo "OK";
#else
#  failedTests=$(echo $result| grep -o -E '[0-9]+')
#  if [ $(( $failedTests * 100 / 3)) -gt 10 ];
#  then
#        #echo $result; 
#	echo "FAILED";
#  else
   	# echo $result; 
#	echo "OK";
#  fi 
#fi

