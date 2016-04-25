FROM eviles/jenkins

ENV SCREEN_WIDTH=1360
ENV SCREEN_HEIGHT=1020
ENV SCREEN_DEPTH=24
ENV DISPLAY=:99

RUN echo "[google-chrome]" > /etc/yum.repos.d/google-chrome.repo \
&& echo "name=google-chrome" >> /etc/yum.repos.d/google-chrome.repo \
&& echo "baseurl=http://dl.google.com/linux/chrome/rpm/stable/\$basearch" >> /etc/yum.repos.d/google-chrome.repo \
&& echo "enabled=1" >> /etc/yum.repos.d/google-chrome.repo \
&& echo "gpgcheck=1" >> /etc/yum.repos.d/google-chrome.repo \
&& echo "gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub" >> /etc/yum.repos.d/google-chrome.repo \
&& yum install -y firefox google-chrome-stable xorg-x11-server-Xvfb libXtst libexif \
&& yum clean all \
&& rm -rf /var/cache/yum/* \
&& echo "[program:xvfb]" >> /etc/supervisord.conf \
&& echo "command=/usr/bin/Xvfb ${DISPLAY} -ac -screen 0 ${SCREEN_WIDTH}x${SCREEN_HEIGHT}x${SCREEN_DEPTH} &" >> /etc/supervisord.conf
