#!/bin/bash

IP=$(aws ec2 describe-instances --filters \
  "Name=tag:Project,Values=$1" \
  "Name=tag:Branch,Values=$2" \
  --query "Reservations[0].Instances[0].PrivateIpAddress" | tr -d '"')

ssh-keyscan "$IP" >> ~/.ssh/known_hosts 2> /dev/null
echo -n "$IP"
