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
20 3 * * * /usr/local/bin/aws s3 sync s3://$PHILAGOV_MEDIA_BUCKET s3://$PHILAGOV_MEDIA_SYNC_BUCKET

# Use MYSQL_PWD instead of -p to avoid warning message
20 4 * * * MYSQL_PWD=$PHILAGOV_DB_PASS mysqldump -C -h$PHILAGOV_DB_HOST -uwp wp | /usr/local/bin/aws s3 cp - s3://$PHILAGOV_DB_BUCKET/current.sql
EOF