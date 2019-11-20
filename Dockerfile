FROM ubuntu:18.04

RUN apt-get update \
	&& apt-get dist-upgrade -y \
	&& export LANG=C.UTF-8 \
	&& apt-get update -y

RUN ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime

RUN apt-get install -y \
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
		php7.2-igbinary \
		php7.2-dev \
		php-xdebug \
		imagemagick \
		language-pack-de \
		openssh-client \
		rsync \
		mysql-client \
		wget \
		xz-utils

RUN cd /opt \
    && wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz \
    && tar -xf wkhtmltox-0.12.4_linux-generic-amd64.tar.xz

RUN groupadd -g 1000 localuser \
	&& useradd -u 1000 -g 1000 -m localuser

RUN sed -i "s|;*daemonize\s*=\s*yes|daemonize = no|g" /etc/php/7.2/fpm/php-fpm.conf

COPY install_composer.sh /tmp/install_composer.sh

RUN apt-get install -y wget \
    && bash /tmp/install_composer.sh \
	&& mv composer.phar /usr/local/bin/

RUN apt-get purge -y software-properties-common wget \
	&& apt-get --purge -y autoremove \
	&& apt-get autoclean \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*
