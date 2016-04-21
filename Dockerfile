FROM jenkins

USER root
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - &&
    sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' &&
    apt-get update && apt-get install -y firefox google-chrome-stable && rm -rf /var/lib/apt/lists/*
USER jenkins
