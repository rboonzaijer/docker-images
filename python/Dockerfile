ARG FROM_IMAGE=rboonzaijer/alpine:latest
FROM ${FROM_IMAGE}

USER root

RUN apk add --no-cache --update \
    python3 \
    py3-pip

# upgrade setuptools - CVE-2024-6345
RUN pip install --upgrade --break-system-packages \
    pip \
    setuptools

USER nobody

CMD ["/bin/sh"]
