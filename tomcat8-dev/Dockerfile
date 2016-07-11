FROM eviles/tomcat8

ARG YAZ_VERSION=5.16.0

ADD activation-1.1.jar /usr/local/java/jre/lib/ext/activation-1.1.jar
ADD mail-1.4.7.jar /usr/local/java/jre/lib/ext/mail-1.4.7.jar
ADD mysql-connector-java-5.1.38.jar /usr/local/java/jre/lib/ext/mysql-connector-java-5.1.38.jar
ADD mysql-connector-java-5.1.38.jar /usr/local/tomcat/lib/mysql-connector-java-5.1.38.jar

RUN yum -y install epel-release \
&& yum -y groupinstall 'Development Tools' \
&& yum -y install wget less net-tools libstdc++ libstdc++.i686 libcurl libcurl.i686 \
&& yum clean all \
&& rm -rf /var/cache/yum/* \
&& curl -s -L --url "http://ftp.indexdata.com/pub/yaz/yaz-${YAZ_VERSION}.tar.gz" | tar xz -C /usr/local/src \
&& cd /usr/local/src/yaz-${YAZ_VERSION} \
&& ./configure \
&& make \
&& make install \
&& rm -rf /usr/local/src/yaz-${YAZ_VERSION} \
&& localedef -i zh_TW -c -f UTF-8 zh_TW.UTF-8

ENV LC_ALL=zh_TW.UTF-8
