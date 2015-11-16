#!/bin/bash

echo 'Setting up SSH access'
openssl aes-256-cbc -K $encrypted_e99dd148f934_key -iv $encrypted_e99dd148f934_iv -in .travis/philagov2.pem.enc -out ~/.ssh/philagov2.pem -d
chmod 400 ~/.ssh/philagov2.pem
cat >> ~/.ssh/config <<EOF
Host target
  User ubuntu
  HostName $IP
  IdentityFile ~/.ssh/philagov2.pem
EOF
ssh-keyscan $IP >> ~/.ssh/known_hosts 2> /dev/null
