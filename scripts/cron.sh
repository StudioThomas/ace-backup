#!/bin/bash

# Export all environment vars to use in cron
env | sed 's/^\(.*\)$/export \1/g' > /root/env.sh

chmod +x /root/env.sh

# Replace vars in crontab
# cat /scripts/crontab.txt | while read line; do echo $(eval echo `echo $line`); done > /var/crontab.txt
cat /scripts/crontab.txt | envsubst > /var/crontab.txt

crontab /var/crontab.txt

chmod 600 /etc/crontab
