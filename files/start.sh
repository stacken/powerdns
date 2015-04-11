#!/bin/sh

service pdns start
service postgresql start
service apache2 start

cat > /etc/krb5.conf <<EOF
[libdefaults]
	default_realm = LAN.TALLR.SE
[realms]
	TALLR.SE = {
		kdc = kerberos.lan.tallr.se
		admin_server = kerberos.lan.tallr.se
	}
[domain_realm]
	.lan.tallr.se = LAN.TALLR.SE
EOF

# /bin/bash

while getopts "er" opt; do
	case $opt in
		e)
			su lisp -c 'emacs -f slime'
			;;
		r)
			# development is the user's mounted home directory, 
			# cd their and start emacs with slime
			/bin/bash
			;;
	esac
done
