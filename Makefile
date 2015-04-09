build: Dockerfile schema.sql start.sh
	mkdir -p www
	docker build -t powerdns . 

run: build
	docker run \
		-p 53:53/udp \
		-p 8080:80 \
		-p 3306:3306 \
		-v `pwd`/www:/var/www/html \
		-i -t powerdns /start.sh
