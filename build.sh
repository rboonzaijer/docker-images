#######################################
# Remove local images first (print the ids with -q, then remove them, so 'usethis/nginx:<none>' will also be removed)
docker rmi $(docker images -q usethis/*)

#######################################
# alpine
docker build --no-cache --build-arg FROM_IMAGE=alpine:latest -f ./alpine/Dockerfile -t usethis/alpine:latest .
docker build --no-cache --build-arg FROM_IMAGE=alpine:3.19 -f ./alpine/Dockerfile -t usethis/alpine:3.19 .

# imagemagick
docker build --no-cache --build-arg FROM_IMAGE=usethis/alpine:latest -f ./imagemagick/Dockerfile -t usethis/imagemagick:latest .

# nginx
docker build --no-cache --build-arg FROM_IMAGE=usethis/alpine:latest -f ./nginx/Dockerfile -t usethis/nginx:latest .
docker build --no-cache --build-arg FROM_IMAGE=usethis/alpine:3.19 -f ./nginx/Dockerfile -t usethis/nginx:alpine-3.19 . # for php8.1

# php-nginx 8.3
docker build --no-cache --build-arg FROM_IMAGE=usethis/nginx:latest -f ./php-nginx/8.3/Dockerfile -t usethis/php-nginx:8.3 .
docker build --no-cache --build-arg FROM_IMAGE=usethis/php-nginx:8.3 -f ./php-nginx/8.3-dev/Dockerfile -t usethis/php-nginx:8.3-dev .

# php-nginx 8.2
docker build --no-cache --build-arg FROM_IMAGE=usethis/nginx:latest -f ./php-nginx/8.2/Dockerfile -t usethis/php-nginx:8.2 .
docker build --no-cache --build-arg FROM_IMAGE=usethis/php-nginx:8.2 -f ./php-nginx/8.2-dev/Dockerfile -t usethis/php-nginx:8.2-dev .

# php-nginx 8.1 - may be removed at any time, you should upgrade: https://www.php.net/supported-versions.php
docker build --no-cache --build-arg FROM_IMAGE=usethis/nginx:alpine-3.19 -f ./php-nginx/8.1/Dockerfile -t usethis/php-nginx:8.1 .
docker build --no-cache --build-arg FROM_IMAGE=usethis/php-nginx:8.1 -f ./php-nginx/8.1-dev/Dockerfile -t usethis/php-nginx:8.1-dev .

#######################################
# List images
docker images usethis/*

EXPECTED_AMOUNT=11
AMOUNT_IMAGES_INC_HEADER=$(docker images usethis/* | wc -l)
AMOUNT_IMAGES=$(($AMOUNT_IMAGES_INC_HEADER - 1))

if [ $AMOUNT_IMAGES == $EXPECTED_AMOUNT ]; then
    echo -e "\nSUCCESS, $AMOUNT_IMAGES images were created."
else
    echo -e "\nERROR!\n\nThere should be $EXPECTED_AMOUNT images, but there are $AMOUNT_IMAGES\n\n"
fi
