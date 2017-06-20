FROM eviles/alpine-sshd

COPY installer.sh /home/pmmp/

RUN apk --update add ncurses \
&& rm -rf /var/cache/apk/* \
&& /usr/sbin/addgroup -g 1000 pmmp \
&& /usr/sbin/adduser -u 1000 -G pmmp -h /home/pmmp -D pmmp \
&& echo "[program:pmmp]" >> /etc/supervisord.conf \
&& echo "user=pmmp" >> /etc/supervisord.conf \
&& echo "directory=/home/pmmp" >> /etc/supervisord.conf \
&& echo "command=bash start.sh --no-wizard" >> /etc/supervisord.conf \
&& echo "stdout_logfile=/dev/stdout" >> /etc/supervisord.conf \
&& echo "stdout_logfile_maxbytes=0" >> /etc/supervisord.conf \
&& echo "stderr_logfile=/dev/stderr" >> /etc/supervisord.conf \
&& echo "stderr_logfile_maxbytes=0" >> /etc/supervisord.conf \
&& chown -R pmmp:pmmp /home/pmmp \
&& chmod 755 /home/pmmp/installer.sh

USER pmmp
WORKDIR /home/pmmp/
RUN bash /home/pmmp/installer.sh
USER root

EXPOSE 19132
