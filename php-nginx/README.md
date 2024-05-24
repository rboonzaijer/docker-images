[<< Go back](../README.md#overview)

https://hub.docker.com/u/usethis

# Docker image: php-nginx

- `usethis/php-nginx:8.3-1` [Dockerfile](8.3-1/Dockerfile)
- `usethis/php-nginx:8.3-1-dev` [Dockerfile](8.3-1-dev/Dockerfile)
- `usethis/php-nginx:8.2-1` [Dockerfile](8.2-1/Dockerfile)
- `usethis/php-nginx:8.2-1-dev` [Dockerfile](8.2-1-dev/Dockerfile)

```bash
docker run --rm usethis/php-nginx:8.3-1 sh -c 'php -m && php -v'
docker run --rm usethis/php-nginx:8.3-1-dev sh -c 'node -v; npm -v; echo ''; composer diagnose; echo ''; php -v'

docker run --rm usethis/php-nginx:8.2-1 sh -c 'php -m && php -v'
docker run --rm usethis/php-nginx:8.2-1-dev sh -c 'node -v; npm -v; echo ''; composer diagnose; echo ''; php -v'
```
