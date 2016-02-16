FROM eviles/oracle-jdk8

RUN curl -s -L --url "http://www.us.apache.org/dist/tomcat/tomcat-8/v8.0.32/bin/apache-tomcat-8.0.32.tar.gz" | tar xz -C /tmp

RUN mv /tmp/apache-tomcat-8.0.32 /usr/local;\
    ln -s /usr/local/apache-tomcat-8.0.32 /usr/local/tomcat;

#Support UTF8
RUN sed -i 's/redirectPort="8443"/redirectPort="8443" URIEncoding="UTF-8"/g' /usr/local/tomcat/conf/server.xml

ENV CATALINA_HOME /usr/local/tomcat
ENV CLASSPATH $CLASSPATH:$CATALINA_HOME/common/lib
ENV PATH $PATH:$CATALINA_HOME/bin

RUN echo "CATALINA_HOME=$CATALINA_HOME" >> /etc/profile && \
    echo "CLASSPATH=\$CLASSPATH:\$CATALINA_HOME/common/lib" >> /etc/profile && \
    echo "PATH=\$PATH:\$CATALINA_HOME/bin" >> /etc/profile && \
    echo "export PATH CLASSPATH CATALINA_HOME" >> /etc/profile;

RUN echo "[program:tomcat]" >> /etc/supervisord.conf && \
    echo "command=/usr/local/tomcat/bin/catalina.sh run" >> /etc/supervisord.conf

EXPOSE 8080
VOLUME /usr/local/tomcat/webapps
