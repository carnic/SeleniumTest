export https_proxy="https://carol_pereira:July13Dday@hjproxy.persistent.co.in:8080"
export http_proxy="http://carol_pereira:July13Dday@hjproxy.persistent.co.in:8080"
mkdir /root/TestSuite
apt-get update
apt-get install -y firefox xvfb python-pip subversion
pip install selenium
nohup Xvfb :10 -ac &
export DISPLAY=:10
firefox --safe-mode &
svn export --non-interactive --trust-server-cert --username carol_pereira@persistent.co.in --password July13Dday https://svn.persistent.co.in/svn/DevOps_Compt/CarolPereira/CaseStudy/test.py /root/TestSuite/test.py
python /root/TestSuite/test.py
killall Xvfb
