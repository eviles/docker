FROM eviles/tomcat8

RUN yum -y groupinstall 'Development Tools' \
&& yum -y install net-tools libstdc++ libstdc++.i686 libcurl libcurl.i686 \
&& yum clean all \
&& rm -rf /var/cache/yum/* \
&& localedef -i zh_TW -c -f UTF-8 zh_TW.UTF-8
