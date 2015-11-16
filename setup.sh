#!/bin/bash

aws ec2 run-instances --user-data file://user-data.sh --key-name $KEYNAME \
--instance-type t2.micro --associate-public-ip-address --image-id $AMI \
--subnet-id $SUBNET
