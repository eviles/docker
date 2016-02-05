FROM eviles/oracle-jdk8

RUN yum -y install httpd
RUN yum clean all

RUN curl -L --url "http://www.us.apache.org/dist/tomcat/tomcat-8/v8.0.30/bin/apache-tomcat-8.0.30.tar.gz" | tar xz -C /tmp

RUN mv /tmp/apache-tomcat-8.0.30 /usr/local
RUN ln -s /usr/local/apache-tomcat-8.0.30 /usr/local/tomcat

ADD mod_jk.so /usr/lib64/httpd/modules/mod_jk.so
ADD workers.properties /etc/httpd/conf.d/workers.properties
ADD mod_jk.conf /etc/httpd/conf.d/mod_jk.conf
RUN chmod 755 /usr/lib64/httpd/modules/mod_jk.so

ENV HTTPD_BASE /var/www
ENV TOMCAT_BASE /usr/local/tomcat/webapps

VOLUME /var/www
VOLUME /usr/local/tomcat/webapps

RUN sed -i 's/redirectPort="8443"/redirectPort="8443" URIEncoding="UTF-8"/g' /usr/local/tomcat/conf/server.xml

ENV CATALINA_HOME /usr/local/tomcat
ENV CATALINA_BASE /usr/local/tomcat
ENV CLASSPATH $CLASSPATH:$CATALINA_HOME/common/lib
ENV PATH $PATH:$CATALINA_HOME/bin

RUN echo "CATALINA_HOME=/usr/local/tomcat" >> /etc/profile
RUN echo "CATALINA_BASE=/usr/local/tomcat" >> /etc/profile
RUN echo "CLASSPATH=\$CLASSPATH:\$CATALINA_HOME/common/lib" >> /etc/profile
RUN echo "PATH=\$PATH:\$CATALINA_HOME/bin" >> /etc/profile
RUN echo "export PATH CLASSPATH CATALINA_HOME CATALINA_BASE" >> /etc/profile

EXPOSE 80
EXPOSE 8080

CMD ["/usr/sbin/httpd"]
CMD ["/usr/local/tomcat/bin/startup.sh"]
