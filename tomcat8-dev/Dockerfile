FROM eviles/tomcat8

ADD activation-1.1.jar /usr/local/java/jre/lib/ext/activation-1.1.jar
ADD mail-1.4.7.jar /usr/local/java/jre/lib/ext/mail-1.4.7.jar
ADD mysql-connector-java-5.1.38.jar /usr/local/java/jre/lib/ext/mysql-connector-java-5.1.38.jar
ADD mysql-connector-java-5.1.38.jar /usr/local/tomcat/lib/mysql-connector-java-5.1.38.jar

RUN yum -y groupinstall 'Development Tools' \
&& yum -y install wget less net-tools libstdc++ libstdc++.i686 libcurl libcurl.i686 \
&& yum clean all \
&& rm -rf /var/cache/yum/* \
&& localedef -i zh_TW -c -f UTF-8 zh_TW.UTF-8

ENV LC_ALL=zh_TW.UTF-8
