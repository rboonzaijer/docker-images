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

## Example: Download a file

```bash
docker run --rm -u $(id -u):$(id -g) -v .:/app usethis/alpine wget -O Dockerfile.alpine https://raw.githubusercontent.com/rboonzaijer/docker-images/main/alpine/Dockerfile

# or keep the original name
docker run --rm -u $(id -u):$(id -g) -v .:/app usethis/alpine wget https://raw.githubusercontent.com/rboonzaijer/docker-images/main/alpine/Dockerfile
```

## Example: Backup/restore a named docker volume

#### Backup

```bash
# tar (fastest, no compression, bigger file)
docker run --rm -u $(id -u):$(id -g) -v my_volume:/vol -v .:/app usethis/alpine tar c -f my_backup.tar -C /vol .

# tar.gz (add -z + extension .tar.gz) - smaller but slower
docker run --rm -u $(id -u):$(id -g) -v my_volume:/vol -v .:/app usethis/alpine tar c -z -f my_backup.tar.gz -C /vol .
```

#### Restore

```bash
# make sure you always start with a new/clean volume
docker volume create my_volume
```

use root user to restore to set permissions (-u 0:0)

```bash
# tar (fastest, no compression, bigger file)
docker run --rm -u 0:0 -v my_volume:/vol -v .:/app usethis/alpine tar x -f my_backup.tar -C /vol .

# tar.gz (add -z + extension .tar.gz) - smaller but slower
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
