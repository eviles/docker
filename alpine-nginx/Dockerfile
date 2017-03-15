FROM eviles/alpine-sshd

RUN apk --update add certbot nginx \
&& rm -rf /var/cache/apk/* \
&& echo "[program:nginx]" >> /etc/supervisord.conf \
&& echo "command=/usr/sbin/nginx -g \"daemon off;\"" >> /etc/supervisord.conf \
# Fix nginx error on startup...
&& mkdir /run/nginx

EXPOSE 80 443
