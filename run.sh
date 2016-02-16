#!/bin/bash

if [ "$ROOT_PWD" == "" ]; then
  ROOT_PWD=123456
fi
echo "root:$ROOT_PWD" | chpasswd

/usr/bin/supervisord
