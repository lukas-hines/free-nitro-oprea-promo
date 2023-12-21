#!/bin/bash
#put your discord webhook there so all of your friends in a server can get free nitro.
#i do expect you to run this on a unix-like machine like macOS or linux
webhook=""
while true
do
	curl 'https://api.discord.gx.games/v1/direct-fulfillment' -H 'content-type: application/json' -d '{"partnerUserId":""}' -so /tmp/token.json;
 	url=$(jq -r '.token' /tmp/token.json | xargs -I {} echo https://discord.com/billing/partner-promotions/1180231712274387115/{})
  	curl -H "content-type: application/json" -d "{\"content\": \"${url}\"}" $webhook
done
