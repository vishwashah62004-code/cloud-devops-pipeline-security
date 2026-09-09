FROM nginx:1.31.5-alpine3.24

RUN apk upgrade --no-cache

COPY index.html /usr/share/nginx/html/index.html

EXPOSE 80
