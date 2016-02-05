#!/bin/bash

/usr/sbin/sshd
/usr/sbin/httpd -k restart
/usr/local/tomcat/bin/catalina.sh run
