# Docker images

Docker images for a quick starting point - [https://hub.docker.com/u/usethis](https://hub.docker.com/u/usethis)

Daily automated builds: [https://github.com/rboonzaijer/docker-images/actions](https://github.com/rboonzaijer/docker-images/actions)

![workflow](https://github.com/rboonzaijer/docker-images/actions/workflows/daily-auto-build-and-push-docker-images.yml/badge.svg)

### NOTE BEFORE USE!

- Changes can be applied at any given time
- Deprecated/outdated versions may be removed at any given time (from this repo and from the Docker registry)
- If you want to use this in production, please create a fork (or just copy the Dockerfiles you need) and push images to your own docker registry to make sure everything stays running on your end (just replace 'usethis' in all files with your own name)
- For PHP versions, check: https://www.php.net/supported-versions.php and https://php.watch/versions

## Overview

Click on the 'readme' for more info about the images.

### Base images

- updates
- rootless (user: nobody)

| image | from | notes
|-|-|-|
`usethis/alpine:latest` [readme](alpine/README.md) | alpine:latest | |
`usethis/alpine-3.19` [readme](alpine/README.md) | alpine:3.19 | for php8.1 |

### Custom images

| image | from base image | notes |
|-|-|-|
`usethis/imagemagick:latest` [readme](imagemagick/README.md) | usethis/alpine:latest | |
`usethis/nginx:latest` [readme](nginx/README.md) | usethis/alpine:latest | |
`usethis/nginx:alpine-3.19` [readme](nginx/README.md) | usethis/alpine-3.19 | for php8.1 |
`usethis/php-nginx:8.3` [readme](php-nginx/README.md) | usethis/nginx:latest | |
`usethis/php-nginx:8.3-dev` [readme](php-nginx/README.md) | usethis/php-nginx:8.3 | |
`usethis/php-nginx:8.2` [readme](php-nginx/README.md) | usethis/nginx:latest | |
`usethis/php-nginx:8.2-dev` [readme](php-nginx/README.md) | usethis/php-nginx:8.2 | |
`usethis/php-nginx:8.1` [readme](php-nginx/README.md) | usethis/nginx:alpine-3.19 | alpine 3.19 |
`usethis/php-nginx:8.1-dev` [readme](php-nginx/README.md) | usethis/php-nginx:8.1 | alpine 3.19 |

## Docker commands

### Scan containers locally for vulnerabilities

```bash
docker run --rm aquasec/trivy image usethis/php-nginx:8.3
```

### Example: Download a file

```bash
docker run --rm -v .:/app usethis/alpine wget -O Dockerfile.alpine https://raw.githubusercontent.com/rboonzaijer/docker-images/main/alpine/Dockerfile

# or keep the original name
docker run --rm -v .:/app usethis/alpine wget https://raw.githubusercontent.com/rboonzaijer/docker-images/main/alpine/Dockerfile
```

### Get most recent tags for a docker image

https://docs.docker.com/docker-hub/api/latest/#tag/repositories

Example: usethis/alpine:... (note: only the most recent 100 tags are fetched)

```bash
docker run --rm usethis/alpine wget -q -O- "https://hub.docker.com/v2/namespaces/usethis/repositories/alpine/tags?page_size=100&page=1" | grep -o '"name": *"[^"]*' | grep -o '[^"]*$'
```

For official docker images use the namespace 'library':

```bash
docker run --rm usethis/alpine wget -q -O- "https://hub.docker.com/v2/namespaces/library/repositories/alpine/tags?page_size=100&page=1" | grep -o '"name": *"[^"]*' | grep -o '[^"]*$'
```

### Debug package versions with 'apk list'

```bash
docker run --rm usethis/alpine apk list php83* # list all available php83* packages
docker run --rm alpine:latest sh -c 'apk fix && apk list php83*' # alias

docker run --rm usethis/php-nginx:8.3 apk list --installed # all installed packages
docker run --rm usethis/php-nginx:8.3 apk list --upgradable # all upgradable packages
docker run --rm usethis/php-nginx:8.3 apk list php83* --installed # installed php83* versions
```

### Get original config files from a docker container

The idea is to first create (no need to start) a container, then copy the file to the host, then remove the container again.

```bash
docker create --name temp nginx:alpine && docker cp temp:/etc/nginx/nginx.conf ./original~nginx.conf ; docker rm -f temp

docker create --name temp nginx:alpine && docker cp temp:/etc/nginx/conf.d/default.conf ./original~nginx~conf.d~default.conf ; docker rm -f temp

docker create --name temp usethis/php-nginx:8.3 && docker cp temp:/etc/supervisord.conf ./original~supervisord.conf ; docker rm -f temp

docker create --name temp usethis/php-nginx:8.3 && docker cp temp:/etc/php83/php.ini ./original~php83~php.ini ; docker rm -f temp

docker create --name temp usethis/php-nginx:8.2 && docker cp temp:/etc/php82/php.ini ./original~php82~php.ini ; docker rm -f temp
```
