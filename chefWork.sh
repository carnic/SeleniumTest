!/bin/bash

CNAME="$1"
CID=$(docker inspect --format {{.Id}} $CNAME)
FILE_NAME="sshSetup.sh"
DB_C1="$2"
DB_C2="$3"
SVN_CRED="$6"

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
sed -i "/$CIP/d" /root/.ssh/known_hosts

cd "$5"
svn_user=$(echo $SVN_CRED |cut -d',' -f1)
svn_pass=$(echo $SVN_CRED |cut -d',' -f2)
svn_url=$(echo $SVN_CRED |cut -d',' -f3)
postfix=$(date +"%H%M%d")
sed -i -e "s/uname/$svn_user/" svncred.json
sed -i -e "s/pwd/$svn_pass/" svncred.json
sed -i -e "s,url,$svn_url," svncred.json
knife data bag create credsvn
knife data bag from file credsvn svncred.json
knife bootstrap $CIP -x root -P pass -N "grace$postfix" -r recipe[svnExport] --bootstrap-proxy "$4"
knife node delete "grace$postfix" -y
dbcontainerip1=$(docker inspect -f '{{.NetworkSettings.IPAddress }}' $DB_C1)
dbcontainerip2=$(docker inspect -f '{{.NetworkSettings.IPAddress }}' $DB_C2)
docker exec -i $CNAME /bin/bash -c "sed -i -e 's/NODE1_IP/$dbcontainerip1/g' /var/www/html/dbconfig.php"
docker exec -i $CNAME /bin/bash -c "sed -i -e 's/NODE2_IP/$dbcontainerip2/g' /var/www/html/dbconfig.php"
