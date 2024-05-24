[<< Go back](../README.md#overview)

https://hub.docker.com/r/usethis/nginx/tags

# Docker image: nginx

- `usethis/nginx` [Dockerfile](1/Dockerfile)

```bash
docker run --rm usethis/nginx nginx -v
```

## Quick test

```bash
# Create a volume for the logs
docker volume rm testnginx_vol; docker volume create testnginx_vol

# Start nginx, simulate web requests, and stop the container again
docker run --name testnginx --rm -d -p 8761:80 -v testnginx_vol:/var/log/nginx -v nginx_www:/var/www/html usethis/nginx

docker run --rm --link=testnginx usethis/alpine sh -c 'wget http://testnginx; wget http://testnginx/test; wget http://testnginx/robots.txt; wget http://testnginx/non-existing-page; wget http://testnginx/another-error-page-request'

docker stop testnginx


# Now check the logs
docker run --rm -v testnginx_vol:/vol usethis/alpine ls -la /vol
docker run --rm -v testnginx_vol:/vol usethis/alpine cat /vol/default.access.log
docker run --rm -v testnginx_vol:/vol usethis/alpine cat /vol/default.error.log
```
