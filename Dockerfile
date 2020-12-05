ARG phpVersion="7.4"

FROM intera/docker-ci-php:${phpVersion}-ubuntu

# We have to provide ARG once more because it gets lost after FROM, see also:
# https://docs.docker.com/engine/reference/builder/#understand-how-arg-and-from-interact
ARG phpVersion

ENV DEBIAN_FRONTEND noninteractive
ENV LANG C.UTF-8

RUN apt-get update \
	&& apt-get dist-upgrade -y \
	&& apt-get update -y

RUN ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime

RUN apt-get install -y \
		php${phpVersion}-fpm \
		php${phpVersion}-igbinary \
		php${phpVersion}-dev \
		xz-utils

RUN cd /opt \
    && wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz \
    && tar -xf wkhtmltox-0.12.4_linux-generic-amd64.tar.xz

RUN groupadd -g 1000 localuser \
	&& useradd -u 1000 -g 1000 -m localuser

RUN sed -i "s|;*daemonize\s*=\s*yes|daemonize = no|g" /etc/php/${phpVersion}/fpm/php-fpm.conf

RUN apt-get --purge -y autoremove \
	&& apt-get autoclean \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

# Expose ports
EXPOSE 9000

# Entry point
ENV PHP_VERSION=$phpVersion
ENTRYPOINT /usr/sbin/php-fpm${PHP_VERSION}
