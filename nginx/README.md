[<< Go back](../README.md#overview)

https://hub.docker.com/r/roelscript/img/tags

# Docker image: nginx

- `roelscript/img:nginx` [Dockerfile](Dockerfile)

```bash
docker run --rm roelscript/img:nginx nginx -v
```

```bash
docker volume create nginx_logs
docker run --rm -p 80:80 -v nginx_logs:/var/log/nginx -v nginx_www:/var/www/html roelscript/img:nginx

docker run --rm -v nginx_logs:/vol roelscript/img:alpine ls -la /vol
```