FROM ubuntu:16.04

RUN apt-get update \
	&& apt-get dist-upgrade -y \
	&& apt-get install -y php-mcrypt \
		php-soap \
		php-json \
		php-mysql \
		php-sqlite3 \
		php-zip \
		php-pgsql \
		php-gd \
		php-xml \
		php-curl \
		php-fpm \
		php-xdebug \
		php-mbstring \
		php-apcu \
		php-intl \
		imagemagick \
		language-pack-de \
	&& groupadd -g 1000 localuser \
	&& useradd -u 1000 -g 1000 -m localuser \

	&& sed -i "s|;*daemonize\s*=\s*yes|daemonize = no|g" /etc/php/7.0/fpm/php-fpm.conf \

	&& apt-get --purge autoremove \
	&& apt-get autoclean \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*
