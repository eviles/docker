FROM eviles/alpine-sshd

RUN apk --update add certbot openssl nginx \
&& rm -rf /var/cache/apk/* \
&& echo "[program:nginx]" >> /etc/supervisord.conf \
&& echo "command=/run_nginx.sh" >> /etc/supervisord.conf \
&& openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048

ADD run_nginx.sh /run_nginx.sh
RUN chmod 755 /run_nginx.sh

EXPOSE 80 443
