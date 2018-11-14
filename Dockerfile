FROM wordpress:cli

# Install SSH
RUN \
    # Install openssh
    apk add --update openssh && \
    rm -rf /tmp/* /var/cache/apk/*
    # Fix www-data uid mismatch in wordpress:latest
    # https://github.com/docker-library/wordpress/issues/256
    userdel -r www-data
    userdel -r xfs
    roupadd -g 33 www-data
    useradd -d /var/www/html -s /bin/ash -g www-data -G www-data -u 33 -p password www-data

EXPOSE 22
CMD ["/usr/sbin/sshd","-D"]
