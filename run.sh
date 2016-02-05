#!/bin/bash

/usr/sbin/sshd
/usr/local/tomcat/bin/catalina.sh start
/usr/sbin/httpd -D FOREGROUND
