# The FROM instruction sets the Base Image for subsequent instructions.
# As such, a valid Dockerfile must have FROM as its first instruction.
FROM richarvey/nginx-php-fpm:1.2.4

# The MAINTAINER instruction allows you to set the Author field of the generated images.
MAINTAINER Pham Cong Toan <toan.pham@monokera.com>

# The ENV instruction sets the environment variable <key> to the value <value>.
# This value will be in the environment of all “descendant” Dockerfile commands and can be replaced inline in many as well.
ENV WEBROOT /var/www/app/public

# The RUN instruction will execute any commands in a new layer on top of the current image and commit the results.
# The resulting committed image will be used for the next step in the Dockerfile.
# This is not a docker best practice but there are no choice when this become a our template Dockerfile

RUN apk update \
    && apk add --no-cache \
    g++ make autoconf \
    && docker-php-source extract \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && rm -rf /tmp/*

RUN composer global require hirak/prestissimo

# The WORKDIR instruction sets the working directory for any RUN, CMD,
# ENTRYPOINT, COPY and ADD instructions that follow it in the Dockerfile.
WORKDIR /var/www/app

# The COPY instruction copies new files or directories from <src>
# and adds them to the filesystem of the container at the path <dest>.
# TL;DR https://www.ctl.io/developers/blog/post/dockerfile-add-vs-copy/
# Use COPY
COPY conf/nginx-site.conf /etc/nginx/sites-enabled/default.conf

# The VOLUME instruction creates a mount point with the specified name and marks it
# as holding externally mounted volumes from native host or other containers.

# An ONBUILD command executes after the current Dockerfile build completes.
# ONBUILD composer update

# The main purpose of a CMD is to provide defaults for an executing container.

# The EXPOSE instructions informs Docker that the container will listen on the specified network ports at runtime.
