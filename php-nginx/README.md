[<< Go back](../README.md#overview)

https://hub.docker.com/r/usethis/img/tags

# Docker image: php-nginx

- `usethis/img:php-nginx-8.3` [Dockerfile](8.3/Dockerfile)
- `usethis/img:php-nginx-8.3-dev` [Dockerfile](8.3-dev/Dockerfile)
- `usethis/img:php-nginx-8.2` [Dockerfile](8.2/Dockerfile)
- `usethis/img:php-nginx-8.2-dev` [Dockerfile](8.2-dev/Dockerfile)

```bash
docker run --rm usethis/img:php-nginx-8.3 sh -c 'php -m && php -v'
docker run --rm usethis/img:php-nginx-8.3-dev sh -c 'node -v; npm -v; echo ''; composer diagnose; echo ''; php -v'

docker run --rm usethis/img:php-nginx-8.2 sh -c 'php -m && php -v'
docker run --rm usethis/img:php-nginx-8.2-dev sh -c 'node -v; npm -v; echo ''; composer diagnose; echo ''; php -v'
```
