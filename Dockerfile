FROM eviles/jenkins

ARG FIREFOX_VERSION 45.0.2
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
&& yum install -y firefox google-chrome-stable xorg-x11-server-Xvfb libexif \
&& yum remove -y firefox \
&& yum clean all \
&& rm -rf /var/cache/yum/* \
&& curl -s -L --url "https://download-installer.cdn.mozilla.net/pub/firefox/releases/${FIREFOX_VERSION}/linux-x86_64/en-US/firefox-${FIREFOX_VERSION}.tar.bz2" | tar -C /opt -xjf \
&& ln -fs /opt/firefox/firefox /usr/bin/firefox \
&& echo "[program:xvfb]" >> /etc/supervisord.conf \
&& echo "command=/usr/bin/Xvfb ${DISPLAY} -ac -screen 0 ${SCREEN_WIDTH}x${SCREEN_HEIGHT}x${SCREEN_DEPTH}" >> /etc/supervisord.conf \
&& sed -i 's/chrome\"/chrome\" -no-sandbox/' /opt/google/chrome/google-chrome \
&& sed -i 's/google-chrome/google-chrome -no-sandbox/' /opt/google/chrome/google-chrome
