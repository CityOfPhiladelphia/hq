#!/bin/bash

# Environment variables needed by this script should be in
# /home/ubuntu/.ssh/environment on the target machine.

set -e

echo 'Configuring AWS CLI'
mkdir -p ~/.aws
cat > ~/.aws/config <<EOF
[default]
aws_access_key_id = $AWS_ID
aws_secret_access_key = $AWS_SECRET
output = text
region = us-east-1
EOF

crontab - <<EOF
20 3 * * * /usr/local/bin/aws s3 sync s3://$PHILA_MEDIA_BUCKET s3://$PHILA_MEDIA_SYNC_BUCKET

# Use MYSQL_PWD instead of -p to avoid warning message
20 4 * * * MYSQL_PWD=$PHILA_DB_PASS mysqldump -C -h$PHILA_DB_HOST -uwp wp | /usr/local/bin/aws s3 cp - s3://$PHILA_DB_BUCKET/current.sql
30 4 * * * MYSQL_PWD=$BUSINESS_DB_PASS mysqldump -C -h$BUSINESS_DB_HOST -uwp wp | /usr/local/bin/aws s3 cp - s3://$PHILA_DB_BUCKET/business.sql

# Commented out 2015-11-23 because kdemi needs to keep changes on staging for a few days
#50 4 * * * /usr/local/bin/aws s3 cp s3://$PHILA_DB_BUCKET/current.sql - | MYSQL_PWD=$PHILA_DB_PASS mysql -h$PHILA_STAGING_DB_HOST -uwp wp
EOF
