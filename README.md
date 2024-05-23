# Docker images

Docker images for a quick starting point - [https://hub.docker.com/r/usethis/img/tags](https://hub.docker.com/r/usethis/img/tags)

Daily automated builds: [https://github.com/rboonzaijer/docker-images/actions](https://github.com/rboonzaijer/docker-images/actions)

![workflow](https://github.com/rboonzaijer/docker-images/actions/workflows/daily-auto-build-and-push-docker-images.yml/badge.svg)

# NOTE BEFORE USE!

- Changes can be applied at any given time
- Deprecated versions can be removed at any given time (from this repo and from the Docker registry)
- If you want to use this in production, please create a fork (or just copy the Dockerfiles you need) and push images to your own docker registry to make sure everything stays running on your end (just replace 'usethis' in all files with your own name)
- The reason everything is in 1 image (usethis/img) is so that Docker Scout can scan every tag for vulnerabilities (max 3 images on the [Docker Scout Free tier](https://www.docker.com/products/docker-scout/)) - You can also scan the images yourself with 'aquasec/trivy' (see below for examples)
- For PHP versions, check: https://www.php.net/supported-versions.php and https://php.watch/versions

## Overview

| image | from | details |
|-|-|-|
`usethis/img:alpine` [readme](alpine/README.md) | alpine:latest | appuser:appgroup (1000:1000) |
`usethis/img:alpine-nobody` [readme](alpine/README.md) | alpine:latest | nobody:nobody (65534:65534) |
`usethis/img:alpine-root` [readme](alpine/README.md) | alpine:latest | root:root (0:0) |
`usethis/img:imagemagick` [readme](imagemagick/README.md) | usethis/img:alpine | imagemagick, ghostscript |
`usethis/img:nginx` [readme](nginx/README.md) | usethis/img:alpine | nginx |
`usethis/img:php-nginx-8.3` [readme](php-nginx/README.md) | usethis/img:nginx | nginx, php8.3, supervisor |
`usethis/img:php-nginx-8.3-dev` [readme](php-nginx/README.md) | usethis/img:php-nginx-8.3 | nginx, php8.3, supervisor, node/npm, composer |
`usethis/img:php-nginx-8.2` [readme](php-nginx/README.md) | usethis/img:nginx | nginx, php8.2, supervisor |
`usethis/img:php-nginx-8.2-dev` [readme](php-nginx/README.md) | usethis/img:php-nginx-8.2 | nginx, php8.2, supervisor, node/npm, composer |

## Docker commands

### Scan containers locally for vulnerabilities

```bash
# Note: there can be vulnerabilities in the official image if they havent been updated recently, so make sure you update/upgrade the alpine image (with a custom Dockerfile) if you use it:
docker run --rm aquasec/trivy image alpine:latest

# Daily updated/upgraded:
docker run --rm aquasec/trivy image usethis/img:alpine
docker run --rm aquasec/trivy image usethis/img:imagemagick
docker run --rm aquasec/trivy image usethis/img:nginx
docker run --rm aquasec/trivy image usethis/img:php-nginx-8.3
docker run --rm aquasec/trivy image usethis/img:php-nginx-8.3-dev
docker run --rm aquasec/trivy image usethis/img:php-nginx-8.2
docker run --rm aquasec/trivy image usethis/img:php-nginx-8.2-dev
```

### Example: Download a file

```bash
docker run --rm -v .:/app usethis/img:alpine wget -O Dockerfile.alpine https://raw.githubusercontent.com/rboonzaijer/docker-images/main/alpine/Dockerfile

# or keep the original name
docker run --rm -v .:/app usethis/img:alpine wget https://raw.githubusercontent.com/rboonzaijer/docker-images/main/alpine/Dockerfile
```

### Get most recent tags for a docker image

https://docs.docker.com/docker-hub/api/latest/#tag/repositories

Example: usethis/img:... (note: only the most recent 100 tags are fetched)

```bash
docker run --rm usethis/img:alpine wget -q -O- "https://hub.docker.com/v2/namespaces/usethis/repositories/img/tags?page_size=100&page=1" | grep -o '"name": *"[^"]*' | grep -o '[^"]*$'
```

For official docker images use the namespace 'library':

```bash
docker run --rm usethis/img:alpine wget -q -O- "https://hub.docker.com/v2/namespaces/library/repositories/alpine/tags?page_size=100&page=1" | grep -o '"name": *"[^"]*' | grep -o '[^"]*$'
```

### Debug package versions with 'apk list'

```bash
docker run --rm usethis/img:alpine apk list php83* # list all available php83* packages
docker run --rm alpine:latest sh -c 'apk fix && apk list php83*' # alias

docker run --rm usethis/img:php-nginx-8.3 apk list --installed # all installed packages
docker run --rm usethis/img:php-nginx-8.3 apk list --upgradable # all upgradable packages
docker run --rm usethis/img:php-nginx-8.3 apk list php83* --installed # installed php83* versions
```

### Get original config files from a docker container

The idea is to first create (no need to start) a container, then copy the file to the host, then remove the container again.

```bash
docker create --name temp nginx:alpine && docker cp temp:/etc/nginx/nginx.conf ./original~nginx.conf ; docker rm -f temp

docker create --name temp nginx:alpine && docker cp temp:/etc/nginx/conf.d/default.conf ./original~nginx~conf.d~default.conf ; docker rm -f temp

docker create --name temp usethis/img:php-nginx-8.3 && docker cp temp:/etc/supervisord.conf ./original~supervisord.conf ; docker rm -f temp

docker create --name temp usethis/img:php-nginx-8.3 && docker cp temp:/etc/php83/php.ini ./original~php83~php.ini ; docker rm -f temp

docker create --name temp usethis/img:php-nginx-8.2 && docker cp temp:/etc/php82/php.ini ./original~php82~php.ini ; docker rm -f temp
```
