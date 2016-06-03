FROM eviles/alpine-sshd

RUN apk --update add nginx \
&& rm -rf /var/cache/apk/* \
&& echo "[program:nginx]" >> /etc/supervisord.conf \
&& echo "command=/usr/sbin/nginx -g \"daemon off;\"" >> /etc/supervisord.conf \
# Fix some error...
&& mkdir /run/nginx

EXPOSE 80 443
VOLUME //var/lib/nginx/html
