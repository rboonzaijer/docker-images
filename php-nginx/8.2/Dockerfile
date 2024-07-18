ARG FROM_IMAGE=rboonzaijer/nginx:latest
FROM ${FROM_IMAGE}

USER root

RUN apk add --no-cache --update \
  php82 \
  php82-ctype \
  php82-curl \
  php82-dom \
  php82-fileinfo \
  php82-fpm \
  php82-gd \
  php82-intl \
  php82-mbstring \
  php82-opcache \
  php82-openssl \
  php82-pdo_mysql \
  php82-pdo_pgsql \
  php82-pdo_sqlite \
  php82-phar \
  php82-session \
  php82-tokenizer \
  php82-xml \
  php82-xmlreader \
  php82-xmlwriter \
  php82-zip \
  supervisor

COPY php-nginx/fpm-pool.conf /etc/php82/php-fpm.d/www.conf
COPY php-nginx/php.ini /etc/php82/conf.d/custom.ini
RUN if [ ! -f /usr/bin/php ]; then ln -s /usr/bin/php82 /usr/bin/php; fi

COPY php-nginx/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN sed -i 's/php-fpm__VERSION__/php-fpm82/g' /etc/supervisor/conf.d/supervisord.conf

USER nobody

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

HEALTHCHECK --timeout=10s CMD curl --silent --fail http://127.0.0.1:80/fpm-ping || exit 1
