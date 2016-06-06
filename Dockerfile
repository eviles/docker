FROM eviles/httpd

RUN yum -y groupinstall 'Development Tools' \
&& yum -y install net-tools libstdc++ libstdc++.i686 libcurl libcurl.i686 \
&& yum clean all \
&& rm -rf /var/cache/yum/*
