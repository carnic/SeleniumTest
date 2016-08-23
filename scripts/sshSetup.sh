export http_proxy="http://carol_pereira:July13Dday@hjproxy.persistent.co.in:8080"
export https_proxy="https://carol_pereira:July13Dday@hjproxy.persistent.co.in:8080"
apt-get update
apt-get install -y openssh-server
sed -i -e 's/PermitRootLogin without-password/#PermitRootLogin without-password/g' /etc/ssh/sshd_config
sed -i '$ a PermitRootLogin yes' /etc/ssh/sshd_config
echo -e "pass\npass" | passwd root
service ssh restart
