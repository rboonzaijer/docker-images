ARG FROM_IMAGE=rboonzaijer/alpine:latest
FROM ${FROM_IMAGE}

USER root

RUN apk add --no-cache --update \
    python3 \
    py3-pip

USER nobody

CMD ["/bin/sh"]
