[<< Go back](../README.md#overview)

https://hub.docker.com/r/rboonzaijer/ubuntu/tags

# Docker image: ubuntu

- `rboonzaijer/ubuntu:latest` [Dockerfile](Dockerfile)

## Contents

- updated/upgraded packages
- user/group ubuntu:ubuntu

## Versions

```bash
docker run --rm rboonzaijer/ubuntu sh -c 'whoami && groups && id -u && id -g && pwd && touch test.txt && ls -la /app/test.txt'
```

Output:

```
ubuntu
ubuntu adm dialout cdrom floppy sudo audio dip video plugdev
1000
1000
/app
-rw-r--r-- 1 ubuntu ubuntu 0 Jul 14 21:18 /app/test.txt
```
