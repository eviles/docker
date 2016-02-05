FROM eviles/tomcat8

RUN yum -y install httpd
RUN yum clean all

ADD mod_jk.so /usr/lib64/httpd/modules/mod_jk.so
ADD workers.properties /etc/httpd/conf.d/workers.properties
ADD mod_jk.conf /etc/httpd/conf.d/mod_jk.conf
RUN chmod 755 /usr/lib64/httpd/modules/mod_jk.so

VOLUME /var/www

RUN sed -i 's/DirectoryIndex index.html/DirectoryIndex index.html index.htm index.jsp/g' /etc/httpd/conf/httpd.conf

EXPOSE 80

CMD ["/usr/sbin/httpd"]
