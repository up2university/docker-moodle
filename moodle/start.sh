#!/bin/bash
if [ ! -f /var/www/html/config.php ]; then
  #mysql has to be started this way as it doesn't work to call from /etc/init.d
  /usr/bin/mysqld_safe &
  sleep 10s
  MOODLE_DB="moodle"
  sed -e "s/pgsql/mysqli/
  s/localhost/mysql/
  s/username/moodle/
  s/password/$MOODLE_PASSWORD/
  s/http://example.com\/moodle/https://$VIRTUAL_HOST/
  s/\/var\/www\/html\/moodle/\/var\/www\/html\//
  s/\/home\/example\/moodledata/\/var\/moodledata/" /var/www/html/config-dist.php > /var/www/html/config.php

  chown www-data:www-data /var/www/html/config.php
fi
# start all the services
/usr/local/bin/supervisord -n
