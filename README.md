# hq

Management machine for the city.


## Variables for EC2 setup

- KEYNAME=`ssh key name`
- AMI=`ami id`
- SUBNET=`subnet id`


## Variables for .ssh/environment

- AWS_ID=`access key ID for aws-cli`
- AWS_SECRET=`secret access key for aws-cli`
- PHILAGOV_MEDIA_BUCKET=`name of media bucket`
- PHILAGOV_MEDIA_SYNC_BUCKET=`name of media bucket to sync to`
- PHILAGOV_DB_HOST=`hostname of phila.gov database`
- PHILAGOV_DB_PASS=`password for phila.gov database`
- PHILAGOV_DB_BUCKET=`name of bucket for database dumps`
- PHILAGOV_STAGING_DB_HOST=`hostname of phila.gov staging database`


## Variables for Travis CI

- IP=`IP address for management instance`
