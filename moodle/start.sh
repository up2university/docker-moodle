#!/bin/bash
if [ ! -f /var/www/html/moodle/config.php ]; then
  #mysql has to be started this way as it doesn't work to call from /etc/init.d
  /usr/bin/mysqld_safe &
  sleep 10s
  MOODLE_DB="moodle"
  echo root:$SSH_PASSWORD | chpasswd
  sed -e "s/pgsql/mysqli/
  s/localhost/mysql/
  s/username/moodle/
  s/password/$MOODLE_PASSWORD/
  s/example.com/$VIRTUAL_HOST/
  s/\/home\/example\/moodledata/\/var\/moodledata/" /var/www/html/moodle/config-dist.php > /var/www/html/moodle/config.php

  sed -i 's/PermitRootLogin without-password/PermitRootLogin Yes/' /etc/ssh/sshd_config

  chown www-data:www-data /var/www/html/moodle/config.php


fi
# start all the services
/usr/local/bin/supervisord -n
