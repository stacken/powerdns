FROM ubuntu:14.04
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y pdns-server apache2 postgresql-9.3 \
	    pdns-backend-pgsql
RUN apt-get install -y libapache2-mod-php5 
RUN apt-get install -y php5-pgsql

ADD start.sh /start.sh
ADD schema.sql /schema.sql
ADD pdns.conf /etc/powerdns/pdns.d/pdns.local.gpgsql.conf

RUN rm /etc/powerdns/pdns.d/pdns.simplebind.conf
RUN rm /etc/powerdns/pdns.d/pdns.local.conf
RUN rm /var/www/html/index.html
RUN su - postgres -c 'mkdir -p `pwd`/data && \
	    /usr/lib/postgresql/9.3/bin/initdb  -D `pwd`/data'
RUN chmod +x /start.sh 
