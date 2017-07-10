#!/bin/bash

if [ -n "$ASSIST_REMOTE_HOST" ]; then
  # Ensure the following settings in /etc/ssh/sshd_config
  # PermitRootLogin yes
  # PasswordAuthentication yes

  # echo $ASSIST_REMOTE_PASSWORD | sshfs -d -o sshfs_debug -o LOGLEVEL=DEBUG3 $ASSIST_REMOTE_USERNAME@$ASSIST_REMOTE_HOST /mnt/assist -o password_stdin -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null
  echo $ASSIST_REMOTE_PASSWORD | sshfs $ASSIST_REMOTE_USERNAME@$ASSIST_REMOTE_HOST /mnt/assist -o password_stdin -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null
fi

aws s3 sync /mnt/assist s3://${AWS_BUCKET}/assist

umount /mnt/assist
