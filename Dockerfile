FROM intera/ci-php:5.6-ubuntu

ENV DEBIAN_FRONTEND noninteractive
ENV LANG C.UTF-8

RUN apt-get update \
	&& apt-get dist-upgrade -y

RUN apt-get install -y \
		php5.6-fpm \
		php5.6-apcu \
		openssh-client

RUN groupadd -g 1000 localuser \
	&& useradd -u 1000 -g 1000 -m localuser \
	&& sed -i "s|;*daemonize\s*=\s*yes|daemonize = no|g" /etc/php/5.6/fpm/php-fpm.conf

RUN apt-get --purge -y autoremove \
	&& apt-get autoclean \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*
