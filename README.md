# Docker images

Docker images for a quick starting point - [https://hub.docker.com/u/rboonzaijer](https://hub.docker.com/u/rboonzaijer)

Daily automated builds: [https://github.com/rboonzaijer/docker-images/actions](https://github.com/rboonzaijer/docker-images/actions)

![workflow](https://github.com/rboonzaijer/docker-images/actions/workflows/daily-auto-build-and-push-docker-images.yml/badge.svg)

### NOTE BEFORE USE!

- Changes can be applied at any given time
- Deprecated/outdated versions may be removed at any given time (from this repo and from the Docker registry)
- If you want to use this in production, please create a fork (or just copy the Dockerfiles you need) and push images to your own docker registry to make sure everything stays running on your end (just replace 'rboonzaijer' in all files with your own name)
- For PHP versions, check: https://www.php.net/supported-versions.php and https://php.watch/versions

## Overview

Click on the 'readme' for more info about the images.

### Base images

- updates
- rootless (user: nobody)

| image | from | notes
|-|-|-|
`rboonzaijer/alpine:latest` [readme](alpine/README.md) | alpine:latest | |
`rboonzaijer/alpine-3.19` [readme](alpine/README.md) | alpine:3.19 | for php8.1 |

### Custom images

| image | from base image | notes |
|-|-|-|
`rboonzaijer/python:3` [readme](python/README.md) | rboonzaijer/alpine:latest | |
`rboonzaijer/ansible:latest` [readme](ansible/README.md) | rboonzaijer/python:3 | |
`rboonzaijer/node:latest` [readme](node/README.md) | rboonzaijer/alpine:latest | |
`rboonzaijer/imagemagick:latest` [readme](imagemagick/README.md) | rboonzaijer/alpine:latest | |
`rboonzaijer/nginx:latest` [readme](nginx/README.md) | rboonzaijer/alpine:latest | |
`rboonzaijer/nginx:alpine-3.19` [readme](nginx/README.md) | rboonzaijer/alpine-3.19 | for php8.1 |
`rboonzaijer/php-nginx:8.3` [readme](php-nginx/README.md) | rboonzaijer/nginx:latest | |
`rboonzaijer/php-nginx:8.3-dev` [readme](php-nginx/README.md) | rboonzaijer/php-nginx:8.3 | |
`rboonzaijer/php-nginx:8.2` [readme](php-nginx/README.md) | rboonzaijer/nginx:latest | |
`rboonzaijer/php-nginx:8.2-dev` [readme](php-nginx/README.md) | rboonzaijer/php-nginx:8.2 | |
`rboonzaijer/php-nginx:8.1` [readme](php-nginx/README.md) | rboonzaijer/nginx:alpine-3.19 | alpine 3.19 |
`rboonzaijer/php-nginx:8.1-dev` [readme](php-nginx/README.md) | rboonzaijer/php-nginx:8.1 | alpine 3.19 |

## Docker commands

### Scan containers locally for vulnerabilities

```bash
docker run --rm aquasec/trivy image rboonzaijer/alpine:latest
docker run --rm aquasec/trivy image rboonzaijer/nginx:latest
docker run --rm aquasec/trivy image rboonzaijer/php-nginx:8.3
```

#### Cache vulneratility db (faster scanning multiple images)

```bash
# Create fresh cache
docker volume rm trivy_cache; docker volume create trivy_cache
docker run --rm -v trivy_cache:/trivy_cache aquasec/trivy image --cache-dir /trivy_cache --download-db-only

# Now scan images with the cached db
docker run --rm -v trivy_cache:/trivy_cache aquasec/trivy image --cache-dir /trivy_cache --skip-db-update alpine:latest
docker run --rm -v trivy_cache:/trivy_cache aquasec/trivy image --cache-dir /trivy_cache --skip-db-update rboonzaijer/alpine:latest

# Or local image (mount docker.sock to find local image)
docker pull alpine:latest && docker tag alpine:latest local/alpine/img

docker run --rm -v trivy_cache:/trivy_cache -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy image --cache-dir /trivy_cache --skip-db-update local/alpine/img

docker rmi local/alpine/img
```

#### Scan tar image

```bash
docker pull rboonzaijer/alpine:latest
docker save rboonzaijer/alpine:latest -o alpine-rb.tar

docker run --rm -v .:/img aquasec/trivy image --severity=UNKNOWN,LOW,MEDIUM,HIGH,CRITICAL --scanners=vuln,secret,config --ignore-unfixed=false --exit-code=1 --input=/img/alpine-rb.tar || echo 'issues found'
rm alpine-rb.tar
```

### Get most recent pushed tags for any docker image

- https://docs.docker.com/docker-hub/api/latest/#tag/repositories
- Note: only the most recent 100 tags are fetched (page 1)

```bash
docker run --rm rboonzaijer/alpine wget -q -O- "https://hub.docker.com/v2/namespaces/rboonzaijer/repositories/php-nginx/tags?page_size=100&page=1" | grep -o '"name": *"[^"]*' | grep -o '[^"]*$'
```

- For official docker images use the namespace 'library' (like 'alpine')

```bash
docker run --rm rboonzaijer/alpine wget -q -O- "https://hub.docker.com/v2/namespaces/library/repositories/alpine/tags?page_size=100&page=1" | grep -o '"name": *"[^"]*' | grep -o '[^"]*$'
```

### View package versions with 'apk list'

```bash
docker run --rm rboonzaijer/alpine apk list php83*

# list packages in a specific container:
docker run --rm rboonzaijer/php-nginx:8.3 apk list --installed
docker run --rm rboonzaijer/php-nginx:8.3 apk list --upgradable
docker run --rm rboonzaijer/php-nginx:8.3 apk list php83* --installed
```

### Get original config files

- this will install a clean clean package in alpine linux
- to get other config files: just change the PACKAGE and SRC variables
- includes the original file permissions in the filename
- includes a cleaned version (without comments starting with # or ;)
- sets permissions for the output files to read+write (666) for convenience

```bash
docker pull alpine:latest

# nginx: /etc/nginx/nginx.conf
docker run --rm --name=temp -v $(pwd):/app alpine:latest sh -c 'PACKAGE="nginx" && SRC="/etc/nginx/nginx.conf" && apk add -U --no-cache ${PACKAGE} && PERM=$(stat -c "%A %a" $SRC) && FILENAME="$PACKAGE|$PERM|$(echo "$SRC"|sed 's#/#~#g')" && TARGET="/app/~original-exact|${FILENAME}" && TARGET_CLEAN="/app/~original-clean|${FILENAME}" && cp "${SRC}" "${TARGET}" && sed -e "/^[ \t]*#/d" -e "/^;/d" -e "/^#/d" "${TARGET}" | sed "/^$/d" > "${TARGET_CLEAN}" && chmod 666 "${TARGET}" "${TARGET_CLEAN}"'

# php83: /etc/php83/php.ini
docker run --rm --name=temp -v $(pwd):/app alpine:latest sh -c 'PACKAGE="php83" && SRC="/etc/php83/php.ini" && apk add -U --no-cache ${PACKAGE} && PERM=$(stat -c "%A %a" $SRC) && FILENAME="$PACKAGE|$PERM|$(echo "$SRC"|sed 's#/#~#g')" && TARGET="/app/~original-exact|${FILENAME}" && TARGET_CLEAN="/app/~original-clean|${FILENAME}" && cp "${SRC}" "${TARGET}" && sed -e "/^[ \t]*#/d" -e "/^;/d" -e "/^#/d" "${TARGET}" | sed "/^$/d" > "${TARGET_CLEAN}" && chmod 666 "${TARGET}" "${TARGET_CLEAN}"'

# supervisor: /etc/supervisord.conf
docker run --rm --name=temp -v $(pwd):/app alpine:latest sh -c 'PACKAGE="supervisor" && SRC="/etc/supervisord.conf" && apk add -U --no-cache ${PACKAGE} && PERM=$(stat -c "%A %a" $SRC) && FILENAME="$PACKAGE|$PERM|$(echo "$SRC"|sed 's#/#~#g')" && TARGET="/app/~original-exact|${FILENAME}" && TARGET_CLEAN="/app/~original-clean|${FILENAME}" && cp "${SRC}" "${TARGET}" && sed -e "/^[ \t]*#/d" -e "/^;/d" -e "/^#/d" "${TARGET}" | sed "/^$/d" > "${TARGET_CLEAN}" && chmod 666 "${TARGET}" "${TARGET_CLEAN}"'

# Output:
-rw-rw-rw-  1 root root   846 Nov 23 15:26 '~original-clean|nginx|-rw-r--r-- 644|~etc~nginx~nginx.conf'
-rw-rw-rw-  1 root root  2819 Nov 23 15:26 '~original-clean|php83|-rw-r--r-- 644|~etc~php83~php.ini'
-rw-rw-rw-  1 root root   412 Nov 23 15:26 '~original-clean|supervisor|-rw------- 600|~etc~supervisord.conf'
-rw-rw-rw-  1 root root  3214 Nov 23 15:26 '~original-exact|nginx|-rw-r--r-- 644|~etc~nginx~nginx.conf'
-rw-rw-rw-  1 root root 73399 Nov 23 15:26 '~original-exact|php83|-rw-r--r-- 644|~etc~php83~php.ini'
-rw-rw-rw-  1 root root 10714 Nov 23 15:26 '~original-exact|supervisor|-rw------- 600|~etc~supervisord.conf'
```
