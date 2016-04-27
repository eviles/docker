FROM eviles/centos-sshd

RUN echo "[mariadb]" > /etc/yum.repos.d/MariaDB.repo \
&& echo "name = MariaDB" >> /etc/yum.repos.d/MariaDB.repo \
&& echo "baseurl = http://yum.mariadb.org/10.1/centos7-amd64" >> /etc/yum.repos.d/MariaDB.repo \
&& echo "gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB" >> /etc/yum.repos.d/MariaDB.repo \
&& echo "gpgcheck=1" >> /etc/yum.repos.d/MariaDB.repo \
&& groupadd -r mysql \
&& useradd -r -g mysql mysql \
&& yum -y install MariaDB-server MariaDB-client galera \
&& yum clean all \
&& rm -rf /var/cache/yum/* \
&& echo "[program:mysqld]" >> /etc/supervisord.conf \
&& echo "user=mysql" >> /etc/supervisord.conf \
&& echo "stdout_logfile=/dev/stdout" >> /etc/supervisord.conf \
&& echo "stdout_logfile_maxbytes=0" >> /etc/supervisord.conf \
&& echo "command=/entrypoint.sh" >> /etc/supervisord.conf

COPY server.cnf /etc/my.cnf.d/server.cnf
COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

EXPOSE 3306
VOLUME /var/lib/mysql
