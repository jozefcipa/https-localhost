## https-localhost

**How to run HTTPS locally on your computer?**

You need to generate an SSL certificate and have a HTTP server, we use nginx for that.

1. `make cert` - This will call an `openssl` CLI utility that will generate a self-signed SSL certificate.
2. `make docker/build` - This will build a docker image with configured NGINX server.
3. `make proxy` - Start the proxy. As this is an HTTPS proxy, it will listen on port 443, or https://localhost

By default the proxy redirects all trafic from `127.0.0.1:443` to `127.0.0.1:3000` but you can customize the port in `Makefile`.

If you want to use the proxy with more ports (applications), you will need to update `nginx/sites.conf` and add another `location` block.
[Learn more](https://jozefcipa.com/blog/running-https-on-localhost)
