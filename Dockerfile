FROM intera/docker-ci-php:8.0-ubuntu

ENV DEBIAN_FRONTEND noninteractive
ENV LANG C.UTF-8

RUN apt-get update \
	&& apt-get dist-upgrade -y \
	&& apt-get update -y

RUN ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime

RUN apt-get install -y \
		php8.0-fpm \
		php8.0-igbinary \
		php8.0-dev \
		xz-utils

RUN cd /opt \
    && wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz \
    && tar -xf wkhtmltox-0.12.4_linux-generic-amd64.tar.xz

RUN groupadd -g 1000 localuser \
	&& useradd -u 1000 -g 1000 -m localuser

RUN sed -i "s|;*daemonize\s*=\s*yes|daemonize = no|g" /etc/php/8.0/fpm/php-fpm.conf

RUN apt-get purge -y software-properties-common wget \
	&& apt-get --purge -y autoremove \
	&& apt-get autoclean \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*
