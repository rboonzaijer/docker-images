ARG FROM_IMAGE=alpine:latest
FROM ${FROM_IMAGE}

RUN apk update && \
    apk upgrade -a

WORKDIR /app

RUN chown -R nobody:nobody /app

USER nobody

CMD ["/bin/sh"]
