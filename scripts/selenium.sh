#!/bin/bash

#<<<<<<< uncomment the following line to set proxy >>>>>>>>>>>>>
#export http_proxy="http://<username>:<password>@<proxy_url>:<port>"
#export https_proxy="https://<username>:<password>@<proxy_url>:<port>"

apt-get -y update
apt-get install -y firefox xvfb python-pip subversion
pip install selenium
