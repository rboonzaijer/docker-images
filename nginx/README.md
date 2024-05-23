[<< Go back](../README.md#overview)

https://hub.docker.com/r/usethis/img/tags

# Docker image: nginx

- `usethis/img:nginx` [Dockerfile](Dockerfile)

```bash
docker run --rm usethis/img:nginx nginx -v
```

```bash
docker volume create nginx_logs
docker run --rm -p 80:80 -v nginx_logs:/var/log/nginx -v nginx_www:/var/www/html usethis/img:nginx

docker run --rm -v nginx_logs:/vol usethis/img:alpine ls -la /vol
```