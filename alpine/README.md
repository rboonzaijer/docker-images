[<< Go back](../README.md#overview)

https://hub.docker.com/r/roelscript/img/tags

# Docker image: alpine

- `roelscript/img:alpine` [Dockerfile](rootless/Dockerfile)
- `roelscript/img:alpine-nobody` [Dockerfile](nobody/Dockerfile)
- `roelscript/img:alpine-root` [Dockerfile](root/Dockerfile)

## Contents

- updated/upgraded packages
- choose between root or non-root user

## Alpine with new rootless user

```bash
docker run --rm roelscript/img:alpine sh -c 'whoami && groups && id -u && id -g && pwd && touch test.txt && ls -la /app/test.txt'
```

Output:

```
appuser
appgroup
1000
1000
/app
-rw-r--r--    1 appuser  appgroup         0 May 17 11:31 /app/test.txt
```

## Alpine with existing 'nobody' user

```bash
docker run --rm roelscript/img:alpine-nobody sh -c 'whoami && groups && id -u && id -g && pwd && touch test.txt && ls -la /app/test.txt'
```

Output:

```
nobody
nobody
65534
65534
/app
-rw-r--r--    1 nobody   nobody           0 May 18 09:23 /app/test.txt
```

## Alpine with root user

```bash
docker run --rm roelscript/img:alpine-root sh -c 'whoami && groups && id -u && id -g && pwd && touch test.txt && ls -la /app/test.txt'
```

Output:

```
root
root bin daemon sys adm disk wheel floppy dialout tape video
0
0
/app
-rw-r--r--    1 root     root             0 May 18 09:03 /app/test.txt
```

## Example: Backup/restore a named docker volume

#### Backup

```bash
# tar (fastest, no compression, bigger file)
docker run --rm -v my_volume:/vol -u 1000:1000 -v .:/app roelscript/img:alpine tar c -f my_backup.tar -C /vol .

# tar.gz (add -z + extension .tar.gz) - smaller but slower
docker run --rm -v my_volume:/vol -u 1000:1000 -v .:/app roelscript/img:alpine tar c -z -f my_backup.tar.gz -C /vol .
```

#### Restore (tar)

```bash
# make sure you always start with a new/clean volume
docker volume create my_volume
```

```bash
# tar (fastest, no compression, bigger file)
docker run --rm -v my_volume:/vol -v .:/app roelscript/img:alpine-root tar x -f my_backup.tar -C /vol .

# tar.gz (add -z + extension .tar.gz) - smaller but slower
docker run --rm -v my_volume:/vol -v .:/app roelscript/img:alpine-root tar x -z -f my_backup.tar.gz -C /vol .
```

### Debugging backup

```bash
# Create a new/clean volume (remove existing)
docker volume rm my_volume; docker volume create my_volume

# Fill it with some data
docker run --rm -v my_volume:/app roelscript/img:alpine-root sh -c 'echo "root" > test-root-0.txt; echo "nobody" > test-nobody-65534.txt; echo "another" > test-another-12345.txt; chown nobody:nobody test-nobody-65534.txt; chown 12345:54321 test-another-12345.txt; ls -la'

# Look inside the volume
docker run --rm -v my_volume:/app roelscript/img:alpine ls -la

# Backup ('tar c') with non-root, run as your own user to save the file under your name: mount the named volume to /vol, and the current directory to /app, then create the tar in /app :
docker run --rm -u 1000:1000 -v my_volume:/vol -v .:/app roelscript/img:alpine tar c -f my_backup.tar -C /vol .

# Look inside to check (permissions should be untouched)
docker run --rm -v .:/app roelscript/img:alpine tar t -v -f my_backup.tar
```

### Debugging restore

```bash
# Make sure you always start with a new/clean volume
docker volume rm my_volume; docker volume create my_volume

# Make sure the volume is empty
docker run --rm -v my_volume:/app roelscript/img:alpine ls -la

# Restore ('tar x') with alpine-root image for permissions: mount the named volume to /vol, and the current directory to /app, then extract the tar to /vol :
docker run --rm -v my_volume:/vol -v .:/app roelscript/img:alpine-root tar x -f my_backup.tar -C /vol .

# Look inside the volume, the permissions should be correct
docker run --rm -v my_volume:/app roelscript/img:alpine ls -la
```
