FROM eviles/alpine-sshd

RUN apk --update add certbot nginx \
&& rm -rf /var/cache/apk/* \
&& echo "[program:nginx]" >> /etc/supervisord.conf \
&& echo "command=/run_nginx.sh" >> /etc/supervisord.conf

EXPOSE 80 443
