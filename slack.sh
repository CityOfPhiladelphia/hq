#!/bin/bash

_dir="$(dirname "$0")"

payload=$(ssh ubuntu@$($_dir/discover.sh phila.gov production) -t "cd phila.gov; wp plugin list --update=available --format=json" | jq -c '{
    channel: "#alpha",
    username: "dingding",
    icon_emoji: ":bell:",
    text: [.[].name] | sort | @sh "Plugins with updates available: \(.)"
  }' | tr -d "'")

curl -s -XPOST --data-urlencode "payload=$payload" $1 > /dev/null
