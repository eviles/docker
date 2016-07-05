FROM eviles/centos-sshd

RUN rpm -Uvh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm \
&& yum -y install nginx \
&& yum clean all \
&& rm -rf /var/cache/yum/* \
&& echo "[program:nginx]" >> /etc/supervisord.conf \
&& echo "command=/usr/sbin/nginx -g \"daemon off;\"" >> /etc/supervisord.conf

EXPOSE 80 443