#!/bin/bash


MGM_NODE="$1"
SQL_NODE1="$2"
SQL_NODE2="$3"
SVN_CRED="$4"
svn_user=$(echo $SVN_CRED |cut -d',' -f1)
svn_pass=$(echo $SVN_CRED |cut -d',' -f2)

mgm_ip=$(docker inspect -f '{{.NetworkSettings.IPAddress }}' $MGM_NODE)
node1_ip=$(docker inspect -f '{{.NetworkSettings.IPAddress }}' $SQL_NODE1)
node2_ip=$(docker inspect -f '{{.NetworkSettings.IPAddress }}' $SQL_NODE2)

docker exec -i $MGM_NODE /bin/bash -c "sed -i -e 's/MGM_NODE/$mgm_ip/g' /var/lib/mysql-cluster/config.ini"
docker exec -i $MGM_NODE /bin/bash -c "sed -i -e 's/SQL_NODE_1/$node1_ip/g' /var/lib/mysql-cluster/config.ini"
docker exec -i $MGM_NODE /bin/bash -c "sed -i -e 's/SQL_NODE_2/$node2_ip/g' /var/lib/mysql-cluster/config.ini"

docker exec -i $SQL_NODE1 /bin/bash -c "sed -i -e 's/MGM_NODE/$mgm_ip/g' /etc/my.cnf"
docker exec -i $SQL_NODE2 /bin/bash -c "sed -i -e 's/MGM_NODE/$mgm_ip/g' /etc/my.cnf"

docker exec -i $MGM_NODE /bin/bash -c "ndb_mgmd -f /var/lib/mysql-cluster/config.ini"

#docker exec -i $SQL_NODE1 /bin/bash -c "chmod 644 /etc/my.cnf"
docker exec -i $SQL_NODE1 /bin/bash -c "/usr/local/mysql/bin/ndbd"
docker exec -i $SQL_NODE1 /bin/bash -c "/etc/init.d/mysql start"

#docker exec -i $SQL_NODE2 /bin/bash -c "chmod 644 /etc/my.cnf"
docker exec -i $SQL_NODE2 /bin/bash -c "/usr/local/mysql/bin/ndbd"
docker exec -i $SQL_NODE2 /bin/bash -c "/etc/init.d/mysql start"

docker exec -i $SQL_NODE1 /bin/bash -c "/usr/local/mysql/bin/mysql -e \"GRANT ALL PRIVILEGES ON *.* TO root@'%' IDENTIFIED BY 'root';\""
docker exec -i $SQL_NODE1 /bin/bash -c '/usr/local/mysql/bin/mysql -e "FLUSH PRIVILEGES;"'

docker exec -i $SQL_NODE2 /bin/bash -c "/usr/local/mysql/bin/mysql -e \"GRANT ALL PRIVILEGES ON *.* TO root@'%' IDENTIFIED BY 'root';\""
docker exec -i $SQL_NODE2 /bin/bash -c "/usr/local/mysql/bin/mysql -e \"FLUSH PRIVILEGES;\""

docker exec -i $SQL_NODE1 /bin/bash -c "svn export --non-interactive --trust-server-cert --username $svn_user --password $svn_pass https://svn.persistent.co.in/svn/DevOps_Compt/CarolPereira/CaseStudy/UserMgmt.zip /var/tmp"

docker exec -i $SQL_NODE1 /bin/bash -c "mkdir /var/tmp/app"
docker exec -i $SQL_NODE1 /bin/bash -c "unzip /var/tmp/UserMgmt.zip -d /var/tmp/app"
docker exec -i $SQL_NODE1 /bin/bash -c "/usr/local/mysql/bin/mysql -e \"create database dbtuts;\""
docker exec -i $SQL_NODE1 /bin/bash -c "/usr/local/mysql/bin/mysql dbtuts < /var/tmp/app/dbtuts.sql"
docker exec -i $SQL_NODE1 /bin/bash -c "/usr/local/mysql/bin/mysql dbtuts -e \"ALTER TABLE users ENGINE=NDBCLUSTER;\""
docker exec -i $SQL_NODE1 /bin/bash -c "rm -R /var/tmp/app"
docker exec -i $SQL_NODE1 /bin/bash -c "rm /var/tmp/UserMgmt.zip"
