ARG FROM_IMAGE=ubuntu:latest
FROM ${FROM_IMAGE}

RUN apt-get update -y && \
    apt-get upgrade -y

WORKDIR /app

RUN chown -R ubuntu:ubuntu /app

USER ubuntu

CMD ["/usr/bin/bash"]
