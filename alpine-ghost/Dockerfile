FROM eviles/alpine-sshd

ARG GHOST_VERSION=1.20.3
ENV GHOST_DIR=/usr/src/ghost
ENV GHOST_CONTENT=/usr/src/ghost/content

WORKDIR $GHOST_DIR

RUN apk --update add nodejs nodejs-npm \
&& curl -L "https://github.com/TryGhost/Ghost/releases/download/${GHOST_VERSION}/Ghost-${GHOST_VERSION}.zip" -o ghost.zip\
&& unzip ghost.zip \
&& npm install --production \
&& rm ghost.zip \
&& rm -rf /var/cache/apk/* \
&& echo "[program:ghost]" >> /etc/supervisord.conf \
&& echo "command=node $GHOST_DIR/index.js" >> /etc/supervisord.conf \
&& echo "directory=$GHOST_DIR" >> /etc/supervisord.conf \
&& echo "stdout_logfile=/dev/stdout" >> /etc/supervisord.conf \
&& echo "stdout_logfile_maxbytes=0" >> /etc/supervisord.conf \
&& echo "stderr_logfile=/dev/stderr" >> /etc/supervisord.conf \
&& echo "stderr_logfile_maxbytes=0" >> /etc/supervisord.conf

VOLUME $GHOST_CONTENT
EXPOSE 2368
