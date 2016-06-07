#!/bin/bash

set -x

export TERM=xterm

set -- mysqld "$@"

if [ ! -d "/var/lib/mysql/mysql" ]; then
  mysql_install_db --user=mysql --datadir=/var/lib/mysql --rpm

  "$@" --skip-networking &
  pid="$!"

  mysql=( mysql --protocol=socket -uroot )

  for i in {30..0}; do
    if echo 'SELECT 1' | "${mysql[@]}" &> /dev/null; then
      break
    fi
    echo 'MySQL init process in progress...'
    sleep 1
  done
  if [ "$i" = 0 ]; then
    echo >&2 'MySQL init process failed.'
    exit 1
  fi

  echo "CREATE USER 'sstuser'@'%' IDENTIFIED BY 'sstpass' ;" | "${mysql[@]}"
  echo "GRANT ALL PRIVILEGES ON *.* TO 'sstuser'@'%' ;" | "${mysql[@]}"
  echo 'FLUSH PRIVILEGES ;' | "${mysql[@]}"
  
  if ! kill -s TERM "$pid" || ! wait "$pid"; then
    echo >&2 'MySQL init process failed.'
    exit 1
  fi
fi

if [ ${NEW_CLUSTER} = "1" ]; then
  exec "$@" --wsrep_new_cluster \
    --wsrep_node_address="`hostname -i`" \
    --wsrep_cluster_name="${CLUSTER_NAME}" \
    --wsrep_cluster_address="gcomm://" \
    --wsrep_node_name="${HOSTNAME}"
else
  exec "$@" --wsrep_node_address="`hostname -i`" \
    --wsrep_cluster_name="${CLUSTER_NAME}" \
    --wsrep_cluster_address="gcomm://${CLUSTER}" \
    --wsrep_node_name="${HOSTNAME}"
fi
