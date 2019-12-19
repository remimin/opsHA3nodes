#!/bin/bash -x
if [ -e ./CONF ];then
 source ./CONF
fi
sst_usr=${SST_USR:-'xtrabackup'}
sst_usr_passwd=${SST_PASSWD:-'mypassword'}

mysql -e "CREATE USER ${sst_usr}@\"localhost\" IDENTIFIED BY ${sst_usr_passwd};"
mysql -e "GRANT RELOAD, PROCESS, LOCK TABLES, REPLICATION CLIENT ON *.* TO ${sst_usr}@\"localhost\";"

## Haproxy User create
# mysql -e "CREATE USER haproxy@\"%\"  IDENTIFIED BY \"haproxy\";"
# controler01/controller02/controller03/vip
mysql -e "insert user(user, host) values ('haproxy', '172.20.3.114'); flush privileges;" mysql
mysql -e "insert user(user, host) values ('haproxy', '172.20.3.195'); flush privileges;" mysql
mysql -e "insert user(user, host) values ('haproxy', '172.20.3.230'); flush privileges;" mysql
mysql -e "insert user(user, host) values ('haproxy', '172.20.3.99'); flush privileges;" mysql
