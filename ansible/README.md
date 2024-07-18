[<< Go back](../README.md#overview)

https://hub.docker.com/r/rboonzaijer/ansible/tags

# Docker image: ansible

- `rboonzaijer/ansible:alpine` [Dockerfile](alpine/Dockerfile)

## Contents

- ansible

## Version

```bash
docker run --rm rboonzaijer/ansible:alpine ansible --version
```

## Interactive

```bash
docker run --rm -v ~/.ssh:/home/ansible/.ssh:ro -v ./ansible/inv-test.ini:/app/inventory.ini -it rboonzaijer/ansible:alpine sh
```

## Example

```bash
docker run --rm -v ~/.ssh:/home/ansible/.ssh:ro -v ./ansible/inv-test.ini:/app/inventory.ini rboonzaijer/ansible:alpine ansible -i inventory.ini example -m ping
```

## Run as root to quickly install/test additional stuff

```bash
docker run --rm -u 0:0 -v ~/.ssh:/root/.ssh:ro -v ./ansible/inv-test.ini:/app/inventory.ini rboonzaijer/ansible:alpine sh -c 'apk add ca-certificates && ansible -i inventory.ini example -m ping'
```
