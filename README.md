# alpinebase

Docker images for a quick starting point - [daily automated builds](https://github.com/rboonzaijer/alpinebase/blob/main/.github/workflows/build-and-push-containers.yml)

![workflow](https://github.com/rboonzaijer/alpinebase/actions/workflows/auto-build-and-push.yml/badge.svg)

https://hub.docker.com/r/alpinebase

| image | from | details |
|-|-|-|
alpinebase/img | alpinebase/img:alpine | (alias) |
alpinebase/img:latest | alpinebase/img:alpine | (alias) |
alpinebase/img:alpine | alpine:latest | user:appuser, group:appgroup, uid=1000, gid=1000 |
alpinebase/img:curl | alpinebase/img:alpine | curl |
alpinebase/img:imagemagick | alpinebase/img:alpine | imagemagick, ghostscript |
alpinebase/img:nginx | alpinebase/img:alpine | nginx |
alpinebase/img:php-nginx-8.3 | alpinebase/img:nginx | nginx, php8.3, supervisor |
alpinebase/img:php-nginx-8.3-dev | alpinebase/img:php-nginx-8.3 | nginx, php8.3, supervisor, node/npm, composer |

For more details, look inside the Dockerfiles

## alpine

- [`alpinebase/img:alpine`](alpine/Dockerfile)
- `alpinebase/img:latest` (alias)
- `alpinebase/img` (alias)

```bash
docker run --rm alpinebase/img sh -c 'whoami && groups && id -u && id -g && pwd && ls -la'
```

## curl

- [`alpinebase/img:curl`](curl/Dockerfile)

```bash
docker run --rm alpinebase/img:curl curl --version
```

```bash
docker run --rm -v .:/app alpinebase/img:curl curl -o result.md https://raw.githubusercontent.com/rboonzaijer/alpinebase/main/README.md
```

## imagemagick

- [`alpinebase/img:imagemagick`](imagemagick/Dockerfile)

```bash
docker run --rm alpinebase/img:imagemagick sh -c 'gs --version && convert -version'
```

```bash
docker run --rm -v ./imagemagick:/app alpinebase/img:imagemagick convert logo.png target-logo.webp
```

## nginx

- [`alpinebase/img:nginx`](nginx/Dockerfile)

```bash
docker run --rm alpinebase/img:nginx nginx -v
```

```bash
docker volume create nginx_logs
docker run --rm -p 80:80 -v nginx_logs:/var/log/nginx -v nginx_www:/var/www/html alpinebase/img:nginx

docker run --rm -v nginx_logs:/vol alpinebase/img ls -la /vol
```

# php-nginx

- [`alpinebase/img:php-nginx-8.3`](php-nginx/8.3/Dockerfile)
- [`alpinebase/img:php-nginx-8.3-dev`](php-nginx/8.3-dev/Dockerfile)

```bash
docker run --rm alpinebase/img:php-nginx-8.3 sh -c 'php -m && php -v'
docker run --rm alpinebase/img:php-nginx-8.3-dev sh -c 'node -v && npm -v && composer diagnose'
```

# more info

```bash
# Scan containers locally for vulnerabilities
docker run --rm aquasec/trivy image alpinebase/img
docker run --rm aquasec/trivy image alpinebase/img:alpine
docker run --rm aquasec/trivy image alpinebase/img:curl
docker run --rm aquasec/trivy image alpinebase/img:imagemagick
docker run --rm aquasec/trivy image alpinebase/img:nginx
docker run --rm aquasec/trivy image alpinebase/img:php-nginx-8.3
docker run --rm aquasec/trivy image alpinebase/img:php-nginx-8.3-dev

# Find more alpine apk packages with 'apk list'
docker run --rm alpinebase/img apk list php83*
```
