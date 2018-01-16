FROM ubuntu:16.04

RUN apt-get update \
	&& apt-get dist-upgrade -y \
	&& apt-get install -y software-properties-common \
	&& export LANG=C.UTF-8 \
	&& add-apt-repository -y ppa:ondrej/php \
	&& apt-get update -y \
	&& apt-get install -y \
		php7.2-soap \
		php7.2-json \
		php7.2-mysql \
		php7.2-sqlite3 \
		php7.2-zip \
		php7.2-pgsql \
		php7.2-gd \
		php7.2-xml \
		php7.2-curl \
		php7.2-fpm \
		php7.2-mbstring \
		php7.2-apcu \
		php7.2-intl \
		php7.2-dev \
		imagemagick \
		language-pack-de \
		openssh-client \
		rsync \
		mysql-client \
	&& groupadd -g 1000 localuser \
	&& useradd -u 1000 -g 1000 -m localuser \

	&& sed -i "s|;*daemonize\s*=\s*yes|daemonize = no|g" /etc/php/7.2/fpm/php-fpm.conf \

	&& apt-get purge -y software-properties-common \
	&& apt-get --purge -y autoremove \
	&& apt-get autoclean \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* \

	&&  pecl install xdebug-2.6.0beta1
