build: Dockerfile schema.sql start.sh pg_hba.conf pdns.conf pdns.conf.extra
	mkdir -p www
	docker build -t powerdns . 

run: build
	docker run \
		-p 53:53/udp \
		-p 8080:80 \
		-p 5432:5432 \
		-v `pwd`/www:/var/www/html \
		-i -t powerdns /start.sh
