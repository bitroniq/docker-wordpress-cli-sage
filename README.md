# docker-wordpress-cli-sage

> Docker image with [wp-cli](https://wp-cli.org/), [Sage](https://roots.io/sage/) development environment (npm, nodejs, composer, yarn, webpack) and **ssh** service.

> The image is based on the official [wordpress-cli:latest](https://hub.docker.com/r/library/wordpress/).

> The basic idea of this image is to attach to existing wordpress stack based on official [wordpress:latest](https://hub.docker.com/r/library/wordpress/) image.

# Usage

This image variant does not contain WordPress itself, but instead contains WP-CLI.

## Interactive run
The simplest way to use it with an existing WordPress container would be something similar to the following:

```shell
$ docker run -it --rm \
    --volumes-from some-wordpress \
    --network container:some-wordpress \
    bitroniq/docker-wordpress-cli-sage /bin/bash
```

## Start in the background and use the SSH

```
$ docker run -d -p 2222:22 --name wordpress-cli-sage \
    --volumes-from some-wordpress \
    --network container:some-wordpress \
    bitroniq/docker-wordpress-cli-sage
```

Then you can SSH to the container with password: `password`:
```
$ ssh -p 2222 www-data@localhost
```

## Interactive access to the running container

Instead of SSH you can access directly
```
$ docker exec -it wordpress-cli-sage /bin/bash
```

For WP-CLI to interact with a WordPress install, it needs access;
  - to the on-disk files of the WordPress install,
  - and access to the database

The easiest way to accomplish that wp-config.php does not require changes is to simply join the networking context of the existing and presumably working WordPress container.

There are many other ways to accomplish that, for example using docker-compose.yml.

# SAGE Theme installation

Please visit the official SAGE repository: https://github.com/roots/sage#theme-installation


# To Do List:
* [x] Usa official wordpress-cli image as a base for SAGE
  - allows to attach to exisitng stack with official wordpress
* [x] Add SSHD to the wp-cli image:
  - https://github.com/danielguerra69/alpine-sshd
* [x] Make sure www-data user is used to match www-data (33:33) on the official `wordpress:latest` image
* [x] passwd
* [x] make sure it is possible to SSH and SFTP
* [x] make sure it is possible to SFTP
* [x] install npm, composer, yarn, webpack
* [x] Verify all commands
  - `composer create-project roots/sage`
  - `yarn start` ... Compile assets when file changes are made, start Browsersync session
  - `yarn build` ... Compile and optimize the files in your assets directory
  - `yarn build:production` ... Compile assets for production

```
bash-4.4# yarn build:production
 DONE  Compiled successfully in 19526ms

                         Asset       Size  Chunks             Chunk Names
      scripts/main_172175dd.js    73.1 kB       0  [emitted]  main
scripts/customizer_172175dd.js  746 bytes       1  [emitted]  customizer
      styles/main_172175dd.css     191 kB       0  [emitted]  main
                   assets.json  161 bytes          [emitted]
Done in 24.08s.
```

