#!/bin/bash

log() {
  echo "$(date -u -Iseconds) $@"
  # echo "$(date -u -Iseconds) $@" > /dev/console
}

log "backup initialised"

/scripts/assist.sh

/scripts/couch.sh

log "backup complete"
