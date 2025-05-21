#!/bin/bash

apt-get update
apt-get install -y wget gnupg2 lsb-release curl

# Instalar ProxySQL
wget -qO - https://repo.proxysql.com/ProxySQL/repo_pub_key | apt-key add -
echo deb https://repo.proxysql.com/ProxySQL/proxysql-2.5.x/$(lsb_release -sc)/ ./ \
    > /etc/apt/sources.list.d/proxysql.list
apt-get update
apt-get install -y proxysql

# Configurar ProxySQL
mysql -u admin -padmin -h 127.0.0.1 -P 6032 <<EOF
INSERT INTO mysql_servers (hostgroup_id, hostname, port, weight) VALUES (10, '192.168.100.20', 3306, 1);
INSERT INTO mysql_servers (hostgroup_id, hostname, port, weight) VALUES (20, '192.168.100.21', 3306, 1);
INSERT INTO mysql_servers (hostgroup_id, hostname, port, weight) VALUES (20, '192.168.100.22', 3306, 1);

INSERT INTO mysql_query_rules (rule_id, active, match_pattern, destination_hostgroup, apply) VALUES (1, 1, '^SELECT.*', 20, 1);
INSERT INTO mysql_query_rules (rule_id, active, match_pattern, destination_hostgroup, apply) VALUES (2, 1, '^INSERT.*', 10, 1);
INSERT INTO mysql_query_rules (rule_id, active, match_pattern, destination_hostgroup, apply) VALUES (3, 1, '^UPDATE.*', 10, 1);
INSERT INTO mysql_query_rules (rule_id, active, match_pattern, destination_hostgroup, apply) VALUES (4, 1, '^DELETE.*', 10, 1);

LOAD MYSQL SERVERS TO RUNTIME;
SAVE MYSQL SERVERS TO DISK;
LOAD MYSQL QUERY RULES TO RUNTIME;
SAVE MYSQL QUERY RULES TO DISK;
EOF
