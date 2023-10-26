# docker-postfix

## Postfix on a Docker container

This repository contains a Dockerfile to build a Docker image with Postfix installed.

The Docker image is available in [Docker Hub](https://hub.docker.com/r/pedbarbosa/postfix/).

### Docker compose usage example

```
services:
  postfix:
    image: pedbarbosa/postfix
    container_name: postfix
    ports:
      - "25:25"
      - "587:587"
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - /var/log/maillog:/var/log/maillog
      - ./config:/config
    restart: always
```