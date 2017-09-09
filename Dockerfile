FROM ubuntu:16.04

RUN apt-get update \
	&& apt-get dist-upgrade -y \
	&& apt-get install -y software-properties-common \
	&& export LANG=C.UTF-8 \
	&& add-apt-repository -y ppa:ondrej/php \
	&& apt-get update -y \
	&& apt-get install -y php7.1-mcrypt \
		php7.1-soap \
		php7.1-json \
		php7.1-mysql \
		php7.1-sqlite3 \
		php7.1-zip \
		php7.1-pgsql \
		php7.1-gd \
		php7.1-xml \
		php7.1-curl \
		php7.1-fpm \
		php7.1-xdebug \
		php7.1-mbstring \
		php7.1-apcu \
		php7.1-intl \
		imagemagick \
		language-pack-de \
		openssh-client \
		rsync \
		mysql-client \
	&& groupadd -g 1000 localuser \
	&& useradd -u 1000 -g 1000 -m localuser \

	&& sed -i "s|;*daemonize\s*=\s*yes|daemonize = no|g" /etc/php/7.1/fpm/php-fpm.conf \

	&& apt-get purge -y software-properties-common \
	&& apt-get --purge -y autoremove \
	&& apt-get autoclean \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*
