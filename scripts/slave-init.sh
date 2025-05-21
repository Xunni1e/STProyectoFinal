#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y mysql-server

# Configurar MySQL
sed -i '/^bind-address/c\bind-address = 0.0.0.0' /etc/mysql/mysql.conf.d/mysqld.cnf

SLAVE_ID=$(hostname | grep -o '[0-9]*$')
cat <<EOF >> /etc/mysql/mysql.conf.d/mysqld.cnf
server-id=$((100 + SLAVE_ID))
read_only=1
super_read_only=1
EOF

systemctl restart mysql

# Esperar que master esté disponible y configurar replicación
sleep 10

mysql -u root <<EOF
STOP SLAVE;
CHANGE MASTER TO
  MASTER_HOST='192.168.100.20',
  MASTER_USER='replicator',
  MASTER_PASSWORD='replica_password',
  MASTER_LOG_FILE='mysql-bin.000001',
  MASTER_LOG_POS=154;
START SLAVE;
EOF
