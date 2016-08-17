#!/bin/bash

export http_proxy=http://santosh_dhanasure:psl15619%2383dob@ptproxy.persistent.co.in:8080
export https_proxy=https://santosh_dhanasure:psl15619%2383dob@ptproxy.persistent.co.in:8080

rm /var/lib/apt/lists/lock
rm /var/cache/apt/archives/lock

rm /var/lib/dpkg/lock
dpkg --configure -a

apt-get -y update
apt-get -y install vim

echo "mysql-server-5.5 mysql-server/root_password password root" | debconf-set-selections
echo "mysql-server-5.5 mysql-server/root_password_again password root" | debconf-set-selections
apt-get -y install mysql-server

sed -i -e 's/bind-address/#bind-address/g' /etc/mysql/my.cnf
sed -i -e 's/skip-external-locking/#skip-external-locking/g' /etc/mysql/my.cnf

#bind-address = 127.0.0.1
# skip-external-locking

service mysql start 


#mysql –u root -proot
#GRANT ALL PRIVILEGES ON *.* TO root@'%' IDENTIFIED BY 'root';
#FLUSH PRIVILEGES;

mysql -u root -proot -e "GRANT ALL PRIVILEGES ON *.* TO root@'%' IDENTIFIED BY 'root';"
mysql -u root -proot -e "FLUSH PRIVILEGES;"


#apt-get -y install zip
#apt-get -y install subversion
#svn export --non-interactive --trust-server-cert --username santosh_dhanasure@persistent.co.in --password psl15619\#83dob https://svn.persistent.co.in/svn/DevOps_Compt/CarolPereira/CaseStudy/UserMgmt.zip /var/tmp
#
#unzip /var/tmp/UserMgmt.zip -d /var/tmp

apt-get -y install zip
apt-get -y install subversion
svn export --non-interactive --trust-server-cert --username santosh_dhanasure@persistent.co.in (santosh_dhanasure@persistent.co.in) --password psl15619\#83dob https://svn.persistent.co.in/svn/DevOps_Compt/CarolPereira/CaseStudy/UserMgmt.zip /var/tmp
mkdir /var/tmp/test
unzip /var/tmp/UserMgmt.zip -d /var/tmp/test
mysql -u root -proot -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
mysql -h localhost -u root -proot $DB_NAME < /var/tmp/test/dbtuts.sql
rm -R /var/tmp/test
rm /var/tmp/UserMgmt.zip

#mysql -h localhost -u root -p root dbtuts < /var/tmp/UserMgmt/dbtuts.sql

#rm /var/tmp/UserMgmt.zip

