FROM alpine

RUN apk update \
&& apk add supervisor nss-pam-ldapd openssh bash wget curl \
&& rm -rf /var/cache/apk/* \
&& ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa \
&& ssh-keygen -f /etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa \
&& ssh-keygen -A \
&& sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
&& echo "[supervisord]" > /etc/supervisord.conf \
&& echo "nodaemon=true" >> /etc/supervisord.conf \
&& echo "[unix_http_server]" >> /etc/supervisord.conf \
&& echo "file=/run/supervisord.sock" >> /etc/supervisord.conf \
&& echo "chmod=0770" >> /etc/supervisord.conf \
&& echo "[supervisorctl]" >> /etc/supervisord.conf \
&& echo "serverurl=unix:///run/supervisord.sock" >> /etc/supervisord.conf \
&& echo "[rpcinterface:supervisor]" >> /etc/supervisord.conf \
&& echo "supervisor.rpcinterface_factory=supervisor.rpcinterface:make_main_rpcinterface" >> /etc/supervisord.conf \
&& echo "[program:sshd]" >> /etc/supervisord.conf \
&& echo "command=/usr/sbin/sshd -D" >> /etc/supervisord.conf \
&& echo "root:123456" | chpasswd

EXPOSE 22

ADD run.sh /run.sh
RUN chmod 755 /run.sh

CMD ["/run.sh"]
