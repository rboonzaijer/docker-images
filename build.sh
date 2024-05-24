#######################################
# Remove local images first
docker images -a | grep "^usethis/*" | awk '{print $1":"$2}' | xargs docker rmi


#######################################
# Build images
docker pull alpine:latest

docker build --no-cache --build-arg ALPINE_VERSION=latest -f ./alpine/rootless/Dockerfile -t usethis/alpine:latest .
docker build --no-cache --build-arg ALPINE_VERSION=3.20 -f ./alpine/rootless/Dockerfile -t usethis/alpine:3.20 .
docker build --no-cache --build-arg ALPINE_VERSION=3.19 -f ./alpine/rootless/Dockerfile -t usethis/alpine:3.19 .

docker build --no-cache --build-arg ALPINE_VERSION=latest -f ./alpine/root/Dockerfile -t usethis/alpine:root .
docker build --no-cache --build-arg ALPINE_VERSION=3.20 -f ./alpine/root/Dockerfile -t usethis/alpine:root-3.20 .
docker build --no-cache --build-arg ALPINE_VERSION=3.19 -f ./alpine/root/Dockerfile  -t usethis/alpine:root-3.19 .

docker build --no-cache --build-arg ALPINE_VERSION=latest -f ./alpine/nobody/Dockerfile -t usethis/alpine:nobody .
docker build --no-cache --build-arg ALPINE_VERSION=3.20 -f ./alpine/nobody/Dockerfile -t usethis/alpine:nobody-3.20 .
docker build --no-cache --build-arg ALPINE_VERSION=3.19 -f ./alpine/nobody/Dockerfile -t usethis/alpine:nobody-3.19 .

docker build --no-cache --build-arg ALPINE_VERSION=latest -f ./imagemagick/Dockerfile -t usethis/imagemagick:latest .

docker build --no-cache --build-arg ALPINE_VERSION=latest -f ./nginx/1/Dockerfile -t usethis/nginx:1 .

docker build --no-cache --build-arg NGINX_VERSION=1 -f ./php-nginx/8.3-1/Dockerfile -t usethis/php-nginx:8.3-1 .
docker build --no-cache --build-arg PHP_NGINX_VERSION=8.3-1 -f ./php-nginx/8.3-1-dev/Dockerfile -t usethis/php-nginx:8.3-1-dev .
docker build --no-cache --build-arg NGINX_VERSION=1 -f ./php-nginx/8.2-1/Dockerfile -t usethis/php-nginx:8.2-1 .
docker build --no-cache --build-arg PHP_NGINX_VERSION=8.2-1 -f ./php-nginx/8.2-1-dev/Dockerfile -t usethis/php-nginx:8.2-1-dev .

#######################################
# List images
docker images usethis/*
