#!/bin/env bash
### backup mysql db
### crontab
### 1 0 * * * /bin/bash /data/scripts/backup_mysql.sh

HOME="/home/data/backup"
MYSQL_HOST="127.0.0.1"
MYSQL_USER="root"
MYSQL_PASS="123456"
MYSQL_PORT="3306"
KEEP_NUM="10"

datetime_str=$(date +'%Y%m%d%H%M')

# INIT
[ ! -d ${HOME} ] && mkdir -p ${HOME:-/tmp}

# DUMP
echo "[backup] start."
mysqldump -h${MYSQL_HOST} -P${MYSQL_PORT}  -u${MYSQL_USER} -p${MYSQL_PASS} -A -B --triggers --events --single-transaction --max_allowed_packet=512M --default-character-set=utf8 | gzip > ${HOME}/pro-mysql_${datetime_str}.gz

# CLEAN
echo "[backup] clean."
ls -t ${HOME:-/tmp}/* | tail -n +$((${KEEP_NUM}+1)) | xargs /bin/rm -rfv

echo "[backup] done."
