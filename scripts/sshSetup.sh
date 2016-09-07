#<<<<<<< uncomment the following line to set proxy >>>>>>>>>>>>>
#export http_proxy="http://<username>:<password>@<proxy_url>:<port>"
#export https_proxy="https://<username>:<password>@<proxy_url>:<port>"

apt-get update
apt-get install -y openssh-server
sed -i -e 's/PermitRootLogin without-password/#PermitRootLogin without-password/g' /etc/ssh/sshd_config
sed -i '$ a PermitRootLogin yes' /etc/ssh/sshd_config
echo "root:pass" | chpasswd
service ssh restart
