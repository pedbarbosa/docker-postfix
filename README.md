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

### Building and publishing

`./rebuild` builds, tests and publishes the image with [docker-image-refresh](https://gist.github.com/pedbarbosa/5a6ea23c8bcaf90f063eb0a082277d79), which runs `./test <image>` before tagging it `latest`.

The [Publish image](.github/workflows/publish.yml) workflow checks the published image daily and runs `./rebuild` when it's out of date: new commits (other than docs, CI and the config and compose examples), a new `alpine` base image, or Alpine package updates. It can also be run by hand, with `force` to publish regardless. It needs a `DOCKERHUB_TOKEN` repository secret, a Docker Hub access token with Read, Write and Delete access so old tags can be pruned, and sends failures to the Slack incoming webhook in the `SLACK_WEBHOOK_URL` secret.
