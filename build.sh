#######################################
# Remove local images first
docker images -a | grep "^roelscript/*" | awk '{print $1":"$2}' | xargs docker rmi


#######################################
# Build images
docker build -f ./alpine/rootless/Dockerfile -t roelscript/img:alpine .
docker build -f ./alpine/root/Dockerfile -t roelscript/img:alpine-root .
docker build -f ./alpine/nobody/Dockerfile -t roelscript/img:alpine-nobody .

docker build -f ./imagemagick/Dockerfile -t roelscript/img:imagemagick .

docker build -f ./nginx/Dockerfile -t roelscript/img:nginx .

docker build -f ./php-nginx/8.3/Dockerfile -t roelscript/img:php-nginx-8.3 .
docker build -f ./php-nginx/8.3-dev/Dockerfile -t roelscript/img:php-nginx-8.3-dev .
docker build -f ./php-nginx/8.2/Dockerfile -t roelscript/img:php-nginx-8.2 .
docker build -f ./php-nginx/8.2-dev/Dockerfile -t roelscript/img:php-nginx-8.2-dev .


#######################################
# List images
docker images roelscript/*
