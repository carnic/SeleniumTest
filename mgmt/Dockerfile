FROM ubuntu:14.04

ENV http_proxy ${HTTP_PROXY}
#http://carol_pereira:August23Vm@hjproxy.persistent.co.in:8080
ENV https_proxy ${HTTPS_PROXY}
#http://carol_pereira:August23Vm@hjproxy.persistent.co.in:8080
RUN apt-get update
RUN apt-get install -y wget
RUN groupadd mysql
RUN useradd -g mysql mysql
RUN mkdir /var/tmp/mysql-cluster
RUN wget https://dev.mysql.com/get/Downloads/MySQL-Cluster-7.4/mysql-cluster-gpl-7.4.12-linux-glibc2.5-x86_64.tar.gz -P /var/tmp/mysql-cluster/

EXPOSE 22
#RUN mkdir /var/tmp/mysql-cluster
#COPY /var/tmp/mysql-cluster-gpl-7.4.12-linux-glibc2.5-x86_64.tar.gz /var/tmp/mysql-cluster/


RUN cd /var/tmp/mysql-cluster/ && tar -xzvf mysql-cluster-gpl-7.4.12-linux-glibc2.5-x86_64.tar.gz && \
	cd mysql-cluster-gpl-7.4.12-linux-glibc2.5-x86_64 && cp bin/ndb_mgm* /usr/local/bin && \
	cd /usr/local/bin && chmod +x ndb_mgm*


RUN mkdir /var/lib/mysql-cluster
RUN mkdir /usr/local/mysql/ && mkdir /usr/local/mysql/mysql-cluster
COPY config.ini /var/lib/mysql-cluster/config.ini
