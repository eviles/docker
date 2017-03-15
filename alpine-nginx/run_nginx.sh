#!/bin/bash

# Fix nginx error on startup...
if [ ! -d "/run/nginx" ]; then
  mkdir /run/nginx
fi

if [ "$DOMAINS" != "" ]; then
  certbot certonly --verbose --noninteractive --quiet --standalone --agree-tos --register-unsafely-without-email --webroot-path /var/lib/nginx/html -domains "${DOMAINS}"
else
  certbot renew
fi

usr/sbin/nginx -g "daemon off;"
