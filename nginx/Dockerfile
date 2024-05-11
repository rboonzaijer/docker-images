FROM alpinebase/img:alpine

USER root

WORKDIR /var/www/html

RUN apk add --no-cache --update \
    curl \
    #nginx=~1 \
    nginx

COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/conf.d /etc/nginx/conf.d/

RUN chown -R appuser:appgroup /var/www/html /run /var/lib/nginx /var/log/nginx

COPY --chown=appuser nginx/www/ /var/www/html/

RUN find /var/www/html -type d -exec chmod 700 {} \;
RUN find /var/www/html -type f -exec chmod 600 {} \;

USER appuser

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]