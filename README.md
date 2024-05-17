# roelscript

Docker images for a quick starting point - [daily automated builds](https://github.com/rboonzaijer/roelscript/blob/main/.github/workflows/auto-build-and-push.yml)

![workflow](https://github.com/rboonzaijer/roelscript/actions/workflows/auto-build-and-push.yml/badge.svg)

https://hub.docker.com/r/roelscript/img/tags

| image | from | details |
|-|-|-|
[`roelscript/img:alpine`](alpine/Dockerfile) | alpine:latest | appuser:appgroup (1000:1000) |
[`roelscript/img:curl`](curl/Dockerfile) | roelscript/img:alpine | curl |
[`roelscript/img:imagemagick`](imagemagick/Dockerfile) | roelscript/img:alpine | imagemagick, ghostscript |
[`roelscript/img:nginx`](nginx/Dockerfile) | roelscript/img:alpine | nginx |
[`roelscript/img:php-nginx-8.3`](php-nginx/8.3/Dockerfile) | roelscript/img:nginx | nginx, php8.3, supervisor |
[`roelscript/img:php-nginx-8.3-dev`](php-nginx/8.3-dev/Dockerfile) | roelscript/img:php-nginx-8.3 | nginx, php8.3, supervisor, node/npm, composer |
[`roelscript/img:php-nginx-8.2`](php-nginx/8.2/Dockerfile) | roelscript/img:nginx | nginx, php8.2, supervisor |
[`roelscript/img:php-nginx-8.2-dev`](php-nginx/8.2-dev/Dockerfile) | roelscript/img:php-nginx-8.2 | nginx, php8.2, supervisor, node/npm, composer |

For more details, look inside the Dockerfiles

## alpine

```bash
docker run --rm roelscript/img:alpine sh -c 'whoami && groups && id -u && id -g && pwd && ls -la'
```

## curl

```bash
docker run --rm roelscript/img:curl curl --version
```

```bash
docker run --rm -v .:/app roelscript/img:curl curl -o result.md https://raw.githubusercontent.com/rboonzaijer/roelscript/main/README.md
```

## imagemagick

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

# more info

```bash
# Scan containers locally for vulnerabilities
docker run --rm aquasec/trivy image roelscript/img
docker run --rm aquasec/trivy image roelscript/img:alpine
docker run --rm aquasec/trivy image roelscript/img:curl
docker run --rm aquasec/trivy image roelscript/img:imagemagick
docker run --rm aquasec/trivy image roelscript/img:nginx
docker run --rm aquasec/trivy image roelscript/img:php-nginx-8.3
docker run --rm aquasec/trivy image roelscript/img:php-nginx-8.3-dev

# Find more alpine apk packages with 'apk list'
docker run --rm roelscript/img:alpine apk list php83*
```
