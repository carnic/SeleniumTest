FROM ubuntu:14.04

ENV http_proxy http://santosh_dhanasure:psl156198%233dob@ptproxy.persistent.co.in:8080
ENV https_proxy https://santosh_dhanasure:psl156198%233dob@ptproxy.persistent.co.in:8080
RUN apt-get update
RUN apt-get install -y wget
RUN groupadd mysql
RUN useradd -g mysql mysql

EXPOSE 80 443
RUN mkdir /var/tmp/mysql-cluster
COPY mysql-cluster-gpl-7.4.12-linux-glibc2.5-x86_64.tar.gz /var/tmp/mysql-cluster/


RUN cd /var/tmp/mysql-cluster/ && tar -xzvf mysql-cluster-gpl-7.4.12-linux-glibc2.5-x86_64.tar.gz && \
	cd mysql-cluster-gpl-7.4.12-linux-glibc2.5-x86_64 && cp bin/ndb_mgm* /usr/local/bin && \
	cd /usr/local/bin && chmod +x ndb_mgm*


RUN mkdir /var/lib/mysql-cluster
RUN mkdir /usr/local/mysql/ && mkdir /usr/local/mysql/mysql-cluster
COPY config.ini /var/lib/mysql-cluster/config.ini
