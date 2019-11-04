FROM ubuntu:16.04

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
	sudo \
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
    && curl 'https://git.moodle.org/gw?p=moodle.git;a=snapshot;h=008baea92aa20ee7ff619d37cc6568b076cda00c;sf=tgz' -o moodle-latest.tgz \
    && tar zxf moodle-latest.tgz \
    && rm moodle-latest.tgz \
    && mv /var/www/moodle* /var/www/html \
    && chown -R www-data:www-data /var/www/html/

COPY ./config-dist.php /var/www/html/config-dist.php

RUN echo "certbot --non-interactive --agree-tos --email \$CERT_EMAIL --apache --domains \$VIRTUAL_HOST" > /certbot-setup.sh \
    && chmod 755 /certbot-setup.sh

RUN curl -L https://moodle.org/plugins/download.php/18810/theme_fordson_moodle36_2019111001.zip -o /fordson.zip \
    && cp /fordson.zip /var/www/html/theme/ \
    && cd /var/www/html/theme \
    && unzip fordson.zip \
    && rm fordson.zip

RUN cd /var/www/html/auth \
    && wget https://github.com/catalyst/moodle-auth_saml2/archive/2018022600.zip -O auth_saml2.zip \
    && unzip auth_saml2.zip \
    && mv moodle-auth_saml2* saml2 \
    && rm auth_saml2.zip

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
    && chown -R www-data:www-data knockplop \
    && rm knockplop.zip

RUN cd /var/www/html/mod \
    && curl -L https://moodle.org/plugins/download.php/19726/mod_questionnaire_moodle37_2018110101.zip -o questionnaire.zip \
    && unzip questionnaire.zip \
    && chown -R www-data:www-data questionnaire \
    && rm questionnaire.zip

COPY ./multipartymeeting/multipartymeeting.zip /var/www/html/mod/
RUN cd /var/www/html/mod/ \
    && unzip multipartymeeting.zip \
    && chown -R www-data:www-data multipartymeeting \
    && rm multipartymeeting.zip

# Install H5P - mod/hvp version 1.6 from https://moodle.org/plugins/mod_hvp
RUN cd /var/www/html/mod \
    && curl -L https://moodle.org/plugins/download.php/19174/mod_hvp_moodle36_2019031301.zip  -o mod_hvp.zip \
    && unzip mod_hvp.zip \
    && chown -R www-data:www-data hvp \
    && rm mod_hvp.zip

# Install VPL - mod/vpl version 1.6 from https://moodle.org/plugins/mod_vpl
RUN cd /var/www/html/mod \
    && curl -L https://github.com/jcrodriguez-dis/moodle-mod_vpl/archive/bc98f46fcac852d1d237a5ed700fe4030b385aa9.zip -o mod_vpl.zip \
    && unzip mod_vpl.zip \
    && mv moodle-mod_vpl-bc98f46fcac852d1d237a5ed700fe4030b385aa9 vpl \
    && chown -R www-data:www-data vpl \
    && rm mod_vpl.zip

# Copy file to auto install H5P libraries
COPY ./autoinstallhvplibs.php /var/www/html/mod/hvp/autoinstallhvplibs.php 
RUN cd /var/www/html/mod/hvp \
    && chown www-data:www-data autoinstallhvplibs.php \
    && chmod 775 autoinstallhvplibs.php

# Install EJSapp pack - mod/ejsapp version 3.0 from https://moodle.org/plugins/mod_ejsapp
RUN cd /var/www/html/mod \
    && curl -L https://moodle.org/plugins/download.php/19100/mod_ejsapp_moodle36_2019030300.zip  -o mod_ejsapp.zip \
    && unzip mod_ejsapp.zip \
    && chown -R www-data:www-data ejsapp \
    && rm mod_ejsapp.zip

# Install EJSapp repository - repository/osp version 3.0 from https://moodle.org/plugins/repository_osp
RUN cd /var/www/html/repository \
    && curl -L https://moodle.org/plugins/download.php/17745/repository_osp_moodle36_2017051500.zip -o repository_osp.zip \
    && unzip repository_osp.zip \
    && rm repository_osp.zip

# Install EJSapp remote lab manager - block/remlab_manager version 3.0 from https://moodle.org/plugins/block_remlab_manager
RUN cd /var/www/html/blocks \
    && curl -L https://moodle.org/plugins/download.php/19101/block_remlab_manager_moodle36_2019030300.zip -o block_remlab_manager.zip \
    && unzip block_remlab_manager.zip \
    && rm block_remlab_manager.zip

# Install Category_Enrol (block) - blocks/category_enrol version 0.1 from https://github.com/iucc/moodle-block_category_enrol
RUN cd /var/www/html/blocks \
    && curl -L https://github.com/iucc/moodle-block_category_enrol/archive/a6a7b2d7f9496ff2deb1a6aa8322a0f25ad4ee94.zip -o block_category_enrol.zip \
    && unzip block_category_enrol.zip \
    && mv moodle-block_category_enrol* category_enrol \
    && rm block_category_enrol.zip

# Install Easy Enrollments - enrol/easy version 1.1 from https://moodle.org/plugins/enrol_easy
RUN cd /var/www/html/enrol \
    && curl -L https://moodle.org/plugins/download.php/17781/enrol_easy_moodle36_2018090600.zip -o enrol_easy.zip \
    && unzip enrol_easy.zip \
    && rm enrol_easy.zip

# Install Plugin to use CERNBox as remote repository
RUN cd /var/www/html/repository \
    && wget https://moodle.org/plugins/download.php/18330/repository_owncloud_moodle36_2018112300.zip -O owncloud.zip \
    && unzip owncloud.zip \
    && rm owncloud.zip \
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
RUN curl -L https://github.com/xAPI-vle/moodle-logstore_xapi/releases/download/v4.2.5/xapi.zip -o /xapi.zip \
    && unzip /xapi.zip -d /var/www/html/admin/tool/log/store/ \
    && rm /xapi.zip \
    && chown -R www-data:www-data /var/www/html/admin/tool/log/store/xapi

# Install Moodle stats - up2university/moodle_statistics from https://github.com/up2university/moodle_statistics 
RUN cd /var/www/html/local \
    && curl -L https://github.com/up2university/moodle_statistics/archive/34fcbb828abfcb9ce2b67a8b8979a4892b77ebe6.zip -o moodle_stat.zip \
    && unzip moodle_stat.zip \
    && mv moodle_statistics* statistics \
    && rm moodle_stat.zip

COPY crontab /crontab
RUN crontab -u www-data /crontab

# Install Moosh
RUN wget https://moodle.org/plugins/download.php/15063/moosh_moodle33_2017101600.zip -O /moosh.zip \
    && unzip /moosh.zip \
    && rm /moosh.zip \
    && wget https://gist.githubusercontent.com/nadavkav/2e016eb5cdf5634f8d9a4ed02ed32ebb/raw/22ebd3615992bebfc9ca979955f92e0b4a7c0113/Moosh_Command_Moodle23_Config_ConfigGet.php -O /moosh/Moosh/Command/Moodle23/Config/ConfigGet.php \
    && chmod a+x /moosh/moosh.php

COPY icons/cernbox_icon.svg /var/www/html/repository/owncloud/pix/icon.svg

COPY php.ini /etc/php/7.0/apache2/php.ini

COPY config/ /config
COPY configure.sh /configure.sh
RUN chmod a+x /configure.sh

EXPOSE 80 443

CMD ["/bin/bash", "/start.sh"]
