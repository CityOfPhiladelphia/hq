#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
sudo apt-get update
sudo -E apt-get install -y mysql-client-5.6 unzip

echo 'Installing AWS CLI'
cd /tmp
wget https://s3.amazonaws.com/aws-cli/awscli-bundle.zip
unzip awscli-bundle.zip
sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
cd -

echo 'Copying .env to ~/.ssh/environment'
cp .env ~/.ssh/environment

echo 'Setting env vars for ssh deploys'
echo 'PermitUserEnvironment yes' | sudo tee -a /etc/ssh/sshd_config > /dev/null
sudo service ssh restart
