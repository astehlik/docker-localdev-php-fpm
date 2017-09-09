FROM ubuntu:16.04

RUN apt-get update \
	&& apt-get dist-upgrade -y \
	&& apt-get install -y software-properties-common python-software-properties \
	&& export LANG=C.UTF-8 \
	&& add-apt-repository ppa:ondrej/php \
	&& apt-get update -y \
	&& apt-get install -y php5.6-mcrypt \
		php5.6-soap \
		php5.6-json \
		php5.6-mysql \
		php5.6-sqlite3 \
		php5.6-zip \
		php5.6-pgsql \
		php5.6-gd \
		php5.6-xml \
		php5.6-curl \
		php5.6-fpm \
		php5.6-xdebug \
		php5.6-mbstring \
		php5.6-apcu \
		php5.6-intl \
		imagemagick \
		language-pack-de \
		openssh-client \
		rsync \
		mysql-client \
	&& groupadd -g 1000 localuser \
	&& useradd -u 1000 -g 1000 -m localuser \

	&& sed -i "s|;*daemonize\s*=\s*yes|daemonize = no|g" /etc/php/5.6/fpm/php-fpm.conf \

	&& apt-get purge -y software-properties-common python-software-properties \
	&& apt-get --purge -y autoremove \
	&& apt-get autoclean \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*
