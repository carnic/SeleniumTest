!/bin/bash

CNAME="$1"
DBNAME="$2"
CID=$(docker inspect --format {{.Id}} $CNAME)
FILE_NAME="sshSetup.sh"

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
cp /var/tmp/$FILE_NAME $d1/var/tmp/
docker cp $CNAME:/var/tmp/$FILE_NAME $d1/var/tmp/$FILE_NAME
docker exec -it $CNAME /bin/sh -l -c "chmod +x /var/tmp/sshSetup.sh"
docker exec -it $CNAME /bin/sh -l -c "/var/tmp/sshSetup.sh"

CIP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $CNAME)
DBIP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $DBNAME)
cd /home/carolnp/carolP/chef-repo
knife bootstrap $CIP -x root -P pass -N grace11318 -r recipe[svnExport] --bootstrap-proxy http://carol_pereira:August23Vm@hjproxy.persistent.co.in:8080
docker exec -i $CNAME /bin/bash -c "sed -i -e 's/localhost/$DBIP:3306/g' /var/www/html/dbconfig.php"
docker exec -i $CNAME /bin/bash -c "sed -i -e 's/\"\"/\"root\"/g' /var/www/html/dbconfig.php"
