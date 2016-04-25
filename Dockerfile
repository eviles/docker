FROM eviles/oracle-jdk8

ARG JENKINS_VERSION=1.658
ARG JENKINS_USER=jenkins
ARG JENKINS_GROUP=jenkins
ARG JENKINS_UID=1000
ARG JENKINS_GID=1000

ENV JAVA_OPTS=-Xmx512m
ENV JENKINS_HOME=/var/jenkins
ENV JENKINS_SLAVEPORT=50000

RUN /usr/sbin/groupadd --gid $JENKINS_GID $JENKINS_GROUP \
&& /usr/sbin/useradd --uid $JENKINS_UID --gid $JENKINS_GID --create-home --shell /bin/bash $JENKINS_USER \
&& yum install -y wget git unzip zip \
&& yum clean all \
&& rm -rf /var/cache/yum/* \
&& mkdir -p /usr/share/jenkins \
&& curl -fsSL http://repo.jenkins-ci.org/public/org/jenkins-ci/main/jenkins-war/${JENKINS_VERSION}/jenkins-war-${JENKINS_VERSION}.war -o /usr/share/jenkins/jenkins.war \
&& chown -R $JENKINS_USER:$JENKINS_GROUP /usr/share/jenkins \
&& chmod ug+x /usr/share/jenkins/jenkins.war \
&& mkdir -p ${JENKINS_HOME} \
&& chown -R $JENKINS_USER:$JENKINS_GROUP ${JENKINS_HOME} \
&& echo "[program:jenkins]" >> /etc/supervisord.conf \
&& echo "command=java -jar /usr/share/jenkins/jenkins.war" >> /etc/supervisord.conf

VOLUME /var/jenkins
EXPOSE 8080 50000
