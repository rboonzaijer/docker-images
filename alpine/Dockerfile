ARG FROM_IMAGE=alpine:latest
FROM ${FROM_IMAGE}

RUN apk update && \
    apk upgrade -a

# RUN addgroup -g 1000 appgroup && \
#     adduser -D -G appgroup -u 1000 appuser

WORKDIR /app

RUN chown -R nobody:nobody /app

USER nobody

CMD ["/bin/sh"]
