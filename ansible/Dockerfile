ARG FROM_IMAGE=rboonzaijer/python:3
FROM ${FROM_IMAGE}

USER root

RUN addgroup -g 1000 ansible && \
    adduser -D -G ansible -u 1000 ansible && \
    chown -R ansible:ansible /app

# Install required and common used packages for ansible
RUN apk add --no-cache --update \
    openssh-client

# Use python virtual environment
ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

COPY ./ansible/requirements.txt .

RUN pip install -r requirements.txt && \
    rm requirements.txt

USER ansible

CMD ["ansible"]
