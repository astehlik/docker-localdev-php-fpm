FROM intera/docker-ci-php:7.1-ubuntu

ENV DEBIAN_FRONTEND noninteractive
ENV LANG C.UTF-8

RUN apt-get update \
	&& apt-get dist-upgrade -y

RUN apt-get install -y \
		php7.1-fpm

RUN groupadd -g 1000 localuser \
	&& useradd -u 1000 -g 1000 -m localuser

RUN sed -i "s|;*daemonize\s*=\s*yes|daemonize = no|g" /etc/php/7.1/fpm/php-fpm.conf \

RUN apt-get --purge -y autoremove \
	&& apt-get autoclean \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*
