FROM ubuntu:14.04

# Keep upstart from complaining
RUN dpkg-divert --local --rename --add /sbin/initctl \
    && ln -sf /bin/true /sbin/initctl

# Let the conatiner know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

# Install all apt dependencies
RUN apt-get update \
    && apt-get install -y \
        software-properties-common \
        python-software-properties \
    && apt-key adv --keyserver "hkp://keyserver.ubuntu.com:80" --recv 'E5267A6C' \
    && LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php \
    && add-apt-repository ppa:certbot/certbot \
    && apt-get update \
    && apt-get install -y \
        python-setuptools \
        unzip \
        gettext \
        apache2 \
        php7.0 \
        php7.0-gd \
        libapache2-mod-php7.0 \
        postfix \
        wget \
        php7.0-pgsql \
        vim \
        curl \
        libcurl3 \
        libcurl3-dev \
        php7.0-curl \
        php7.0-xml \
        php7.0-xmlrpc \
        php7.0-intl \
        php7.0-mysql \
        php7.0-zip \
        php7.0-mbstring \
        php7.0-soap \
        php7.0-mcrypt \
        certbot \
        python-certbot-apache \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/www/html

RUN easy_install supervisor

VOLUME /var/moodledata

COPY ./start.sh /start.sh
COPY ./foreground.sh /etc/apache2/foreground.sh
RUN chmod 755 /start.sh /etc/apache2/foreground.sh
COPY ./supervisord.conf /etc/supervisord.conf

COPY ./000-default.conf /etc/apache2/sites-available/000-default.conf
COPY ./default-ssl.conf /etc/apache2/sites-available/default-ssl.conf

RUN ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/rewrite.load \
    && ln -s /etc/apache2/mods-available/ssl.load /etc/apache2/mods-enabled/ssl.load \
    && ln -s /etc/apache2/mods-available/ssl.conf /etc/apache2/mods-enabled/ssl.conf \
    && ln -s /etc/apache2/mods-available/socache_shmcb.load /etc/apache2/mods-enabled/socache_shmcb.load \
    && ln -s /etc/apache2/sites-available/default-ssl.conf /etc/apache2/sites-enabled/default-ssl.conf

RUN cd /var/www \
    && wget https://download.moodle.org/download.php/direct/stable33/moodle-latest-33.tgz -O moodle-latest.tgz \
    && tar zxvf moodle-latest.tgz \
    && rm moodle-latest.tgz \
    && mv /var/www/moodle /var/www/html \
    && chown -R www-data:www-data /var/www/html/

COPY ./config-dist.php /var/www/html/config-dist.php

RUN echo "certbot --non-interactive --agree-tos --email \$CERT_EMAIL --apache --domains \$VIRTUAL_HOST" > /certbot-setup.sh \
    && chmod 755 /certbot-setup.sh

RUN curl -L https://moodle.org/plugins/download.php/14891/theme_fordson_moodle33_2017092500.zip -o /fordson.zip \
    && cp /fordson.zip /var/www/html/theme/ \
    && cd /var/www/html/theme \
    && unzip fordson.zip \
    && rm fordson.zip

RUN cd /var/www/html/auth \
    && wget https://github.com/catalyst/moodle-auth_saml2/archive/2018022600.zip -O auth_saml2.zip \
    && unzip auth_saml2.zip \
    && mv moodle-auth_saml2* saml2 \
    && rm auth_saml2.zip

COPY ./pumoodle/filter.zip /var/www/html/filter/filter.zip
RUN cd /var/www/html/filter/ \
    && unzip filter.zip \
    && rm filter.zip

COPY ./pumoodle/pmksearch.zip /var/www/html/repository/pmksearch.zip
RUN cd /var/www/html/repository/ \
    && unzip pmksearch.zip \
    && rm pmksearch.zip

COPY ./pumoodle/pumukit.zip /var/www/html/lib/editor/atto/plugins/pumukit.zip
RUN cd /var/www/html/lib/editor/atto/plugins/ \
    && unzip pumukit.zip \
    && rm pumukit.zip

COPY ./pumoodle/pumukitpr.zip /var/www/html/lib/editor/atto/plugins/pumukitpr.zip
RUN cd /var/www/html/lib/editor/atto/plugins/ \
    && unzip pumukitpr.zip \
    && rm pumukitpr.zip

