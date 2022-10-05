FROM nginx:1.21-alpine
ARG PROXY_PORT=3000

COPY ./nginx/ssl.conf /etc/nginx/conf.d/ssl.conf
COPY ./nginx/sites.conf /etc/nginx/conf.d/default.conf

RUN sed -i "s/-PROXY_PORT-/$PROXY_PORT/g" /etc/nginx/conf.d/default.conf
