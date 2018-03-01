FROM mysql/mysql-server:5.5

RUN yum -y install gettext \
    && yum clean all

COPY ./my.cnf /etc/my.cnf
COPY ./start_mysql.sh /docker-entrypoint-initdb.d/start_mysql.sh
RUN chmod a+x /docker-entrypoint-initdb.d/start_mysql.sh
ADD configure.sh /configure.sh
RUN chmod a+x /configure.sh
ADD config/ /config
