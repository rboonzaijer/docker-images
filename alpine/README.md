[<< Go back](../README.md#overview)

https://hub.docker.com/r/usethis/alpine/tags

# Docker image: alpine

- `usethis/alpine:latest` [Dockerfile](Dockerfile)

## Contents

- updated/upgraded packages
- choose between root or non-root user

## Alpine

```bash
docker run --rm usethis/alpine sh -c 'whoami && groups && id -u && id -g && pwd && touch test.txt && ls -la /app/test.txt'
```

Output:

```
nobody
nobody
65534
65534
/app
-rw-r--r--    1 nobody   nobody           0 May 24 12:58 /app/test.txt
```

## Example: Use another user/group instead of 'nobody'

```bash
FROM usethis/alpine:latest # (or any other...)

# switch temporarily to root to get installation permissions
USER root

# update/upgrade all packages to avoid vulnerabilities in your image,
# especially if you use a base-image that has not been updated in a long time
# tip: scan your final image: `docker run --rm aquasec/trivy image mygroup/myimage:0.1.0`
RUN apk update && \
    apk upgrade -a

# add a group 'appgroup' with gid 1000 and a user 'appuser' with uid 1000:
RUN addgroup -g 1000 appgroup && \
    adduser -D -G appgroup -u 1000 appuser

# make the user the owner of /app
RUN chown -R appuser:appgroup /app

# make the appuser the default user for this image
USER appuser

CMD ["/bin/sh"]
```

## Example: Download a file

```bash
# set a custom filename (Dockerfile.alpine) like this:
docker run --rm -u $(id -u):$(id -g) -v .:/app usethis/alpine wget -O Dockerfile.alpine https://raw.githubusercontent.com/rboonzaijer/docker-images/main/alpine/Dockerfile

# or keep the original name:
docker run --rm -u $(id -u):$(id -g) -v .:/app usethis/alpine wget https://raw.githubusercontent.com/rboonzaijer/docker-images/main/alpine/Dockerfile
```

## Example: Backup/restore a named docker volume

- tar (fastest, no compression, bigger file)
- tar.gz (add -z + extension .tar.gz) - smaller but slower

#### Backup

```bash
# tar
docker run --rm -u $(id -u):$(id -g) -v my_volume:/vol -v .:/app usethis/alpine tar c -f my_backup.tar -C /vol .

# tar.gz
docker run --rm -u $(id -u):$(id -g) -v my_volume:/vol -v .:/app usethis/alpine tar c -z -f my_backup.tar.gz -C /vol .
```

#### Restore

```bash
# make sure you always start with a new/clean volume
docker volume create my_volume
```

use root user to restore to set permissions (-u 0:0)

```bash
# tar
docker run --rm -u 0:0 -v my_volume:/vol -v .:/app usethis/alpine tar x -f my_backup.tar -C /vol .

# tar.gz
docker run --rm -u 0:0 -v my_volume:/vol -v .:/app usethis/alpine tar x -z -f my_backup.tar.gz -C /vol .
```

### Debugging backup

```bash
# Create a new/clean volume (remove existing)
docker volume rm my_volume; docker volume create my_volume

# Fill it with some data
docker run --rm -u 0:0 -v my_volume:/app usethis/alpine sh -c 'echo "root" > test-root-0.txt; echo "normal" > test-1000.txt; echo "nobody" > test-nobody-65534.txt; echo "another" > test-another-12345.txt; chown nobody:nobody test-nobody-65534.txt; chown 1000:1000 test-1000.txt; chown 12345:54321 test-another-12345.txt; ls -la'

# Look inside the volume
docker run --rm -v my_volume:/app usethis/alpine ls -la

# Backup ('tar c'), run as your own user to save the file under your name: mount the named volume to /vol, and the current directory to /app, then create the tar in /app :
docker run --rm -u $(id -u):$(id -g) -v my_volume:/vol -v .:/app usethis/alpine tar c -f my_backup.tar -C /vol .

# Look inside to check (permissions should be untouched)
docker run --rm -v .:/app usethis/alpine tar t -v -f my_backup.tar
```

### Debugging restore

```bash
# Make sure you always start with a new/clean volume
docker volume rm my_volume; docker volume create my_volume

# Make sure the volume is empty
docker run --rm -v my_volume:/app usethis/alpine ls -la

# Restore ('tar x') as root user to set permissions correctly: mount the named volume to /vol, and the current directory to /app, then extract the tar to /vol :
docker run --rm -u 0:0 -v my_volume:/vol -v .:/app usethis/alpine tar x -f my_backup.tar -C /vol .

# Look inside the volume, the permissions should be correct
docker run --rm -v my_volume:/app usethis/alpine ls -la
```
