#!/bin/bash

export http_proxy=http://santosh_dhanasure:psl15619%2383dob@ptproxy.persistent.co.in:8080
export https_proxy=https://santosh_dhanasure:psl15619%2383dob@ptproxy.persistent.co.in:8080

rm /var/lib/apt/lists/lock
rm /var/cache/apt/archives/lock

rm /var/lib/dpkg/lock
dpkg --configure -a

apt-get -y update
apt-get -y install zip
apt-get -y install wget

apt-get -y install vim

apt-get -y install apache2

#service apache2 start

apt-get -y install php5 libapache2-mod-php5 php5-mcrypt
sed -i -e 's/index.html/index.php/g' /etc/apache2/mods-enabled/dir.conf

#nzip -j /var/tmp/app.zip -d /var/www/html

apt-get -y install subversion
#svn export --username cnp --password psl15619\#83dob http://10.80.34.174:2145/svn/repository/testrepo/UserMgmt.zip /var/tmp/

svn export --non-interactive --trust-server-cert --username santosh_dhanasure@persistent.co.in --password psl15619\#83dob https://svn.persistent.co.in/svn/DevOps_Compt/CarolPereira/CaseStudy/UserMgmt.zip /var/tmp

unzip -j /var/tmp/UserMgmt.zip -d /var/www/html

apt-get -y install php5-mysql

service apache2 start
