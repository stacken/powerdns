#!/bin/sh

service postgresql start
su - postgres -c 'mkdir -p `pwd`/data && \
	    /usr/lib/postgresql/9.3/bin/initdb  -D `pwd`/data && \
            /usr/lib/postgresql/9.3/bin/createdb pdns && \
	    psql pdns < /schema.sql'
sed -i -e "s/^#\+listen_addresses = .*$/listen_addresses = \'*\'/g" /etc/postgresql/9.3/main/postgresql.conf
service postgresql stop
