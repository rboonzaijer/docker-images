ARG FROM_IMAGE=rboonzaijer/alpine:latest
FROM ${FROM_IMAGE}

USER root

RUN apk add --no-cache --update \
    nodejs \
    npm

RUN npm install --global yarn

USER nobody

CMD ["/bin/sh"]
