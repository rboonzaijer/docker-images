ARG FROM_IMAGE=python:3-slim
FROM ${FROM_IMAGE}

WORKDIR /app

RUN addgroup --gid 1000 appgroup
RUN adduser --disabled-password --gecos GECOS --ingroup appgroup -uid 1000 appuser
RUN chown -R appuser:appgroup /app

RUN apt-get update -y && \
    apt-get upgrade -y

# RUN apk add --no-cache --update \
#     python3 \
#     py3-pip

# upgrade setuptools - CVE-2024-6345
# RUN pip install --upgrade --break-system-packages \
#     pip \
#     setuptools

USER appuser

CMD ["/usr/bin/bash"]
