#!/bin/bash

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

