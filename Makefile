PWD=$(shell pwd)
PROXY_PORT=3000
SHELL := /bin/bash

# Build a docker image for proxy
docker/build:
	docker build \
		--build-arg PROXY_PORT=$(PROXY_PORT) \
		-t ssl-proxy:$(PROXY_PORT) \
		.

# Generate SSL certificates
# https://letsencrypt.org/docs/certificates-for-localhost/#making-and-trusting-your-own-certificates
# https://stackoverflow.com/a/71294188/4480179
cert:
	openssl req -x509 \
	-out ./certs/cert.pem -keyout ./certs/cert.key \
  	-newkey rsa:2048 -nodes -sha256 \
  	-subj '/CN=localhost' -extensions EXT \
	-config <(cat ./certs/v3.ext)

# Launch proxy
proxy:
	docker run \
		-p 443:443 \
		-v "$(PWD)/certs:/etc/nginx/ssl" \
		ssl-proxy:$(PROXY_PORT)