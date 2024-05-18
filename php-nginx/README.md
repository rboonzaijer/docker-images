[<< Go back](../README.md#overview)

https://hub.docker.com/r/roelscript/img/tags

# Docker image: php-nginx

- `roelscript/img:php-nginx-8.3` [Dockerfile](8.3/Dockerfile)
- `roelscript/img:php-nginx-8.3-dev` [Dockerfile](8.3-dev/Dockerfile)
- `roelscript/img:php-nginx-8.2` [Dockerfile](8.2/Dockerfile)
- `roelscript/img:php-nginx-8.2-dev` [Dockerfile](8.2-dev/Dockerfile)

```bash
docker run --rm roelscript/img:php-nginx-8.3 sh -c 'php -m && php -v'
docker run --rm roelscript/img:php-nginx-8.3-dev sh -c 'node -v && npm -v && composer diagnose'

docker run --rm roelscript/img:php-nginx-8.2 sh -c 'php -m && php -v'
docker run --rm roelscript/img:php-nginx-8.2-dev sh -c 'node -v && npm -v && composer diagnose'
```
