#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

# Instalar MySQL
apt-get update
apt-get install -y mysql-server

# Configurar MySQL
sed -i '/^bind-address/c\bind-address = 0.0.0.0' /etc/mysql/mysql.conf.d/mysqld.cnf

cat <<EOF >> /etc/mysql/mysql.conf.d/mysqld.cnf
server-id=1
log_bin=mysql-bin
binlog_do_db=testdb
EOF

systemctl restart mysql

# Crear usuario replicador y base de datos
mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS testdb;
CREATE USER IF NOT EXISTS 'replicator'@'%' IDENTIFIED WITH mysql_native_password BY 'replica_password';
GRANT REPLICATION SLAVE ON *.* TO 'replicator'@'%';
FLUSH PRIVILEGES;
EOF

# Cargar testdb.sql si existe
if [ -f /vagrant/testdb.sql ]; then
  mysql -u root testdb < /vagrant/testdb.sql
fi
