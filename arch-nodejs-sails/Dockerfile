##
## Image for nodejs with sails, pm2, and grunt.
##
## Run this image with volume mounted at /srv/www,
##
##	docker run -v ${PWD}/src:/srv/www -it sulhan/arch-nodejs-sails
##
FROM sulhan/arch-nodejs:latest
MAINTAINER Sulhan <ms@kilabit.info>

VOLUME ["/srv/www"]
EXPOSE 80
USER root

COPY init.sh /

RUN npm install -g sails --unsafe-perm && \
	npm install -g pm2 --unsafe-perm && \
	npm install -g grunt && \
	rm -r /root/.node-gyp && \
	rm -r /root/.npm

CMD ["/init.sh"]
