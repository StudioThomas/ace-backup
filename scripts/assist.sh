#!/bin/bash

log() {
  echo "$(date -u -Iseconds) $@"
  echo "$(date -u -Iseconds) $@" > /dev/console
}

if [ "$ASSIST_VOLUME" = "" ]; then
  log "assist: ASSIST_VOLUME not set"
  exit 1;
fi

if [ ! -d "$ASSIST_VOLUME" = "" ]; then
  mkdir $ASSIST_VOLUME
fi

if [ -n "$ASSIST_REMOTE_HOST" ]; then
  # Ensure the following settings in /etc/ssh/sshd_config
  # PermitRootLogin yes
  # PasswordAuthentication yes

  # echo $ASSIST_REMOTE_PASSWORD | sshfs -d -o sshfs_debug -o LOGLEVEL=DEBUG3 $ASSIST_REMOTE_USERNAME@$ASSIST_REMOTE_HOST $ASSIST_VOLUME -o password_stdin -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null
  echo $ASSIST_REMOTE_PASSWORD | sshfs $ASSIST_REMOTE_USERNAME@$ASSIST_REMOTE_HOST $ASSIST_VOLUME -o password_stdin -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null

  log "assist: remote host mounted > $ASSIST_REMOTE_HOST"
fi

log "assist: s3 sync initialised > $AWS_BUCKET"

aws s3 sync $ASSIST_VOLUME s3://${AWS_BUCKET}/assist

log "assist: s3 sync complete"

if [ -n "$ASSIST_REMOTE_HOST" ]; then
  umount $ASSIST_VOLUME

  log "assist: remote host unmounted"
fi
