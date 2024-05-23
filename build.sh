#######################################
# Remove local images first
docker images -a | grep "^usethis/*" | awk '{print $1":"$2}' | xargs docker rmi


#######################################
# Build images
docker build --no-cache -f ./alpine/rootless/Dockerfile -t usethis/img:alpine -t usethis/alpine:latest .
docker build --no-cache -f ./alpine/rootless/Dockerfile --build-arg="ALPINE_VERSION=3.19" -t usethis/alpine:3.19 .

docker build --no-cache -f ./alpine/root/Dockerfile -t usethis/img:alpine-root .
docker build --no-cache -f ./alpine/nobody/Dockerfile -t usethis/img:alpine-nobody .

docker build --no-cache -f ./imagemagick/Dockerfile -t usethis/img:imagemagick .

docker build --no-cache -f ./nginx/Dockerfile -t usethis/img:nginx .

docker build --no-cache -f ./php-nginx/8.3/Dockerfile -t usethis/img:php-nginx-8.3 .
docker build --no-cache -f ./php-nginx/8.3-dev/Dockerfile -t usethis/img:php-nginx-8.3-dev .
docker build --no-cache -f ./php-nginx/8.2/Dockerfile -t usethis/img:php-nginx-8.2 .
docker build --no-cache -f ./php-nginx/8.2-dev/Dockerfile -t usethis/img:php-nginx-8.2-dev .

#######################################
# List images
docker images usethis/*
