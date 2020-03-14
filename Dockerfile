FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive
ENV LANG C.UTF-8

RUN apt-get update \
	&& apt-get dist-upgrade -y \
	&& apt-get install -y software-properties-common \
	&& add-apt-repository ppa:ondrej/php \
	&& apt-get update -y

RUN ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime

RUN apt-get install -y \
		php7.4-soap \
		php7.4-json \
		php7.4-mysql \
		php7.4-sqlite3 \
		php7.4-zip \
		php7.4-pgsql \
		php7.4-gd \
		php7.4-xml \
		php7.4-curl \
		php7.4-fpm \
		php7.4-mbstring \
		php7.4-apcu \
		php7.4-intl \
		php7.4-igbinary \
		php7.4-dev \
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

RUN sed -i "s|;*daemonize\s*=\s*yes|daemonize = no|g" /etc/php/7.4/fpm/php-fpm.conf

COPY install_composer.sh /tmp/install_composer.sh

RUN apt-get install -y wget \
    && bash /tmp/install_composer.sh \
	&& mv composer.phar /usr/local/bin/

RUN apt-get purge -y software-properties-common wget \
	&& apt-get --purge -y autoremove \
	&& apt-get autoclean \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*
