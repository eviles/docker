FROM eviles/alpine-sshd

ARG GHOST_VERSION=0.11.9
ARG GHOST_DIR=/usr/src/ghost
ARG GHOST_CONTENT=/var/lib/ghost

WORKDIR $GHOST_DIR

RUN apk --update add nodejs \
&& apk add --no-cache --virtual=.build-dependencies wget unzip \
&& wget -O ghost.zip "https://github.com/TryGhost/Ghost/releases/download/${GHOST_VERSION}/Ghost-${GHOST_VERSION}.zip" \
&& unzip ghost.zip \
&& npm install --production \
&& rm ghost.zip \
&& apk del .build-dependencies \
&& rm -rf /var/cache/apk/* \
&& echo "[program:ghost]" >> /etc/supervisord.conf \
&& echo "command=node $GHOST_DIR/index.js" >> /etc/supervisord.conf \
&& echo "directory=$GHOST_DIR" >> /etc/supervisord.conf \
&& echo "environment=NODE_ENV=\"production\"" >> /etc/supervisord.conf \
&& echo "stdout_logfile=/dev/stdout" >> /etc/supervisord.conf \
&& echo "stdout_logfile_maxbytes=0" >> /etc/supervisord.conf \
&& echo "stderr_logfile=/dev/stderr" >> /etc/supervisord.conf \
&& echo "stderr_logfile_maxbytes=0" >> /etc/supervisord.conf \
&& ln -s $GHOST_DIR/content $GHOST_CONTENT \
&& ln -s $GHOST_DIR/config.js $GHOST_CONTENT/config.js

EXPOSE 2368
