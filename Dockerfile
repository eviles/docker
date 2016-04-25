FROM eviles/centos-sshd

ARG JAVA_MAJOR_VERSION=8 \
    JAVA_UPDATE_VERSION=91 \
    JAVA_BUILD_NUMER=14

RUN curl -s -L --header "Cookie: oraclelicense=accept-securebackup-cookie;" --url "http://download.oracle.com/otn-pub/java/jdk/$JAVA_MAJOR_VERSIONu$JAVA_UPDATE_VERSION-b$JAVA_BUILD_NUMER/jdk-$JAVA_MAJOR_VERSIONu$JAVA_UPDATE_VERSION-linux-x64.tar.gz" | tar xz -C /usr/local

RUN ln -s /usr/local/jdk1.$JAVA_MAJOR_VERSION.0_$JAVA_UPDATE_VERSION /usr/local/java

ENV JAVA_HOME=/usr/local/java \
    CLASSPATH=./:$JAVA_HOME/lib:$JAVA_HOME/jre/lib/ext \
    PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin

RUN echo "JAVA_HOME=$JAVA_HOME" >> /etc/profile \
&& echo "CLASSPATH=./:\$JAVA_HOME/lib:\$JAVA_HOME/jre/lib/ext" >> /etc/profile \
&& echo "PATH=\$PATH:\$JAVA_HOME/bin:\$JAVA_HOME/jre/bin" >> /etc/profile \
&& echo "export PATH JAVA_HOME CLASSPATH" >> /etc/profile
