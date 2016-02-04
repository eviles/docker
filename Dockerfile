FROM eviles/centos-sshd

RUN curl -L --header "Cookie: oraclelicense=accept-securebackup-cookie;" --url "http://download.oracle.com/otn-pub/java/jdk/8u71-b15/jdk-8u71-linux-x64.tar.gz" | tar xz -C /tmp

RUN mv /tmp/jdk1.8.0_71 /usr/local
RUN ln -s /usr/local/jdk1.8.0_71 /usr/local/java

ENV JAVA_HOME /usr/local/java
ENV CLASSPATH=./:$JAVA_HOME/lib:$JAVA_HOME/jre/lib/ext
ENV PATH /usr/local/bin:$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$PATH

RUN echo "JAVA_HOME=/usr/local/java" >> /etc/profile
RUN echo "CLASSPATH=./:\$JAVA_HOME/lib:\$JAVA_HOME/jre/lib/ext" >> /etc/profile
RUN echo "PATH=/usr/local/bin:\$JAVA_HOME/bin:\$JAVA_HOME/jre/bin:\$PATH" >> /etc/profile
RUN echo "export PATH USER LOGNAME MAIL HOSTNAME HISTSIZE INPUTRC JAVA_HOME CLASSPATH" >> /etc/profile

RUN echo $PATH
