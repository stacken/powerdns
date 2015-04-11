build: Dockerfile schema.sql start.sh pg_hba.conf pdns.conf pdns.conf.extra
	mkdir -p www
	docker build -t powerdns . 

run: build
	docker run \
		-p 53:53/udp \
		-p 8081:80 \
		-p 5432:5432 \
		-v `pwd`/www:/var/www/html \
		-v `pwd`/keytab:/etc/keytab \
		-i -t powerdns /start.sh
