ARG FROM_IMAGE=rboonzaijer/nginx:latest
FROM ${FROM_IMAGE}

USER root

RUN apk add --no-cache --update \
  php83 \
  php83-ctype \
  php83-curl \
  php83-dom \
  php83-fileinfo \
  php83-fpm \
  php83-gd \
  php83-intl \
  php83-mbstring \
  php83-opcache \
  php83-openssl \
  php83-pdo_mysql \
  php83-pdo_pgsql \
  php83-pdo_sqlite \
  php83-phar \
  php83-session \
  php83-tokenizer \
  php83-xml \
  php83-xmlreader \
  php83-xmlwriter \
  php83-zip \
  supervisor

ENV PHP_INI_DIR /etc/php83
COPY php-nginx/fpm-pool.conf ${PHP_INI_DIR}/php-fpm.d/www.conf
COPY php-nginx/php.ini ${PHP_INI_DIR}/conf.d/custom.ini
RUN if [ ! -f /usr/bin/php ]; then ln -s /usr/bin/php83 /usr/bin/php; fi

COPY php-nginx/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN sed -i 's/php-fpm__VERSION__/php-fpm83/g' /etc/supervisor/conf.d/supervisord.conf

USER nobody

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

HEALTHCHECK --timeout=10s CMD curl --silent --fail http://127.0.0.1:80/fpm-ping || exit 1
