FROM eviles/oracle-jdk8

RUN yum -y install httpd
RUN yum clean all

RUN curl -L --url "http://www.us.apache.org/dist/tomcat/tomcat-8/v8.0.30/bin/apache-tomcat-8.0.30.tar.gz" | tar xz -C /tmp

RUN mv /tmp/apache-tomcat-8.0.30 /usr/local
RUN ln -s /usr/local/apache-tomcat-8.0.30 /usr/local/tomcat

ADD security.conf /etc/httpd/conf.d/security.conf
ADD mod_jk.so /usr/lib64/httpd/modules/mod_jk.so
ADD workers.properties /etc/httpd/conf.d/workers.properties
ADD mod_jk.conf /etc/httpd/conf.d/mod_jk.conf
RUN chmod 755 /usr/lib64/httpd/modules/mod_jk.so

ENV HTTPD_BASE /var/www
ENV HTTPD_ROOT /var/www/html
ENV TOMCAT_BASE /usr/local/tomcat/webapps

VOLUME $HTTPD_BASE
VOLUME $TOMCAT_BASE

RUN sed -i '/ServerRoot "\/etc\/httpd"/a\
ServerTokens OS\
ServerSignature On' /etc/httpd/conf/httpd.conf

RUN sed -i 's/DirectoryIndex index.html/DirectoryIndex index.html index.htm index.jsp/g' /etc/httpd/conf/httpd.conf

#For some issues
RUN sed -i 's/EnableSendfile on/#EnableSendfile on/g' /etc/httpd/conf/httpd.conf
RUN sed -in '/<Directory \/>/,/<\/Directory>/ c<Directory />\
    Options FollowSymLinks\
    AllowOverride None\
</Directory>' /etc/httpd/conf/httpd.conf
RUN sed -in '/<Directory "\/var\/www">/,/<\/Directory>/ c<Directory "\/var\/www">\
   AllowOverride None\
   Options All -Indexes\
   Order allow,deny\
   Allow from all\
</Directory>' /etc/httpd/conf/httpd.conf

#CGI issues
RUN sed -i 's/ScriptAlias \/cgi-bin\/ "\/var\/www\/cgi-bin\/"/#ScriptAlias \/cgi-bin\/ "\/var\/www\/cgi-bin\/"/g' /etc/httpd/conf/httpd.conf
RUN sed -i 's/#AddHandler cgi-script .cgi/AddHandler cgi-script .cgi/g' /etc/httpd/conf/httpd.conf
RUN sed -in '/<Directory "\/var\/www\/cgi-bin">/,/<\/Directory>/ s/^/\#/g' /etc/httpd/conf/httpd.conf

#Support UTF8
RUN sed -i 's/redirectPort="8443"/redirectPort="8443" URIEncoding="UTF-8"/g' /usr/local/tomcat/conf/server.xml

ENV CATALINA_HOME /usr/local/tomcat
ENV CATALINA_BASE /usr/local/tomcat
ENV CLASSPATH $CLASSPATH:$CATALINA_HOME/common/lib
ENV PATH $PATH:$CATALINA_HOME/bin

RUN echo "CATALINA_HOME=$CATALINA_HOME" >> /etc/profile
RUN echo "CATALINA_BASE=$CATALINA_BASE" >> /etc/profile
RUN echo "CLASSPATH=$CLASSPATH" >> /etc/profile
RUN echo "PATH=$PATH" >> /etc/profile
RUN echo "export PATH CLASSPATH CATALINA_HOME CATALINA_BASE" >> /etc/profile

EXPOSE 80
EXPOSE 8080

CMD ["/env_config.sh"]
CMD ["/usr/sbin/httpd"]
CMD ["/usr/local/tomcat/bin/startup.sh"]
