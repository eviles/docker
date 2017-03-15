FROM eviles/alpine-sshd

RUN apk --update add certbot openssl nginx \
&& rm -rf /var/cache/apk/* \
&& echo "[program:nginx]" >> /etc/supervisord.conf \
&& echo "command=/run_nginx.sh" >> /etc/supervisord.conf \
&& echo "stdout_logfile=/dev/stdout" >> /etc/supervisord.conf \
&& echo "stdout_logfile_maxbytes=0" >> /etc/supervisord.conf \
&& echo "stderr_logfile=/dev/stderr" >> /etc/supervisord.conf \
&& echo "stderr_logfile_maxbytes=0" >> /etc/supervisord.conf

ADD default.conf /etc/nginx/default.conf.template
ADD ssl.conf.template /etc/nginx/ssl.conf.template
ADD run_nginx.sh /run_nginx.sh
RUN chmod 755 /run_nginx.sh

EXPOSE 80 443
