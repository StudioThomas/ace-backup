#!/bin/bash

# Ensure the following settings in /etc/ssh/sshd_config
# PermitRootLogin yes
# PasswordAuthentication yes

# echo $ASSIST_PASSWORD | sshfs -d -o sshfs_debug -o LOGLEVEL=DEBUG3 $ASSIST_USERNAME@$ASSIST_HOST:$ASSIST_DIR /mnt/assist -o password_stdin -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null
echo $ASSIST_PASSWORD | sshfs $ASSIST_USERNAME@$ASSIST_HOST:$ASSIST_DIR /mnt/assist -o password_stdin -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null

aws s3 sync /mnt/assist s3://${AWS_BUCKET}/assist

umount /mnt/assist
