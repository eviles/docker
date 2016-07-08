FROM eviles/httpd-tomcat-mariadb

ARG YAZ_VERSION=5.16.0

ADD activation-1.1.jar /usr/local/java/jre/lib/ext/activation-1.1.jar
ADD mail-1.4.7.jar /usr/local/java/jre/lib/ext/mail-1.4.7.jar
ADD mysql-connector-java-5.1.38.jar /usr/local/java/jre/lib/ext/mysql-connector-java-5.1.38.jar
ADD mysql-connector-java-5.1.38.jar /usr/local/tomcat/lib/mysql-connector-java-5.1.38.jar

RUN echo "[dockerrepo]" > /etc/yum.repos.d/docker.repo \
&& echo "name=Docker Repository" >> /etc/yum.repos.d/docker.repo \
&& echo "baseurl=https://yum.dockerproject.org/repo/main/centos/7/" >> /etc/yum.repos.d/docker.repo \
&& echo "enabled=1" >> /etc/yum.repos.d/docker.repo \
&& echo "gpgcheck=1" >> /etc/yum.repos.d/docker.repo \
&& echo "gpgkey=https://yum.dockerproject.org/gpg" >> /etc/yum.repos.d/docker.repo \
&& yum -y install epel-release \
&& yum -y groupinstall 'Development Tools' \
&& yum -y install rsync less wget net-tools libstdc++ libstdc++.i686 libcurl libcurl.i686 docker-engine python-pip nodejs npm cronie at nginx \
&& yum clean all \
&& rm -rf /var/cache/yum/* \
&& pip install --upgrade pip \
&& pip install docker-compose \
&& curl -s -L --url "http://ftp.indexdata.com/pub/yaz/yaz-${YAZ_VERSION}.tar.gz" | tar xz -C /usr/local/src \
&& cd /usr/local/src/yaz-${YAZ_VERSION} \
&& ./configure \
&& make \
&& make install \
&& rm -rf /usr/local/src/yaz-${YAZ_VERSION} \
&& echo "[program:atd]" >> /etc/supervisord.conf \
&& echo "command=/usr/sbin/atd -d" >> /etc/supervisord.conf \
&& echo "[program:crond]" >> /etc/supervisord.conf \
&& echo "command=/usr/sbin/crond -n" >> /etc/supervisord.conf \
&& echo "[program:nginx]" >> /etc/supervisord.conf \
&& echo "command=/usr/sbin/nginx -g \"daemon off;\"" >> /etc/supervisord.conf \
&& echo "autostart=false" >> /etc/supervisord.conf \
&& echo "autorestart=false" >> /etc/supervisord.conf \
&& localedef -i zh_TW -c -f UTF-8 zh_TW.UTF-8

ENV LC_ALL=zh_TW.UTF-8
