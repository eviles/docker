#!/bin/bash

set -x

if [ ! -d "/var/lib/mysql/mysql" ]; then
	mysql_install_db --user=mysql--datadir=/var/lib/mysql
fi
set -- mysqld "$@"
exec "$@" --wsrep_node_address="${HOSTNAME}" \
    --wsrep_cluster_name="${CLUSTER_NAME}" \
    --wsrep_cluster_address="gcomm://${CLUSTER}" \
    --wsrep_node_name="${HOSTNAME}"
