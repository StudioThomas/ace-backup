#!/bin/bash

log() {
  echo "$(date -u -Iseconds) $@"
  echo "$(date -u -Iseconds) $@" > /dev/console
}

DATESTAMP=`date +%y-%m-%d`

log "couch: backup databases initialised > $DATESTAMP"

mkdir /root/couch/${DATESTAMP}

for db in $(curl -Ss ${COUCH_URL}/_all_dbs | jq -r '.[] | @uri'); do
  couchbackup --db ${db} | gzip > /root/couch/${DATESTAMP}/${db}.backup.gz
done

log "couch: backup databases complete"

log "couch: upload databases initialised > $AWS_BUCKET/$DATESTAMP"

aws s3 cp /root/couch/${DATESTAMP}/ s3://${AWS_BUCKET}/couch/${DATESTAMP}/ --recursive

rm -rf /root/couch/${DATESTAMP}

log "couch: upload databases complete"
