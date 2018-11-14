# Dockerfile
# https://github.com/bitroniq/docker-wordpress-cli-sage
# https://hub.docker.com/r/bitroniq/docker-wordpress-cli-sage/

# Official wordpress-cli image on steroids with SAGE (roots.io) dev
# environment and SSH access

# Author: mail@piotrkowalski.info

FROM wordpress:cli

# Change user to root for the following commands
USER root

# Install SSH
RUN \
    apk add --update shadow openssh && \
    rm -rf /tmp/* /var/cache/apk/*

# Make sure we get fresh keys
RUN \
    mkdir /var/run/sshd && \
    rm -rf /etc/ssh/ssh_host_rsa_key /etc/ssh/ssh_host_dsa_key && \
    ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa && \
    ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa

# Fix www-data uid mismatch in wordpress:latest
# https://github.com/docker-library/wordpress/issues/256
RUN \
    userdel -r www-data && \
    userdel -r xfs && \
    groupadd -g 33 www-data && \
    useradd -d /var/www/html -s /bin/ash -g www-data -G www-data -u 33 www-data && \
    echo "www-data:password" | chpasswd

# Install SAGE requirements
# https://github.com/roots/sage#requirements
# https://roots.io/guides/automate-sage-9-deployment-with-deploybot/
RUN \
    apk add npm  && \
    apk add nodejs && \
    apk add composer && \
    apk add zip && \
    apk add unzip
RUN \
    npm install --global npm@latest && \
    npm install --global yarn && \
    npm install --global webpack

EXPOSE 22
CMD ["/usr/sbin/sshd","-D"]
