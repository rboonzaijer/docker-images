# alpinebase

Docker images for a quick starting point - [daily automated builds](https://github.com/rboonzaijer/alpinebase/blob/main/.github/workflows/build-and-push-containers.yml)

![workflow](https://github.com/rboonzaijer/alpinebase/actions/workflows/auto-build-and-push.yml/badge.svg)

https://hub.docker.com/r/alpinebase

| image | from | details |
|-|-|-|
alpinebase/img:alpine | alpine:latest | user:appuser, group:appgroup, uid=1000, gid=1000 |
alpinebase/img:latest | alpinebase/img:alpine | an alias for alpinebase/img:alpine |
alpinebase/img:curl | alpinebase/img:alpine | curl |
alpinebase/img:imagemagick | alpinebase/img:alpine | imagemagick, ghostscript |
alpinebase/img:nginx | alpinebase/img:alpine | nginx |
alpinebase/img:php-nginx-8.3 | alpinebase/img:nginx | nginx, php8.3, supervisor |
alpinebase/img:php-nginx-8.3-dev | alpinebase/img:php-nginx-8.3 | nginx, php8.3, supervisor, node/npm, composer |

For more details, look inside the Dockerfiles

## alpine

```bash
docker run --rm alpinebase/img:alpine sh -c 'whoami && groups && id -u && id -g && pwd && ls -la'
```

## curl

```bash
docker run --rm alpinebase/img:curl curl --version
```

```bash
docker run --rm -v .:/app alpinebase/img:curl curl -o result.md https://raw.githubusercontent.com/rboonzaijer/alpinebase/main/README.md
```

## imagemagick

```bash
docker run --rm alpinebase/img:imagemagick sh -c 'gs --version && convert -version'
```

```bash
docker run --rm -v ./imagemagick:/app alpinebase/img:imagemagick convert logo.png target-logo.webp
```

## nginx

```bash
docker run --rm alpinebase/img:nginx nginx -v
```

```bash
docker volume create nginx_logs
docker run --rm -p 80:80 -v nginx_logs:/var/log/nginx -v nginx_www:/var/www/html alpinebase/img:nginx

docker run --rm -v nginx_logs:/vol alpinebase/img tail -n 10 /vol/nginx-default-access.log
docker run --rm -v nginx_logs:/vol alpinebase/img tail -n 10 /vol/nginx-default-error.log
```

## php-nginx

```bash
docker run --rm alpinebase/img:php-nginx-8.3 sh -c 'php -m && php -v'
docker run --rm alpinebase/img:php-nginx-8.3-dev sh -c 'node -v && npm -v && composer diagnose'
```

## Info

```bash
# Scan containers
docker run --rm aquasec/trivy image alpinebase/img
docker run --rm aquasec/trivy image alpinebase/img:alpine
docker run --rm aquasec/trivy image alpinebase/img:nginx
docker run --rm aquasec/trivy image alpinebase/img:php-nginx-8.3
docker run --rm aquasec/trivy image alpinebase/img:php-nginx-8.3-dev
docker run --rm aquasec/trivy image alpinebase/img:imagemagick
docker run --rm aquasec/trivy image alpinebase/img:curl

# Find more alpine apk packages with 'apk list'
docker run --rm alpinebase/img apk list php83*
```
