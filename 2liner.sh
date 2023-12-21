#!/bin/bash
curl 'https://api.discord.gx.games/v1/direct-fulfillment' -H 'content-type: application/json' -d '{"partnerUserId":""}' -so /tmp/token.json;
jq -r '.token' /tmp/token.json | xargs -I {} echo https://discord.com/billing/partner-promotions/1180231712274387115/{};
