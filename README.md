# Automated MySQL Backup

Automated backups of mysql databases on UNIX-like systems.

## Installation

Download the script and edit it with your own MySQL credentials.

```bash
wget https://git.io/JJGar -O mysqlsetup.sh
nano -w mysqlsetup.sh
[Replace with your own values: DB_DATABASE, DB_USER, DB_PASSWORD and DB_HOST]
```
Perform a MySQL manual backup
```
sh mysqlsetup.sh backup
```
Schedule a daily MySQL backup at 1AM
```
sh mysqlsetup.sh automate
```

## License
Copyright (C) 2020 Adarsh Vengarathodi <mail@adarshv.com>

Attribution required: Please include my name in any derivative and let me know how you have improved it!