COPY ./pumoodle/filterpr.zip /var/www/html/filter/filterpr.zip
RUN cd /var/www/html/filter/ \
    && unzip filterpr.zip \
    && rm filterpr.zip

COPY ./knockplop/knockplop.zip /var/www/html/mod/
RUN cd /var/www/html/mod/ \
    && unzip knockplop.zip \
    && rm knockplop.zip

# Install H5P - mod/hvp version 1.6 from https://moodle.org/plugins/mod_hvp
RUN cd /var/www/html/mod \
    && curl -L https://moodle.org/plugins/download.php/15518/mod_hvp_moodle34_2017112800.zip -o mod_hvp.zip \
    && unzip mod_hvp.zip \
    && rm mod_hvp.zip

# Install Category_Enrol (block) - blocks/category_enrol version 0.1 from https://github.com/iucc/moodle-block_category_enrol
RUN cd /var/www/html/blocks \
    && curl -L https://github.com/iucc/moodle-block_category_enrol/archive/81d87d54ddf018ac28fd6403f890de3b4578d24a.zip -o block_category_enrol.zip \
    && unzip block_category_enrol.zip \
    && mv moodle-block_category_enrol* category_enrol \
    && rm block_category_enrol.zip
    
# Install Easy Enrollments - enrol/easy version 1.1 from https://moodle.org/plugins/enrol_easy
RUN cd /var/www/html/enrol \
    && curl -L https://moodle.org/plugins/download.php/14067/enrol_easy_moodle34_2017052300.zip -o enrol_easy.zip \
    && unzip enrol_easy.zip \
    && rm enrol_easy.zip

# Install Plugin to use CERNBox as remote repository
RUN cd /var/www/html/repository \
    && wget https://github.com/cernbox/moodle-repository_owncloud/archive/cb23ba7b5096bd46a9569c69067f1f33a0943020.zip -O owncloud.zip \
    && unzip owncloud.zip \
    && rm owncloud.zip \
    && mv moodle-repository_owncloud* owncloud \
    && chown -R www-data:www-data owncloud

# Install DSpace Sword plugin (push metadata to Dspace)
RUN cd /var/www/html/repository \
    && wget https://github.com/up2university/sword_upload/archive/ce03bd0928ec7ecba46f058aa3660239d2ab777f.zip -O sword_upload.zip \
    && unzip sword_upload.zip \
    && rm sword_upload.zip \
    && mv sword_upload* sword_upload \
    && chown -R www-data:www-data sword_upload

# Install DSpace API plugin (pull metadata from Dspace)
RUN cd /var/www/html/repository \
    && wget https://github.com/up2university/Moodle-Dspace-Plugin/archive/00389f06051ac9a152b36af6f3e0afbcaf8a34bc.zip -O Moodle-Dspace-Plugin.zip \
    && unzip Moodle-Dspace-Plugin.zip \
    && rm Moodle-Dspace-Plugin.zip \
    && mv Moodle-Dspace-Plugin*/dspace dspace \
    && rm -r Moodle-Dspace-Plugin* \
    && chown -R www-data:www-data dspace

# Install logstore_xapi plugin to send learning records to LRS
RUN curl -L https://github.com/xAPI-vle/moodle-logstore_xapi/releases/download/v2.2.3/xapi.zip -o /xapi.zip \
    && unzip /xapi.zip -d /var/www/html/admin/tool/log/store/ \
    && rm /xapi.zip \
    && chown -R www-data:www-data /var/www/html/admin/tool/log/store/xapi

COPY crontab /crontab
RUN crontab -u www-data /crontab

# Install Moosh
RUN wget https://moodle.org/plugins/download.php/15063/moosh_moodle33_2017101600.zip -O /moosh.zip \
    && unzip /moosh.zip \
    && rm /moosh.zip \
    && wget https://gist.githubusercontent.com/nadavkav/2e016eb5cdf5634f8d9a4ed02ed32ebb/raw/22ebd3615992bebfc9ca979955f92e0b4a7c0113/Moosh_Command_Moodle23_Config_ConfigGet.php -O /moosh/Moosh/Command/Moodle23/Config/ConfigGet.php \
    && chmod a+x /moosh/moosh.php

COPY config/ /config
COPY configure.sh /configure.sh
RUN chmod a+x /configure.sh

EXPOSE 80 443

CMD ["/bin/bash", "/start.sh"]
