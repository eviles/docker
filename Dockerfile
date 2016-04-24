FROM blacklabelops/jenkins

ENV SCREEN_WIDTH 1360
ENV SCREEN_HEIGHT 1020
ENV SCREEN_DEPTH 24
ENV DISPLAY :99

USER root
COPY google-chrome.repo /etc/yum.repos.d/google-chrome.repo
RUN yum install -y firefox google-chrome-stable xorg-x11-server-Xvfb libXtst libexif \
&& yum clean all
COPY xvfb /etc/init.d
RUN chmod +x /etc/init.d/xvfb
USER jenkins
