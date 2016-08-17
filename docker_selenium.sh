#!/bin/bash

#export http_proxy=http://santosh_dhanasure:psl15619%2383dob@ptproxy.persistent.co.in:8080
#export https_proxy=https://santosh_dhanasure:psl15619%2383dob@ptproxy.persistent.co.in:8080


#docker exec -it Container01enkins10Aug02 /bin/sh -l -c "/var/tmp/exec.sh"
#apt-get install zip

#cp /var/tmp/docker.sh /var/tmp/copied_from_docker.sh

#cp /var/tmp/exec.sh /var/lib/docker/aufs/mnt/07b404f385a0b4269c98e13066a9c72fa117b512d2c08e33c7d470731b29ae6a/var/tmp/
#docker cp Container01enkins10Aug02:/var/tmp/exec.sh /var/lib/docker/aufs/mnt/07b404f385a0b4269c98e13066a9c72fa117b512d2c08e33c7d470731b29ae6a/var/tmp/exec.sh
#docker exec -it Container01enkins10Aug02 /bin/sh -l -c "/var/tmp/exec.sh"


#cp /var/tmp/exec.sh /var/lib/docker/aufs/mnt/b70241f2c912713ddc5c30f93a0ec94fbbe086886b90e6f4e666c740c9898ec6/var/tmp/
#docker cp Launch-Container-15:/var/tmp/exec.sh /var/lib/docker/aufs/mnt/b70241f2c912713ddc5c30f93a0ec94fbbe086886b90e6f4e666c740c9898ec6/var/tmp/exec.sh
#docker exec -it Launch-Container-15 /bin/sh -l -c "/var/tmp/exec.sh"

#sudo rm /var/lib/apt/lists/lock
#sudo rm /var/cache/apt/archives/lock

#sudo rm /var/lib/dpkg/lock
#sudo dpkg --configure -a


#CID=$(docker inspect   --format {{.Id}} Launch-Container-17)

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

CNAME="$1"

CID=$(docker inspect   --format {{.Id}} $CNAME)
FILE_NAME="selenium.sh"

if [ -n "$CID" ] ; then
    if [ -f  /var/lib/docker/image/aufs/layerdb/mounts/$CID/mount-id ] ; then
        F1=$(cat /var/lib/docker/image/aufs/layerdb/mounts/$CID/mount-id)
       d1=/var/lib/docker/aufs/mnt/$F1
    fi
    if [ ! -d "$d1" ] ; then
        d1=/var/lib/docker/aufs/diff/$CID
    fi
#    echo $d1
fi

# Below code will work on node

cp /var/tmp/$FILE_NAME $d1/var/tmp/
docker cp $CNAME:/var/tmp/$FILE_NAME $d1/var/tmp/$FILE_NAME

docker exec -it $CNAME /bin/sh -l -c "/var/tmp/$FILE_NAME"

