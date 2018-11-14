# docker-wordpress-cli-sage

> Docker image with [wp-cli](https://wp-cli.org/), [Sage](https://roots.io/sage/) development environment (npm, nodejs, composer, yarn, webpack) and **ssh** service.
> The image is based on the official [wordpress-cli:lastest](https://hub.docker.com/r/library/wordpress/).

# Usage

This image variant does not contain WordPress itself, but instead contains WP-CLI.

The simplest way to use it with an existing WordPress container would be something similar to the following:

```shell
$ docker run -it --rm \
    --volumes-from some-wordpress \
    --network container:some-wordpress \
    bitroniq/docker-wordpress-cli-sage /bin/bash
```

For WP-CLI to interact with a WordPress install, it needs access;
  - to the on-disk files of the WordPress install,
  - and access to the database

The easiest way to accomplish that wp-config.php does not require changes is to simply join the networking context of the existing and presumably working WordPress container.
There are many other ways to accomplish that, for example using docker-compose.yml.
