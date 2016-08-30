#!/bin/bash

export http_proxy=http://carol_pereira:August23Vm@hjproxy.persistent.co.in:8080
export https_proxy=https://carol_pereira:August23Vm@hjproxy.persistent.co.in:8080

apt-get -y update
apt-get install -y firefox xvfb python-pip subversion
pip install selenium
