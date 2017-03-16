#!/bin/bash

if [ "$ROOT_PWD" == "" ]; then
  ROOT_PWD=`date +%s | sha256sum | base64 | head -c 32 ; echo`
  echo "SETTING ROOT PASSWORD:$ROOT_PWD"
fi
echo "root:$ROOT_PWD" | chpasswd

/usr/bin/supervisord -c /etc/supervisord.conf
