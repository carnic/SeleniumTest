#!/bin/bash

export http_proxy=http://santosh_dhanasure:psl15619%2383dob@ptproxy.persistent.co.in:8080
export https_proxy=https://santosh_dhanasure:psl15619%2383dob@ptproxy.persistent.co.in:8080

apt-get -y update
apt-get install -y firefox xvfb python-pip subversion
pip install selenium
