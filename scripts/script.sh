#!/bin/bash

#<<<<<<< uncomment the following line to set proxy >>>>>>>>>>>>>
#export http_proxy="http://<username>:<password>@<proxy_url>:<port>"
#export https_proxy="https://<username>:<password>@<proxy_url>:<port>"

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

apt-get -y install subversion
apt-get -y install php5-mysql
