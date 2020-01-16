FROM nginx:1.17.7-alpine

RUN rm /etc/nginx/conf.d/default.conf \
  && mkdir -p /default-www/errors_pages
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY sites-available/*.conf /etc/nginx/sites-enabled/
