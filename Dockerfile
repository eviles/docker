FROM eviles/alpine-tomcat8

RUN apk --update add apache2 \
&& rm -rf /var/cache/apk/*

ADD mod_jk.so /usr/lib/apache2/mod_jk.so
ADD workers.properties /etc/apache2/conf.d/workers.properties
ADD mod_jk.conf /etc/apache2/conf.d/mod_jk.conf

RUN chmod 755 /usr/lib/apache2/mod_jk.so \
&& sed -i '/^#ServerName/cServerName localhost' /etc/apache2/httpd.conf \
&& sed -i 's/DirectoryIndex index.html/DirectoryIndex index.html index.htm index.jsp/g' /etc/apache2/httpd.conf \
&& echo "[program:httpd]" >> /etc/supervisord.conf \
&& echo "command=/usr/sbin/httpd -D FOREGROUND" >> /etc/supervisord.conf \
&& mkdir /run/apache2

EXPOSE 80
VOLUME /var/www/localhost
