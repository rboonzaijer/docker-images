ARG ALPINE_VERSION=latest
FROM alpine:${ALPINE_VERSION}

RUN apk update && \
    apk upgrade -a

WORKDIR /app

CMD ["/bin/sh"]
