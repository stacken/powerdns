FROM ubuntu:14.04
ENV DEBIAN_FRONTEND noninteractive

##### install stuff ###########################################################
RUN apt-get update && apt-get install -y pdns-server postgresql-9.3 \
	    pdns-backend-pgsql apache2 libapache2-mod-auth-kerb \
	    heimdal-clients sbcl emacs24
###############################################################################

##### setup postgresql ########################################################
ADD files/schema.sql /schema.sql
ADD files/pg_hba.conf /etc/postgresql/9.3/main/pg_hba.conf 
ADD files/setupdb.sh /setupdb.sh
RUN chmod +x /setupdb.sh
RUN /setupdb.sh
###############################################################################

##### setup powerdns ##########################################################
ADD files/pdns.conf /etc/powerdns/pdns.d/pdns.local.gpgsql.conf
RUN rm /etc/powerdns/pdns.d/pdns.simplebind.conf
RUN rm /etc/powerdns/pdns.d/pdns.local.conf
###############################################################################

##### install lisp and emacs ##################################################
RUN adduser --home /home/lisp --uid 1000 --disabled-password lisp
ADD http://beta.quicklisp.org/quicklisp.lisp /quicklisp.lisp
RUN chown lisp:lisp /quicklisp.lisp
RUN su - lisp -c 'sbcl --load "/quicklisp.lisp" --eval "(quicklisp-quickstart:install)"'
RUN su - lisp -c 'sbcl --load "/home/lisp/quicklisp/setup.lisp" --eval "(ql:quickload \"quicklisp-slime-helper\")"'
RUN su - lisp -c 'sbcl --load "/home/lisp/quicklisp/setup.lisp" --eval "(ql:quickload \"hunchentoot\")"'
ADD files/sbclrc /home/lisp/.sbclrc
RUN mkdir /home/lisp/.emacs.d
ADD files/emacs /home/lisp/.emacs.d/init
RUN chown lisp:lisp /home/lisp/.emacs.d/init
###############################################################################

##### setup apache ############################################################
RUN rm -f /var/www/html/index.html
RUN ln -s /etc/apache2/mods-available/proxy.conf \
	    /etc/apache2/mods-enabled/proxy.conf
RUN ln -s /etc/apache2/mods-available/proxy.load \
	    /etc/apache2/mods-enabled/proxy.load
RUN ln -s /etc/apache2/mods-available/proxy_http.load \
	    /etc/apache2/mods-enabled/proxy_http.load
ADD files/000-default.conf /etc/apache2/sites-enabled/000-default.conf
###############################################################################

##### startup script ##########################################################
ADD files/start.sh /start.sh
RUN chmod +x /start.sh 
RUN chmod -R 777 /var/log/apache2
###############################################################################
