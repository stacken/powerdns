#!/bin/sh

service mysql start
service pdns start
service apache2 start
mysql -uroot < /schema.sql

/bin/bash
