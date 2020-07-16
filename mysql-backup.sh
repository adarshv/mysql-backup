#!/bin/sh

# MySQL database details to which backup to be done.
DB_DATABASE="database"
DB_USER="root"
DB_PASSWORD="password"
DB_HOST="localhost"

# Creating backup
backup()
{
  # Creating directory for storing backups
  mkdir -p ~/mysqlbackup/backups
  
  # Nominating target filename
  DATESTAMP=`date "+%d%m%Y-%H%M"`
  FILE_NAME="${DB_DATABASE}-${DATESTAMP}.sql"
  
  # Dumping MySQL Database to SQL file
  cd ~/mysqlbackup/backups
  mysqldump --opt --user=${DB_USER} --password=${DB_PASSWORD} ${DB_DATABASE} > ${FILE_NAME}
  
  # Gzipping generated SQL backup file
  gzip $FILE_NAME
  
  echo "Created backup of ${DB_DATABASE} on ${DATESTAMP} as ${FILE_NAME}.gz"
}

# Scheduling daily backup
schedule()
{
  # Creating directory for storing automation script
  mkdir -p ~/mysqlbackup/bin
  
  # Installing automation script
  SCRIPTPATH=$(readlink -f "$0")
  ln -f $SCRIPTPATH ~/mysqlbackup/bin/automate
  
  # Creating cronjob to run mysql backup everyday at 1 AM
  if ! crontab -l | grep -q '~/mysqlbackup/bin/automate backup'
  then
  crontab -l | { cat; echo "0 1 * * * ~/mysqlbackup/bin/automate backup >> ~/mysqlbackup/backup.log 2>&1"; } | crontab -
  echo "Installed automation script and scheduled to run daily at 1 AM"
  fi
}

case "$1" in
  backup)
    backup
  ;;
  schedule)
    schedule
  ;;
  *)
  echo "Usage: $0 [options]"
  echo "$0 backup    Manually run a MySQL backup"
  echo "$0 schedule  Schedule MySQL backup daily at 1 AM"
  ;;
esac