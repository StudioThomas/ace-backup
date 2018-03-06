#!/bin/bash

# Export all environment vars
env | sed 's/^\([a-z_]*\)=\(.*\)$//g'| sed 's/^\(.*\)=\(.*\)$/export \1=\2/g' > /root/env.sh
chmod +x /root/env.sh

# Replace vars in crontab
cat /scripts/crontab.txt | envsubst > /root/crontab.txt

# Add crontab
crontab /root/crontab.txt
chmod 600 /etc/crontab
