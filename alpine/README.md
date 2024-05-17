[<< Go back](../README.md#overview)

https://hub.docker.com/r/roelscript/img/tags

# Docker image: alpine

- `roelscript/img:alpine` [alpine/Dockerfile](Dockerfile)

## Contents

- updated/upgraded packages
- non-root user

## Example

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
