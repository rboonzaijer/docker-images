ARG ALPINE_VERSION=latest
FROM alpine:${ALPINE_VERSION}

RUN apk update && \
    apk upgrade -a

WORKDIR /app

RUN chown -R nobody:nobody /app

USER nobody

CMD ["/bin/sh"]
