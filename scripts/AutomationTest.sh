#!/bin/bash

#<<<<<<< uncomment the following line to set proxy >>>>>>>>>>>>>
#export http_proxy="http://<username>:<password>@<proxy_url>:<port>"
#export https_proxy="https://<username>:<password>@<proxy_url>:<port>"

rm -R /root/TestSuite
mkdir /root/TestSuite
touch /root/TestSuite/config.py
echo "url='$line'" > /root/TestSuite/config.py
apt-get install -y killall
#apt-get update
#apt-get install -y firefox xvfb python-pip subversion
#pip install selenium
nohup Xvfb :10 -ac &
export DISPLAY=:10
firefox --safe-mode &

#<<<<<<< uncomment the following line to set proxy >>>>>>>>>>>>>
#svn export --non-interactive --trust-server-cert --username <svn_username> --password <svn_password> <svn_location_of_test.py> /root/TestSuite/test.py

python /root/TestSuite/test.py
killall Xvfb

