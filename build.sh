docker build -f ./alpine/Dockerfile -t roelscript/img:alpine .
docker build -f ./curl/Dockerfile -t roelscript/img:curl .
docker build -f ./imagemagick/Dockerfile -t roelscript/img:imagemagick .
docker build -f ./nginx/Dockerfile -t roelscript/img:nginx .
docker build -f ./php-nginx/8.3/Dockerfile -t roelscript/img:php-nginx-8.3 .
docker build -f ./php-nginx/8.3-dev/Dockerfile -t roelscript/img:php-nginx-8.3-dev .
docker build -f ./php-nginx/8.2/Dockerfile -t roelscript/img:php-nginx-8.2 .
docker build -f ./php-nginx/8.2-dev/Dockerfile -t roelscript/img:php-nginx-8.2-dev .

docker images roelscript/*
