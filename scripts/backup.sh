#!/bin/bash

log() {
  echo "$(date -u -Iseconds) $@"
  echo "$(date -u -Iseconds) $@" > /dev/console
}

log "backup initialised $BACKUP_HOUR:$BACKUP_MINUTE"

. /scripts/assist.sh

. /scripts/couch.sh

log "backup complete"
