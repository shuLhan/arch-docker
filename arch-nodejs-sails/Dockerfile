##
## Image for proofn web API.
##
## Run this image with volume mounted at /srv/www,
##
##	docker run -v $(pwd)/src:/srv/www -it sulhan/proofn-api
##
FROM sulhan/arch-nodejs:latest
MAINTAINER Sulhan <ms@kilabit.info>

VOLUME ["/srv/www"]
EXPOSE 80

COPY init.sh /

USER root

RUN npm install -g sails --unsafe-perm && \
	npm install -g pm2 --unsafe-perm

CMD ["/init.sh"]
