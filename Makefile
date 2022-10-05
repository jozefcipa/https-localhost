PWD=$(shell pwd)
PROXY_PORT=3000

# Build a docker image for proxy
docker/build:
	docker build \
		--build-arg PROXY_PORT=$(PROXY_PORT) \
		-t ssl-proxy:$(PROXY_PORT) \
		.

# Generate SSL certificates
cert:
	openssl req -x509 -newkey rsa:4096 -keyout certs/cert.key  -out certs/cert.pem -sha256 -days 365 -nodes

# Launch proxy
proxy:
	docker run \
		-p 443:443 \
		-v "$(PWD)/certs:/etc/nginx/ssl" \
		ssl-proxy:$(PROXY_PORT)