ARG FROM_IMAGE=debian:latest
FROM ${FROM_IMAGE}

USER root

WORKDIR /app

RUN addgroup --gid 1000 appgroup
RUN adduser --disabled-password --gecos GECOS --ingroup appgroup -uid 1000 appuser
RUN chown -R appuser:appgroup /app

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get autoremove -y && \
    apt-get autoclean -y

USER appuser

CMD ["/usr/bin/bash"]
