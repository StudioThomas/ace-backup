#!/bin/bash

log() {
  echo "$(date -u -Iseconds) $@"
  echo "$(date -u -Iseconds) $@" > /dev/console
}

log "backup initialised"

. /root/env.sh; /scripts/assist.sh
. /root/env.sh; /scripts/couch.sh

log "backup complete"
