[<< Go back](../README.md#overview)

https://hub.docker.com/r/usethis/php-nginx/tags

# Docker image: php-nginx

- `usethis/php-nginx:8.3` [Dockerfile](php8.3-nginx1/Dockerfile)
- `usethis/php-nginx:8.3-dev` [Dockerfile](php8.3-nginx1-dev/Dockerfile)
- `usethis/php-nginx:8.2` [Dockerfile](php8.2-nginx1/Dockerfile)
- `usethis/php-nginx:8.2-dev` [Dockerfile](php8.2-nginx1-dev/Dockerfile)
- `usethis/php-nginx:8.1` [Dockerfile](php8.1-nginx1/Dockerfile)
- `usethis/php-nginx:8.1-dev` [Dockerfile](php8.1-nginx1-dev/Dockerfile)

```bash
docker run --rm usethis/php-nginx:8.3 sh -c 'php -m && php -v'
docker run --rm usethis/php-nginx:8.3-dev sh -c 'node -v; npm -v; echo ''; composer diagnose; echo ''; php -v'

docker run --rm usethis/php-nginx:8.2 sh -c 'php -m && php -v'
docker run --rm usethis/php-nginx:8.2-dev sh -c 'node -v; npm -v; echo ''; composer diagnose; echo ''; php -v'

docker run --rm usethis/php-nginx:8.1 sh -c 'php -m && php -v'
docker run --rm usethis/php-nginx:8.1-dev sh -c 'node -v; npm -v; echo ''; composer diagnose; echo ''; php -v'
```
