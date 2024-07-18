ARG FROM_IMAGE=rboonzaijer/php-nginx:8.1
FROM ${FROM_IMAGE}

USER root

RUN apk add --no-cache --update \
    git \
    php82-pecl-xdebug \
    composer \
    nodejs \
    npm

RUN npm install --global yarn

COPY php-nginx/dev/99-xdebug.ini /etc/php82/conf.d/99-xdebug.ini

USER nobody

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

HEALTHCHECK --timeout=10s CMD curl --silent --fail http://127.0.0.1:80/fpm-ping || exit 1
