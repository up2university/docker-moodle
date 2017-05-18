FROM ubuntu:14.04
MAINTAINER Sergio Gómez <sergio@quaip.com>

# Keep upstart from complaining
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl

# Let the conatiner know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get -y upgrade

RUN apt-get -y install software-properties-common python-software-properties
RUN apt-key adv --keyserver "hkp://keyserver.ubuntu.com:80" --recv 'E5267A6C'

RUN add-apt-repository ppa:ondrej/php
RUN add-apt-repository ppa:certbot/certbot

RUN apt-get update
RUN apt-get -y upgrade

# Basic Requirements
#RUN apt-get -y install mysql-server mysql-client pwgen python-setuptools curl git unzip
RUN apt-get -y install python-setuptools unzip

# Moodle Requirements
RUN apt-get -y install apache2 php5.6 php5.6-gd libapache2-mod-php5.6 postfix wget supervisor php5.6-pgsql vim curl libcurl3 libcurl3-dev php5.6-curl php5.6-xml php5.6-xmlrpc php5.6-intl php5.6-mysql php5.6-zip php5.6-mbstring php5.6-soap php5.6-mcrypt python-certbot-apache

RUN easy_install supervisor
ADD ./start.sh /start.sh
ADD ./foreground.sh /etc/apache2/foreground.sh
ADD ./supervisord.conf /etc/supervisord.conf

ADD ./000-default.conf /etc/apache2/sites-available/000-default.conf

ADD https://download.moodle.org/download.php/direct/stable32/moodle-latest-32.tgz /var/www/moodle-latest.tgz
RUN cd /var/www; rm -rf /var/www/html; tar zxvf moodle-latest.tgz; mv /var/www/moodle /var/www/html
RUN chown -R www-data:www-data /var/www/html/
RUN mkdir /var/moodledata
RUN chown -R www-data:www-data /var/moodledata; chmod 777 /var/moodledata
RUN chmod 755 /start.sh /etc/apache2/foreground.sh

ADD ./config-dist.php /var/www/html/config-dist.php

ENV MYSQL_PASSWORD ${MYSQL_ROOT_PASSWORD}
ENV MOODLE_PASSWORD ${MOODLE_PASSWORD}
ENV CERT_EMAIL ${CERT_EMAIL}
ENV CERT_DOMAIN ${CERT_DOMAIN}

RUN echo "certbot --non-interactive --test-cert --agree-tos --email $CERT_DOMAIN --apache --domains $CERT_DOMAIN" > /certbot-setup.sh
RUN chmod 755 /certbot-setup.sh 

RUN curl -L https://github.com/kennibc/moodle-theme_fordson/archive/master.zip -o /fordson.zip
RUN cp /fordson.zip /var/www/html/theme/
RUN cd /var/www/html/theme; unzip fordson.zip; mv moodle-theme_fordson-master fordson

RUN curl -L https://moodle.org/plugins/download.php/13966/auth_saml2_moodle32_2017051500.zip -o /auth_saml2.zip
RUN cp /auth_saml2.zip /var/www/html/auth/
RUN cd /var/www/html/auth; unzip auth_saml2.zip

EXPOSE 22 80 443
CMD ["/bin/bash", "/start.sh"]
