[<< Go back](../README.md#overview)

https://hub.docker.com/r/roelscript/img/tags

# Docker image: alpine

- `roelscript/img:alpine` [Dockerfile](rootless/Dockerfile)
- `roelscript/img:alpine-root` [Dockerfile](root/Dockerfile)

## Contents

- updated/upgraded packages
- choose between root or non-root user

## Alpine with rootless user (prefered)

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
