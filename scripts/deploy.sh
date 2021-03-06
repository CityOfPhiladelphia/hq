#!/bin/bash

set -e

echo 'Setting crontab'
crontab - <<EOF
PATH=$HOME/app/scripts:$PATH

20 3 * * * /usr/local/bin/aws s3 sync s3://$PHILA_MEDIA_BUCKET s3://$PHILA_MEDIA_SYNC_BUCKET

# Use MYSQL_PWD instead of -p to avoid warning message
20 4 * * * MYSQL_PWD=$PHILA_DB_PASS mysqldump -C -h$PHILA_DB_HOST -uwp wp | /usr/local/bin/aws s3 cp - s3://$PHILA_DB_BUCKET/current.sql
30 4 * * * MYSQL_PWD=$BUSINESS_DB_PASS mysqldump -C -h$BUSINESS_DB_HOST -uwp wp | /usr/local/bin/aws s3 cp - s3://$PHILA_DB_BUCKET/business.sql
40 4 * * * MYSQL_PWD=$MICROSITES_DB_PASS mysqldump -C -h$MICROSITES_DB_HOST -uwp wp | /usr/local/bin/aws s3 cp - s3://$PHILA_DEPLOY_BUCKET/microsites/current.sql

10 11 * * * slack.sh $SLACK_HOOK
EOF
