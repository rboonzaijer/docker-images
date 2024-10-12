ARG FROM_IMAGE=rboonzaijer/nginx:latest
FROM ${FROM_IMAGE}

USER root

RUN apk add --no-cache --update \
  php84 \
  php84-ctype \
  php84-curl \
  php84-dom \
  php84-fileinfo \
  php84-fpm \
  php84-gd \
  php84-intl \
  php84-mbstring \
  php84-opcache \
  php84-openssl \
  php84-pdo_mysql \
  php84-pdo_pgsql \
  php84-pdo_sqlite \
  php84-phar \
  php84-session \
  php84-tokenizer \
  php84-xml \
  php84-xmlreader \
  php84-xmlwriter \
  php84-zip \
  supervisor

COPY php-nginx/fpm-pool.conf /etc/php84/php-fpm.d/www.conf
COPY php-nginx/php.ini /etc/php84/conf.d/custom.ini
RUN if [ ! -f /usr/bin/php ]; then ln -s /usr/bin/php84 /usr/bin/php; fi

COPY php-nginx/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN sed -i 's/php-fpm__VERSION__/php-fpm84/g' /etc/supervisor/conf.d/supervisord.conf

USER nobody

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

HEALTHCHECK --timeout=10s CMD curl --silent --fail http://127.0.0.1:80/fpm-ping || exit 1
