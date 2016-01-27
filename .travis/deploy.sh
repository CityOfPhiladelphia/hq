#!/bin/bash

set -e

echo 'Installing AWS CLI'
cd
wget https://s3.amazonaws.com/aws-cli/awscli-bundle.zip
unzip awscli-bundle.zip
./awscli-bundle/install -b ~/bin/aws
export PATH=~/bin:$PATH
cd -

echo 'Install Joia'
curl https://raw.githubusercontent.com/CityOfPhiladelphia/joia/275ab6d7ee47e937c00c864e8fae061dd35d2d70/joia > ~/bin/joia
chmod 755 ~/bin/joia

echo 'Configuring AWS CLI'
mkdir -p ~/.aws
cat > ~/.aws/config <<EOF
[default]
aws_access_key_id = $AWS_ID
aws_secret_access_key = $AWS_SECRET
region = us-east-1
EOF

echo 'Retrieving instance ID from AWS'
export INSTANCE_ID=$(aws ec2 describe-instances --filters \
  "Name=tag:Branch,Values=$TRAVIS_BRANCH" \
  "Name=tag:Project,Values=hq" \
  --query "Reservations[0].Instances[0].InstanceId" | tr -d '"')
if [ ! "$INSTANCE_ID" ]; then
  echo "No machine found for branch \"$TRAVIS_BRANCH\". Skipping deploy" 
  exit 0
fi

echo 'Setting up SSH access'
openssl aes-256-cbc -K $encrypted_e99dd148f934_key -iv $encrypted_e99dd148f934_iv -in .travis/philagov2.pem.enc -out ~/.ssh/philagov2.pem -d
chmod 400 ~/.ssh/philagov2.pem

joia host
joia push > /dev/null
joia deploy
