[<< Go back](../README.md#overview)

https://hub.docker.com/u/usethis

# Docker image: nginx

- `usethis/nginx:1` [Dockerfile](1/Dockerfile)

```bash
docker run --rm usethis/nginx:1 nginx -v
```

```bash
docker volume create nginx_logs
docker run --rm -p 80:80 -v nginx_logs:/var/log/nginx -v nginx_www:/var/www/html usethis/nginx:1

docker run --rm -v nginx_logs:/vol usethis/alpine ls -la /vol
```