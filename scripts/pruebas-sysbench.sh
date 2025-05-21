#!/bin/bash

sudo apt-get update
sudo apt-get install -y sysbench

sysbench \\
  --mysql-host=127.0.0.1 \\
  --mysql-port=6033 \\
  --mysql-user=replicator \\
  --mysql-password=replica_password \\
  --mysql-db=testdb \\
  --tables=1 \\
  --table-size=10000 \\
  oltp_read_write prepare

sysbench \\
  --mysql-host=127.0.0.1 \\
  --mysql-port=6033 \\
  --mysql-user=replicator \\
  --mysql-password=replica_password \\
  --mysql-db=testdb \\
  --tables=1 \\
  --table-size=10000 \\
  --threads=10 \\
  --time=60 \\
  oltp_read_only run


