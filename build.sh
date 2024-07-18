#######################################
# Remove local images first (print the ids with -q, then remove them, so 'rboonzaijer/nginx:<none>' will also be removed)
docker rmi $(docker images -q rboonzaijer/*)

#######################################
# alpine
docker build --no-cache --build-arg FROM_IMAGE=alpine:latest -f ./alpine/Dockerfile -t rboonzaijer/alpine:latest .
docker build --no-cache --build-arg FROM_IMAGE=alpine:3.19 -f ./alpine/Dockerfile -t rboonzaijer/alpine:3.19 .

# python
docker build --no-cache --build-arg FROM_IMAGE=rboonzaijer/alpine:latest -f ./python/Dockerfile -t rboonzaijer/python:3 .

# ansible
docker build --no-cache --build-arg FROM_IMAGE=rboonzaijer/python:3 -f ./ansible/Dockerfile -t rboonzaijer/ansible:latest .

# node
docker build --no-cache --build-arg FROM_IMAGE=rboonzaijer/alpine:latest -f ./node/Dockerfile -t rboonzaijer/node:latest .

# imagemagick
docker build --no-cache --build-arg FROM_IMAGE=rboonzaijer/alpine:latest -f ./imagemagick/Dockerfile -t rboonzaijer/imagemagick:latest .

# nginx
docker build --no-cache --build-arg FROM_IMAGE=rboonzaijer/alpine:latest -f ./nginx/Dockerfile -t rboonzaijer/nginx:latest .
docker build --no-cache --build-arg FROM_IMAGE=rboonzaijer/alpine:3.19 -f ./nginx/Dockerfile -t rboonzaijer/nginx:alpine-3.19 . # for php8.1

# php-nginx 8.3
docker build --no-cache --build-arg FROM_IMAGE=rboonzaijer/nginx:latest -f ./php-nginx/8.3/Dockerfile -t rboonzaijer/php-nginx:8.3 .
docker build --no-cache --build-arg FROM_IMAGE=rboonzaijer/php-nginx:8.3 -f ./php-nginx/8.3-dev/Dockerfile -t rboonzaijer/php-nginx:8.3-dev .

# php-nginx 8.2
docker build --no-cache --build-arg FROM_IMAGE=rboonzaijer/nginx:latest -f ./php-nginx/8.2/Dockerfile -t rboonzaijer/php-nginx:8.2 .
docker build --no-cache --build-arg FROM_IMAGE=rboonzaijer/php-nginx:8.2 -f ./php-nginx/8.2-dev/Dockerfile -t rboonzaijer/php-nginx:8.2-dev .

# php-nginx 8.1 - may be removed at any time, you should upgrade: https://www.php.net/supported-versions.php
docker build --no-cache --build-arg FROM_IMAGE=rboonzaijer/nginx:alpine-3.19 -f ./php-nginx/8.1/Dockerfile -t rboonzaijer/php-nginx:8.1 .
docker build --no-cache --build-arg FROM_IMAGE=rboonzaijer/php-nginx:8.1 -f ./php-nginx/8.1-dev/Dockerfile -t rboonzaijer/php-nginx:8.1-dev .

#######################################
# List images
docker images rboonzaijer/*

# Scan all images
./scan.sh
