FROM roelscript/img:nginx

USER root

RUN apk add --no-cache \
  php81 \
  php81-ctype \
  php81-curl \
  php81-dom \
  php81-fileinfo \
  php81-fpm \
  php81-gd \
  php81-intl \
  php81-mbstring \
  php81-opcache \
  php81-openssl \
  php81-pdo_mysql \
  php81-pdo_pgsql \
  php81-pdo_sqlite \
  php81-phar \
  php81-session \
  php81-tokenizer \
  php81-xml \
  php81-xmlreader \
  php81-xmlwriter \
  php81-zip \
  supervisor

ENV PHP_INI_DIR /etc/php81
COPY php-nginx/fpm-pool.conf ${PHP_INI_DIR}/php-fpm.d/www.conf
COPY php-nginx/php.ini ${PHP_INI_DIR}/conf.d/custom.ini
RUN if [ ! -f /usr/bin/php ]; then ln -s /usr/bin/php81 /usr/bin/php; fi

COPY php-nginx/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN sed -i 's/php-fpm__VERSION__/php-fpm81/g' /etc/supervisor/conf.d/supervisord.conf

USER appuser

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

HEALTHCHECK --timeout=10s CMD curl --silent --fail http://127.0.0.1:80/fpm-ping || exit 1
