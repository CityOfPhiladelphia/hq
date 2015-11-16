#!/bin/bash

set -e

echo 'Syncing to target machine'
rsync -rzp --delete --exclude=".*" --delete-excluded ./ target:hq

echo 'Executing deploy in app directory on target'
ssh target 'cd hq && ./deploy.sh'
