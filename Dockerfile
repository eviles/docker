FROM jenkins

USER root

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update -qq && \
    apt-get install -y -qq \
    wget bzip2 x11vnc xvfb libav-tools tcpdump google-chrome-stable && \
    rm -rf /var/lib/apt/lists/* && \
    wget -q -O /root/firefox.tar.bz2 http://ftp.mozilla.org/pub/firefox/releases/45.0.2/linux-x86_64/zh-TW/firefox-45.0.2.tar.bz2 && \
    tar jxf firefox.tar.bz2 -C /root/ && \
    ln -s /root/firefox/firefox /usr/bin/firefox
USER jenkins
