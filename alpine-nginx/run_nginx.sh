#!/bin/bash

# Fix nginx error on startup...
if [ ! -d "/run/nginx" ]; then
  mkdir /run/nginx
fi

# DOMAINS => example.com,www.example.com
if [ "$DOMAINS" != "" ]; then
  IFS=',' read -r -a ADDR <<< "$DOMAINS"
  if [ ! -d "/etc/letsencrypt/live/${ADDR[0]}" ]; then
    # Generate Strong Diffie-Hellman Group
    openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048
    # Replace default.conf
    SERVER_NAME=`echo $DOMAINS | sed 's/,/ /g'`
    sed 's/server_name example.com/server_name ${SERVER_NAME}/g' /etc/nginx/conf.d/default.conf.new | sed 's/example.com/${ADDR[0]}/g' > /etc/nginx/conf.d/default.conf
    # Start NGINX for Certbot
    nginx
    # Obtain a Certificate
    certbot certonly --verbose --noninteractive --quiet --standalone --agree-tos --register-unsafely-without-email --webroot-path /var/lib/nginx/html -domains "${DOMAINS}"
    # Stop NGINX
    nginx -s quit
  fi
else
  certbot renew
fi

/usr/sbin/nginx -g "daemon off;"
