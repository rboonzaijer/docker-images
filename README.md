# freshcontainer

Docker images for a quick starting point - [daily automated builds](https://github.com/rboonzaijer/freshcontainer/blob/main/.github/workflows/build-and-push-containers.yml)

![workflow](https://github.com/rboonzaijer/freshcontainer/actions/workflows/build-and-push-containers.yml/badge.svg)

https://hub.docker.com/r/freshcontainer

| image | from | details |
|-|-|-|
freshcontainer/alpine:latest | alpine:latest | user:appuser, group:appgroup, uid=1000, gid=1000 |
freshcontainer/nginx:latest | freshcontainer/alpine:latest | nginx |
freshcontainer/php-nginx:8.3 | freshcontainer/nginx:latest | nginx, php8.3, supervisor |
freshcontainer/php-nginx:8.3-dev | freshcontainer/php-nginx:8.3 | nginx, php8.3, supervisor, node/npm, composer |
freshcontainer/php-nginx:8.2 | freshcontainer/nginx:latest | nginx, php8.2, supervisor |
freshcontainer/php-nginx:8.2-dev | freshcontainer/php-nginx:8.3 | nginx, php8.2, supervisor, node/npm, composer |

For more details, look inside the Dockerfiles

## alpine

```bash
docker run --rm freshcontainer/alpine:latest sh -c 'whoami && groups && id -u && id -g && pwd && ls -la'
```

## curl

```bash
docker run --rm freshcontainer/curl:latest curl --version
```

```bash
docker run --rm -v .:/app freshcontainer/curl:latest curl -o result.md https://raw.githubusercontent.com/rboonzaijer/freshcontainer/main/README.md
```

## nginx

```bash
docker run --rm freshcontainer/nginx:latest nginx -v
```

```bash
docker volume create nginx_logs
docker run --rm -p 80:80 -v nginx_logs:/var/log/nginx -v nginx_www:/var/www/html freshcontainer/nginx

docker run --rm -v nginx_logs:/vol freshcontainer/alpine tail -n 10 /vol/nginx-default-access.log
docker run --rm -v nginx_logs:/vol freshcontainer/alpine tail -n 10 /vol/nginx-default-error.log
```

## php-nginx

```bash
docker run --rm freshcontainer/php-nginx:8.3 sh -c 'php -m && php -v'
docker run --rm freshcontainer/php-nginx:8.3-dev sh -c 'node -v && npm -v && composer diagnose'

docker run --rm freshcontainer/php-nginx:8.2 sh -c 'php -m && php -v'
docker run --rm freshcontainer/php-nginx:8.2-dev sh -c 'node -v && npm -v && composer diagnose'
```

## imagemagick

```bash
docker run --rm freshcontainer/imagemagick:latest sh -c 'gs --version && convert -version'
```

```bash
docker run --rm -v ./imagemagick:/app freshcontainer/imagemagick:latest convert logo.png target-logo.webp
```

## Info

```bash
# Scan containers
docker run --rm aquasec/trivy image freshcontainer/alpine:latest
docker run --rm aquasec/trivy image freshcontainer/nginx:latest
docker run --rm aquasec/trivy image freshcontainer/php-nginx:8.3
docker run --rm aquasec/trivy image freshcontainer/php-nginx:8.3-dev
docker run --rm aquasec/trivy image freshcontainer/php-nginx:8.2
docker run --rm aquasec/trivy image freshcontainer/php-nginx:8.2-dev
docker run --rm aquasec/trivy image freshcontainer/imagemagick:latest
docker run --rm aquasec/trivy image freshcontainer/curl:latest

# Find more alpine apk packages with 'apk list'
docker run --rm freshcontainer/alpine apk list php83*
```
