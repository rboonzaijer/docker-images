ARG FROM_IMAGE=usethis/alpine:latest
FROM ${FROM_IMAGE}

USER root

WORKDIR /var/www/html

RUN apk add --no-cache --update \
    curl \
    nginx

COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/conf.d /etc/nginx/conf.d/

RUN chown -R nobody:nobody /var/www/html /run /var/lib/nginx /var/log/nginx

COPY --chown=nobody nginx/www/ /var/www/html/

RUN find /var/www/html -type d -exec chmod 700 {} \;
RUN find /var/www/html -type f -exec chmod 600 {} \;

USER nobody

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
