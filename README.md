# Docker images

Docker images for a quick starting point - [https://hub.docker.com/u/rboonzaijer](https://hub.docker.com/u/rboonzaijer)

Daily automated builds: [https://github.com/rboonzaijer/docker-images/actions](https://github.com/rboonzaijer/docker-images/actions)

![workflow](https://github.com/rboonzaijer/docker-images/actions/workflows/daily-auto-build-and-push-docker-images.yml/badge.svg)

### NOTE BEFORE USE!

- Changes can be applied at any given time
- Deprecated/outdated versions may be removed at any given time (from this repo and from the Docker registry)
- If you want to use this in production, please create a fork (or just copy the Dockerfiles you need) and push images to your own docker registry to make sure everything stays running on your end (just replace 'rboonzaijer' in all files with your own name)
- For PHP versions, check: https://www.php.net/supported-versions.php and https://php.watch/versions

## Overview

Click on the 'readme' for more info about the images.

### Base images

- updates
- rootless (user: nobody)

| image | from | notes
|-|-|-|
`rboonzaijer/alpine:latest` [readme](alpine/README.md) | alpine:latest | |
`rboonzaijer/alpine-3.19` [readme](alpine/README.md) | alpine:3.19 | for php8.1 |

### Custom images

| image | from base image | notes |
|-|-|-|
`rboonzaijer/node:latest` [readme](node/README.md) | rboonzaijer/alpine:latest | |
`rboonzaijer/imagemagick:latest` [readme](imagemagick/README.md) | rboonzaijer/alpine:latest | |
`rboonzaijer/nginx:latest` [readme](nginx/README.md) | rboonzaijer/alpine:latest | |
`rboonzaijer/nginx:alpine-3.19` [readme](nginx/README.md) | rboonzaijer/alpine-3.19 | for php8.1 |
`rboonzaijer/php-nginx:8.3` [readme](php-nginx/README.md) | rboonzaijer/nginx:latest | |
`rboonzaijer/php-nginx:8.3-dev` [readme](php-nginx/README.md) | rboonzaijer/php-nginx:8.3 | |
`rboonzaijer/php-nginx:8.2` [readme](php-nginx/README.md) | rboonzaijer/nginx:latest | |
`rboonzaijer/php-nginx:8.2-dev` [readme](php-nginx/README.md) | rboonzaijer/php-nginx:8.2 | |
`rboonzaijer/php-nginx:8.1` [readme](php-nginx/README.md) | rboonzaijer/nginx:alpine-3.19 | alpine 3.19 |
`rboonzaijer/php-nginx:8.1-dev` [readme](php-nginx/README.md) | rboonzaijer/php-nginx:8.1 | alpine 3.19 |

## Docker commands

### Scan containers locally for vulnerabilities

```bash
docker run --rm aquasec/trivy image rboonzaijer/alpine:latest
docker run --rm aquasec/trivy image rboonzaijer/nginx:latest
docker run --rm aquasec/trivy image rboonzaijer/php-nginx:8.3
```

### Get most recent pushed tags for any docker image

- https://docs.docker.com/docker-hub/api/latest/#tag/repositories
- Note: only the most recent 100 tags are fetched (page 1)

```bash
docker run --rm rboonzaijer/alpine wget -q -O- "https://hub.docker.com/v2/namespaces/rboonzaijer/repositories/php-nginx/tags?page_size=100&page=1" | grep -o '"name": *"[^"]*' | grep -o '[^"]*$'
```

- For official docker images use the namespace 'library' (like 'alpine')

```bash
docker run --rm rboonzaijer/alpine wget -q -O- "https://hub.docker.com/v2/namespaces/library/repositories/alpine/tags?page_size=100&page=1" | grep -o '"name": *"[^"]*' | grep -o '[^"]*$'
```

### View package versions with 'apk list'

```bash
docker run --rm rboonzaijer/alpine apk list php83*

# list packages in a specific container:
docker run --rm rboonzaijer/php-nginx:8.3 apk list --installed
docker run --rm rboonzaijer/php-nginx:8.3 apk list --upgradable
docker run --rm rboonzaijer/php-nginx:8.3 apk list php83* --installed
```

### Get original config files from a docker container

The idea is to first create (no need to start) a container, then copy the file to the host, then remove the container again.

```bash
docker create --name temp nginx:alpine && docker cp temp:/etc/nginx/nginx.conf ./original~nginx.conf ; docker rm -f temp

docker create --name temp nginx:alpine && docker cp temp:/etc/nginx/conf.d/default.conf ./original~nginx~conf.d~default.conf ; docker rm -f temp

docker create --name temp rboonzaijer/php-nginx:8.3 && docker cp temp:/etc/supervisord.conf ./original~supervisord.conf ; docker rm -f temp

docker create --name temp rboonzaijer/php-nginx:8.3 && docker cp temp:/etc/php83/php.ini ./original~php83~php.ini ; docker rm -f temp

docker create --name temp rboonzaijer/php-nginx:8.2 && docker cp temp:/etc/php82/php.ini ./original~php82~php.ini ; docker rm -f temp

docker create --name temp rboonzaijer/php-nginx:8.1 && docker cp temp:/etc/php81/php.ini ./original~php81~php.ini ; docker rm -f temp
```
