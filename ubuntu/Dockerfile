ARG FROM_IMAGE=ubuntu:latest
FROM ${FROM_IMAGE}

USER root

WORKDIR /app

RUN groupadd -g 1001 appgroup && \
    useradd -g 1001 -u 1001 appuser && \
    chown -R appuser:appgroup /app

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get autoremove -y && \
    apt-get autoclean -y

USER appuser

CMD ["/usr/bin/bash"]
