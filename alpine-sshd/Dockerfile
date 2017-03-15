FROM alpine

ARG GLIBC_VERSION=2.25-r0

RUN apk --update add supervisor nss-pam-ldapd openssh bash wget curl tar \
&& ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa \
&& ssh-keygen -f /etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa \
&& ssh-keygen -A \
&& curl -o /var/cache/apk/glibc.apk -L "https://github.com/andyshinn/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk" \
&& apk add --allow-untrusted /var/cache/apk/glibc.apk \
&& curl -o /var/cache/apk/glibc-bin.apk -L "https://github.com/andyshinn/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk" \
&& apk add --allow-untrusted /var/cache/apk/glibc-bin.apk \
&& /usr/glibc-compat/sbin/ldconfig /lib /usr/glibc/usr/lib \
&& echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf \
&& rm -rf /var/cache/apk/* \
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
&& echo "command=/usr/sbin/sshd -D" >> /etc/supervisord.conf

EXPOSE 22

ADD run.sh /run.sh
RUN chmod 755 /run.sh

CMD ["/run.sh"]
