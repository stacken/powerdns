#!/bin/sh

service pdns start
service postgresql start
service apache2 start
su - postgres -c '/usr/lib/postgresql/9.3/bin/createdb dns'
su - postgres -c 'psql dns < /schema.sql'

/bin/bash
