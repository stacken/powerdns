FROM ubuntu:14.04

RUN apt-get update 
RUN apt-get install -y pdns-server
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get install -y mysql-server-5.5
RUN apt-get install -y pdns-backend-mysql
RUN apt-get install -y dnsutils
RUN apt-get install -y apache2 libapache2-mod-php5 php5-cgi 
RUN apt-get install -y php5-mysql

ADD start.sh /start.sh
ADD schema.sql /schema.sql
ADD pdns.conf /etc/powerdns/pdns.d/pdns.local.gmysql.conf
RUN rm /etc/powerdns/pdns.d/pdns.simplebind.conf
RUN rm /etc/powerdns/pdns.d/pdns.local.conf
RUN rm /var/www/html/index.html
RUN chmod +x /start.sh 
