FROM eviles/oracle-jdk8

RUN yum -y install httpd
RUN yum clean all

RUN curl -L --url "http://www.us.apache.org/dist/tomcat/tomcat-8/v8.0.30/bin/apache-tomcat-8.0.30.tar.gz" | tar xz -C /tmp

RUN mv /tmp/apache-tomcat-8.0.30 /usr/local
RUN ln -s /usr/local/apache-tomcat-8.0.30 /usr/local/tomcat

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

CMD ["/usr/local/tomcat/bin/startup.sh"]
