FROM eviles/alpine-sshd

RUN apk --update add ncurses \
&& rm -rf /var/cache/apk/* \
&& adduser -D pmmp

COPY installer.sh /home/pmmp/

RUN chown -R pmmp:pmmp /home/pmmp/

USER pmmp
WORKDIR /home/pmmp/

RUN chmod 755 installer.sh \
&& bash installer.sh

EXPOSE 19132

ENTRYPOINT bash /home/pmmp/start.sh --no-wizard
