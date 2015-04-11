FROM ubuntu:14.04
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y pdns-server postgresql-9.3 \
	    pdns-backend-pgsql apache2 libapache2-mod-auth-kerb \
	    heimdal-clients

ADD schema.sql /schema.sql
ADD pdns.conf /etc/powerdns/pdns.d/pdns.local.gpgsql.conf
ADD pg_hba.conf /etc/postgresql/9.3/main/pg_hba.conf 
ADD setupdb.sh /setupdb.sh

RUN rm /etc/powerdns/pdns.d/pdns.simplebind.conf
RUN rm /etc/powerdns/pdns.d/pdns.local.conf
RUN rm -f /var/www/html/index.html

RUN chmod +x /setupdb.sh
RUN /setupdb.sh

ADD start.sh /start.sh
RUN chmod +x /start.sh 
ADD 000-default.conf /etc/apache2/sites-enabled/000-default.conf
