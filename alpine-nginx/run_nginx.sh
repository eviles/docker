#!/bin/bash

# Fix nginx error on startup...
if [ ! -d "/run/nginx" ]; then
  mkdir /run/nginx
fi

# DOMAINS => example.com,www.example.com
if [ "$DOMAINS" != "" ]; then
  IFS=',' read -r -a ADDR <<< "$DOMAINS"
  if [ ! -d "/etc/letsencrypt/live/${ADDR[0]}" ]; then
    # Setting default.conf for WEBROOT
    cat /etc/nginx/default.conf.template > /etc/nginx/conf.d/default.conf
    # Start NGINX
    nginx
    # Obtain a Certificate
    certbot certonly --verbose --noninteractive --quiet --standalone --agree-tos --register-unsafely-without-email --webroot-path /var/lib/nginx/html -d "${DOMAINS}"
    # Stop NGINX
    nginx -s quit
    
    # Generate Strong Diffie-Hellman Group
    openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048
    
    # Replace default.conf
    SERVER_NAME=`echo $DOMAINS | sed 's/,/ /g'`
    sed "s/server_name example.com/server_name ${SERVER_NAME}/g" /etc/nginx/ssl.conf.template | sed "s/example.com/${ADDR[0]}/g" > /etc/nginx/conf.d/default.conf
    # Fix Config Conflicts
    sed -i 's/ssl_session_cache/#ssl_session_cache/g' /etc/nginx/nginx.conf
    
    # Add Cron Job
    echo 'certbot renew' > /etc/periodic/weekly/certbot-renew.sh
    chmod 755 /etc/periodic/weekly/certbot-renew.sh
  else
    if [ ! -f "/etc/ssl/certs/dhparam.pem" ]; then
      # If Not Exist Regenerate It
      openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048
      # Fix Config Conflicts
      sed -i 's/ssl_session_cache/#ssl_session_cache/g' /etc/nginx/nginx.conf
    fi
    certbot renew
  fi
fi

/usr/sbin/nginx -g "daemon off;"
