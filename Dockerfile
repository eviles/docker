FROM eviles/oracle-jdk8

RUN curl -L --url "http://www.us.apache.org/dist/tomcat/tomcat-8/v8.0.30/bin/apache-tomcat-8.0.30.tar.gz" | tar xz -C /tmp

RUN mv /tmp/apache-tomcat-8.0.30 /usr/local
RUN ln -s /usr/local/apache-tomcat-8.0.30 /usr/local/tomcat

VOLUME /usr/local/tomcat/webapps

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

EXPOSE 8080

CMD ["/usr/local/tomcat/bin/catalina.sh","run"]
