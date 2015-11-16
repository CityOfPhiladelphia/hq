#!/bin/bash

echo 'Setting up SSH access'
openssl aes-256-cbc -K $encrypted_16a3424d8998_key -iv $encrypted_16a3424d8998_iv -in .travis/philagov2.pem.enc -out ~/.ssh/philagov2.pem -d
chmod 400 ~/.ssh/philagov2.pem
cat >> ~/.ssh/config <<EOF
Host target
  User ubuntu
  HostName $IP
  IdentityFile ~/.ssh/philagov2.pem
EOF
ssh-keyscan $IP >> ~/.ssh/known_hosts 2> /dev/null
