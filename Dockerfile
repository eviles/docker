FROM centos:7

RUN yum -y install openssh openssh-clients openssh-server
RUN yum clean all

EXPOSE 22

RUN ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
RUN ssh-keygen -f /etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa
RUN ssh-keygen -A
RUN echo "root:root" | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/session\s*required\s*pam_loginuid.so/session    optional     pam_loginuid.so/g' /etc/pam.d/sshd
CMD ["/usr/sbin/sshd", "-D"]
