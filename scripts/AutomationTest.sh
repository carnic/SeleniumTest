#!/bin/bash

export http_proxy="$1"
export https_proxy="$(echo $1 | sed 's/http/https/g')"

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
svn export --non-interactive --trust-server-cert --username carol_pereira@persistent.co.in --password August23Vm https://svn.persistent.co.in/svn/DevOps_Compt/CarolPereira/CaseStudy/test.py /root/TestSuite/test.py
python /root/TestSuite/test.py
killall Xvfb

