FROM blacklabelops/jenkins

ENV SCREEN_WIDTH 1360
ENV SCREEN_HEIGHT 1020
ENV SCREEN_DEPTH 24
ENV DISPLAY :99

USER root
RUN echo "[google-chrome]\n\
name=google-chrome\n\
baseurl=http://dl.google.com/linux/chrome/rpm/stable/\$basearch\n\
enabled=1\n\
gpgcheck=1\n\
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub" > /etc/yum.repos.d/google-chrome.repo
RUN yum install -y firefox google-chrome-stable xorg-x11-server-Xvfb libXtst \
&& yum clean all
COPY xvfb /etc/init.d
RUN chmod +x /etc/init.d/xvfb
USER jenkins
