# Docker images - roelscript/img

Docker images for a quick starting point - [daily automated builds](https://github.com/rboonzaijer/docker-images/blob/main/.github/workflows/auto-build-and-push.yml)

![workflow](https://github.com/rboonzaijer/docker-images/actions/workflows/auto-build-and-push.yml/badge.svg)

https://hub.docker.com/r/roelscript/img/tags

# NOTE BEFORE USE!
- Changes can be applied at any given time
- Deprecated versions can be removed at any given time (from this repo and from the Docker registry)
- So if you want to use this in production, please create a fork (or just copy the Dockerfiles you need) and push images to your own docker registry to make sure everything stays running on your end (just replace 'roelscript' in all files with your own name)
- The reason everything is in 1 image (roelscript/img) is so that Docker Scout can scan every tag for vulnerabilities (max 3 images on the [Docker Scout Free tier](https://www.docker.com/products/docker-scout/)) - You can also scan the images yourself with 'aquasec/trivy' (see below for examples)
- For PHP versions, check: https://www.php.net/supported-versions.php and https://php.watch/versions

| image | from | details |
|-|-|-|
[`roelscript/img:alpine`](alpine/Dockerfile) | alpine:latest | appuser:appgroup (1000:1000) |
[`roelscript/img:imagemagick`](imagemagick/Dockerfile) | roelscript/img:alpine | imagemagick, ghostscript |
[`roelscript/img:nginx`](nginx/Dockerfile) | roelscript/img:alpine | nginx |
[`roelscript/img:php-nginx-8.3`](php-nginx/8.3/Dockerfile) | roelscript/img:nginx | nginx, php8.3, supervisor |
[`roelscript/img:php-nginx-8.3-dev`](php-nginx/8.3-dev/Dockerfile) | roelscript/img:php-nginx-8.3 | nginx, php8.3, supervisor, node/npm, composer |
[`roelscript/img:php-nginx-8.2`](php-nginx/8.2/Dockerfile) | roelscript/img:nginx | nginx, php8.2, supervisor |
[`roelscript/img:php-nginx-8.2-dev`](php-nginx/8.2-dev/Dockerfile) | roelscript/img:php-nginx-8.2 | nginx, php8.2, supervisor, node/npm, composer |

For more details, look inside the Dockerfiles

## alpine

(updated, non-root)

```bash
docker run --rm roelscript/img:alpine sh -c 'whoami && groups && id -u && id -g && pwd && touch test.txt && ls -la /app/test.txt'
```

Output:

```
appuser
appgroup
1000
1000
/app
-rw-r--r--    1 appuser  appgroup         0 May 17 11:31 /app/test.txt
```

## imagemagick

imagemagick + ghostscript (with enabled policies to convert images to PDF etc)

```bash
docker run --rm roelscript/img:imagemagick sh -c 'gs --version && convert -version'
```

```bash
docker run --rm -v ./imagemagick:/app roelscript/img:imagemagick convert logo.png target-logo.webp
```

## nginx

```bash
docker run --rm roelscript/img:nginx nginx -v
```

```bash
docker volume create nginx_logs
docker run --rm -p 80:80 -v nginx_logs:/var/log/nginx -v nginx_www:/var/www/html roelscript/img:nginx

docker run --rm -v nginx_logs:/vol roelscript/img:alpine ls -la /vol
```

# php-nginx

```bash
docker run --rm roelscript/img:php-nginx-8.3 sh -c 'php -m && php -v'
docker run --rm roelscript/img:php-nginx-8.3-dev sh -c 'node -v && npm -v && composer diagnose'

docker run --rm roelscript/img:php-nginx-8.2 sh -c 'php -m && php -v'
docker run --rm roelscript/img:php-nginx-8.2-dev sh -c 'node -v && npm -v && composer diagnose'
```

# Other docker commands

### Scan containers locally for vulnerabilities

```bash
# Note: there can be vulnerabilities in the official image if they havent been updated recently, so make sure you update/upgrade the alpine image (with a custom Dockerfile) if you use it:
docker run --rm aquasec/trivy image alpine:latest

# These are daily updated:
docker run --rm aquasec/trivy image roelscript/img:alpine
docker run --rm aquasec/trivy image roelscript/img:imagemagick
docker run --rm aquasec/trivy image roelscript/img:nginx
docker run --rm aquasec/trivy image roelscript/img:php-nginx-8.3
docker run --rm aquasec/trivy image roelscript/img:php-nginx-8.3-dev
docker run --rm aquasec/trivy image roelscript/img:php-nginx-8.2
docker run --rm aquasec/trivy image roelscript/img:php-nginx-8.2-dev
```

### Get most recent tags for a docker image

https://docs.docker.com/docker-hub/api/latest/#tag/repositories

Example: roelscript/img:... (note: only the most recent 100 tags are fetched)

```bash
docker run --rm roelscript/img:alpine wget -q -O- "https://hub.docker.com/v2/namespaces/roelscript/repositories/img/tags?page_size=100&page=1" | grep -o '"name": *"[^"]*' | grep -o '[^"]*$'
```

For official docker images use the namespace 'library':

```bash
docker run --rm roelscript/img:alpine wget -q -O- "https://hub.docker.com/v2/namespaces/library/repositories/alpine/tags?page_size=100&page=1" | grep -o '"name": *"[^"]*' | grep -o '[^"]*$'
```

### Debug package versions with 'apk list'

```bash
docker run --rm roelscript/img:alpine apk list php83* # list all available php83* packages
docker run --rm alpine:latest sh -c 'apk fix && apk list php83*' # alias

docker run --rm roelscript/img:php-nginx-8.3 apk list --installed # all installed packages
docker run --rm roelscript/img:php-nginx-8.3 apk list --upgradable # all upgradable packages
docker run --rm roelscript/img:php-nginx-8.3 apk list php83* --installed # installed php83* versions
```

### Download a file

```bash
docker run --rm -v .:/app roelscript/img:alpine wget -O Dockerfile.alpine https://raw.githubusercontent.com/rboonzaijer/docker-images/main/alpine/Dockerfile

# or keep the original name
docker run --rm -v .:/app roelscript/img:alpine wget https://raw.githubusercontent.com/rboonzaijer/docker-images/main/alpine/Dockerfile
```

### Get original config files from a docker container

The idea is to first create (no need to start) a container, then copy the file to the host, then remove the container again.

```bash
docker create --name temp nginx:alpine && docker cp temp:/etc/nginx/nginx.conf ./original~nginx.conf ; docker rm -f temp

docker create --name temp nginx:alpine && docker cp temp:/etc/nginx/conf.d/default.conf ./original~nginx~conf.d~default.conf ; docker rm -f temp

docker create --name temp roelscript/img:php-nginx-8.3 && docker cp temp:/etc/supervisord.conf ./original~supervisord.conf ; docker rm -f temp

docker create --name temp roelscript/img:php-nginx-8.3 && docker cp temp:/etc/php83/php.ini ./original~php83~php.ini ; docker rm -f temp

docker create --name temp roelscript/img:php-nginx-8.2 && docker cp temp:/etc/php82/php.ini ./original~php82~php.ini ; docker rm -f temp
```
