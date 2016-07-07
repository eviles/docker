FROM eviles/httpd-tomcat

ENV TERM=xterm

RUN yum -y install mariadb mariadb-server \
&& yum clean all \
&& rm -rf /var/cache/yum/* \
&& rm -rf /var/lib/mysql/* \
&& mysql_install_db --user=mysql --datadir=/var/lib/mysql --rpm \
&& echo "[program:mysqld]" >> /etc/supervisord.conf \
&& echo "user=mysql" >> /etc/supervisord.conf \
&& echo "stdout_logfile=/dev/stdout" >> /etc/supervisord.conf \
&& echo "stdout_logfile_maxbytes=0" >> /etc/supervisord.conf \
&& echo "stderr_logfile=/dev/stderr" >> /etc/supervisord.conf \
&& echo "stderr_logfile_maxbytes=0" >> /etc/supervisord.conf \
&& echo "command=/usr/bin/mysqld_safe" >> /etc/supervisord.conf

EXPOSE 3306
VOLUME /var/lib/mysql