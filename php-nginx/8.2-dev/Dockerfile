ARG FROM_IMAGE=usethis/php-nginx:8.1

FROM node:lts-alpine AS node_image
FROM ${FROM_IMAGE}

USER root

RUN apk add --no-cache \
    git \
    php82-pecl-xdebug

COPY php-nginx/99-xdebug.ini ${PHP_INI_DIR}/conf.d/99-xdebug.ini

COPY --from=node_image /usr/lib /usr/lib
COPY --from=node_image /usr/local/lib /usr/local/lib
COPY --from=node_image /usr/local/include /usr/local/include
COPY --from=node_image /usr/local/bin /usr/local/bin

RUN curl -sS https://getcomposer.org/installer -o composer-setup.php
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN rm -rf composer-setup.php

USER nobody

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

HEALTHCHECK --timeout=10s CMD curl --silent --fail http://127.0.0.1:80/fpm-ping || exit 1
