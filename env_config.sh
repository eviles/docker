#!/bin/bash

sed -i 's/DocumentRoot "\/var\/www\/html"/DocumentRoot "$2"/g' /etc/httpd/conf/httpd.conf
sed -i 's/<Directory "\/var\/www">/<Directory "$1">/g' /etc/httpd/conf/httpd.conf
sed -i 's/appBase="webapps"/appBase="$4"/g' /usr/local/tomcat/conf/server.xml

mkdir -p $1
mkdir -p $2
mkdir -p $4
ln -s $HTTPD_BASE $3
