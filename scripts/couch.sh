#!/bin/bash

DATESTAMP=`date +%y-%m-%d`

mkdir /couch/${DATESTAMP}

for db in $(curl -Ss ${COUCH_URL}/_all_dbs | jq -r '.[] | @uri'); do
  couchbackup --db ${db} | gzip > /couch/${DATESTAMP}/${db}.backup.gz
done

aws s3 cp /couch/${DATESTAMP}/ s3://${AWS_BUCKET}/couch/${DATESTAMP}/ --recursive

rm -rf /couch/${DATESTAMP}
