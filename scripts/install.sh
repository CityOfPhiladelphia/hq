#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
sudo apt-get update
sudo -E apt-get install -y jq mysql-client-5.6 unzip

echo 'Installing AWS CLI'
cd /tmp
wget https://s3.amazonaws.com/aws-cli/awscli-bundle.zip
unzip awscli-bundle.zip
sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
cd -

echo 'Configuring AWS CLI'
mkdir -p ~/.aws
cat > ~/.aws/config <<EOF
[default]
aws_access_key_id = $AWS_ID
aws_secret_access_key = $AWS_SECRET
region = us-east-1
EOF

echo 'Getting key for accessing other machines'
aws s3 cp s3://phila-deploy/hq/id_rsa ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa
