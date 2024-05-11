docker build -f ./alpine/Dockerfile -t alpinebase/img:alpine -t alpinebase/img:latest .
docker build -f ./curl/Dockerfile -t alpinebase/img:curl .
docker build -f ./imagemagick/Dockerfile -t alpinebase/img:imagemagick .
docker build -f ./nginx/Dockerfile -t alpinebase/img:nginx .
docker build -f ./php-nginx/8.3/Dockerfile -t alpinebase/img:php-nginx-8.3 .
docker build -f ./php-nginx/8.3-dev/Dockerfile -t alpinebase/img:php-nginx-8.3-dev .

docker images alpinebase/*
