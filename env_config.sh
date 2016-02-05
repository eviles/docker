#!/bin/bash

sed -i 's/DocumentRoot "\/var\/www\/html"/DocumentRoot "$1"/g' /etc/httpd/conf/httpd.conf
sed -i 's/<Directory "\/var\/www">/<Directory "$2">/g' /etc/httpd/conf/httpd.conf
sed -i 's/appBase="webapps"/appBase="$3"/g' /usr/local/tomcat/conf/server.xml

mkdir -p $HTTPD_ROOT
mkdir -p $HTTPD_BASE
mkdir -p $TOMCAT_BASE
ln -s $HTTPD_BASE $HTTPD_LINK
