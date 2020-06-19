# frrdev
FRR Development Kit for CentOS-7 users

init script
```bash
#!/bin/sh
curl -L get.docker.com | sh
systemctl start docker
systemctl enable docker
```

## Setup Developement Env

```bash
> git clone this-repo && cd repo
> ./docker/build.sh
```
