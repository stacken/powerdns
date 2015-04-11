build: Dockerfile 
	mkdir -p www
	docker build -t powerdns . 

run: build
	docker run \
		-p 53:53/udp \
		-p 8080:80 \
		-v `pwd`/www:/var/www/html \
		-v `pwd`/keytab:/etc/keytab \
		-i -t powerdns /start.sh -r

XAUTH=/tmp/.docker.xauth
emacs: build
	touch ${XAUTH} 
	xauth nlist :0  | sed -e 's/^..../ffff/' | xauth -f ${XAUTH} nmerge -
	docker run \
		-p 8080:80 \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		-v ${XAUTH}:${XAUTH} \
		-v $$HOME:/development \
		-e DISPLAY=$$DISPLAY \
		-e XAUTHORITY=${XAUTH} \
		-it powerdns /start.sh -e
