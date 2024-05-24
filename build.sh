#######################################
# Remove local images first
docker images -a | grep "^usethis/*" | awk '{print $1":"$2}' | xargs docker rmi


#######################################
# Base images
docker build --no-cache --build-arg FROM_IMAGE=alpine:latest -f ./alpine/Dockerfile -t usethis/alpine:latest .
#docker build --no-cache --build-arg FROM_IMAGE=alpine:3.20 -f ./alpine/Dockerfile -t usethis/alpine:3.20 .
docker build --no-cache --build-arg FROM_IMAGE=alpine:3.19 -f ./alpine/Dockerfile -t usethis/alpine:3.19 .

# Images
docker build --no-cache --build-arg FROM_IMAGE=usethis/alpine:latest -f ./imagemagick/Dockerfile -t usethis/imagemagick:latest .

docker build --no-cache --build-arg FROM_IMAGE=usethis/alpine:latest -f ./nginx/1/Dockerfile -t usethis/nginx:1 .
docker build --no-cache --build-arg FROM_IMAGE=usethis/alpine:3.19 -f ./nginx/1/Dockerfile -t usethis/nginx:1-3.19 . # for php8.1

docker build --no-cache --build-arg FROM_IMAGE=usethis/nginx:1 -f ./php-nginx/php8.3-nginx1/Dockerfile -t usethis/php-nginx:8.3-1 -t usethis/php-nginx:8.3 .
docker build --no-cache --build-arg FROM_IMAGE=usethis/php-nginx:8.3-1 -f ./php-nginx/php8.3-nginx1-dev/Dockerfile -t usethis/php-nginx:8.3-1-dev -t usethis/php-nginx:8.3-dev .

docker build --no-cache --build-arg FROM_IMAGE=usethis/nginx:1 -f ./php-nginx/php8.2-nginx1/Dockerfile -t usethis/php-nginx:8.2-1 -t usethis/php-nginx:8.2 .
docker build --no-cache --build-arg FROM_IMAGE=usethis/php-nginx:8.2-1 -f ./php-nginx/php8.2-nginx1-dev/Dockerfile -t usethis/php-nginx:8.2-1-dev -t usethis/php-nginx:8.2-dev .

# PHP8.1, may be removed at any time, you should upgrade: https://www.php.net/supported-versions.php
docker build --no-cache --build-arg FROM_IMAGE=usethis/nginx:1-3.19 -f ./php-nginx/php8.1-nginx1/Dockerfile -t usethis/php-nginx:8.1-1 -t usethis/php-nginx:8.1 .
docker build --no-cache --build-arg FROM_IMAGE=usethis/php-nginx:8.1-1 -f ./php-nginx/php8.1-nginx1-dev/Dockerfile -t usethis/php-nginx:8.1-1-dev -t usethis/php-nginx:8.1-dev .

#######################################
# List images
docker images usethis/*
