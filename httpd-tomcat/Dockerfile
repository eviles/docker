FROM eviles/tomcat8

RUN yum -y install httpd \
&& yum clean all \
&& rm -rf /var/cache/yum/*

ADD mod_jk.so /usr/lib64/httpd/modules/mod_jk.so
ADD workers.properties /etc/httpd/conf.d/workers.properties
ADD mod_jk.conf /etc/httpd/conf.d/mod_jk.conf

RUN chmod 755 /usr/lib64/httpd/modules/mod_jk.so \
&& sed -i '/^#ServerName/cServerName localhost' /etc/httpd/conf/httpd.conf \
&& sed -i 's/DirectoryIndex index.html/DirectoryIndex index.html index.htm index.jsp/g' /etc/httpd/conf/httpd.conf \
&& sed -i 's/^EnableSendfile on/EnableSendfile off/g' /etc/httpd/conf/httpd.conf \
&& echo "[program:httpd]" >> /etc/supervisord.conf \
&& echo "command=/usr/sbin/httpd -D FOREGROUND" >> /etc/supervisord.conf

EXPOSE 80 443
VOLUME /var/www/html
