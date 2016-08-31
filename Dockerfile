FROM ubuntu:14.04

ENV http_proxy ${HTTP_PROXY}
#http://carol_pereira:August23Vm@hjproxy.persistent.co.in:8080
ENV https_proxy ${HTTPS_PROXY}
#http://carol_pereira:August23Vm@hjproxy.persistent.co.in:8080
RUN apt-get update
RUN apt-get install -y wget
RUN apt-get -y install subversion

RUN apt-get -y install zip

RUN groupadd mysql
RUN useradd -g mysql mysql

EXPOSE 22
RUN mkdir /var/tmp/mysql-cluster
RUN wget https://dev.mysql.com/get/Downloads/MySQL-Cluster-7.4/mysql-cluster-gpl-7.4.12-linux-glibc2.5-x86_64.tar.gz -P /var/tmp/mysql-cluster/

#COPY mysql-cluster-gpl-7.4.12-linux-glibc2.5-x86_64.tar.gz /var/tmp/mysql-cluster/


RUN tar -C /usr/local -xzvf /var/tmp/mysql-cluster/mysql-cluster-gpl-7.4.12-linux-glibc2.5-x86_64.tar.gz

RUN ln -s /usr/local/mysql-cluster-gpl-7.4.12-linux-glibc2.5-x86_64 /usr/local/mysql

RUN export PATH=$PATH:/usr/local/mysql/bin

RUN echo "export PATH=\$PATH:/usr/local/mysql/bin" >> /etc/bash.bashrc

RUN apt-get install libaio1 libaio-dev

RUN cd /usr/local/mysql && \
	./scripts/mysql_install_db -user=mysql && chown -R root . && chown -R mysql data && chgrp -R mysql . && cp support-files/mysql.server /etc/init.d/mysql && \
	chmod +x /etc/init.d/mysql && update-rc.d mysql defaults

COPY my.cnf /etc/my.cnf

#RUN /etc/init.d/mysql start
#VOLUME ["/var/tmp/mysql-cluster"]
#ENTRYPOINT ["/var/tmp/mysql-cluster/cl.sh", "-D", "FOREGROUND"]
