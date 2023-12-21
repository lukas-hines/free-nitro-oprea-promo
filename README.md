# free discord nitro! 100% real
oprea gx ran a promo where any one can get a free discord nitro for using oprea gx.

just like many company promos, useser love to exploit them. so i went digging to see what type of free loot we can gain.

## the story
I didnt want to download spyware on my computer so the first thing i tried was using a [user agent switcher](https://addons.mozilla.org/en-US/firefox/addon/user-agent-string-switcher/)
this seemed to work untill i clicked the button and i was not given a nitro. i check thed consol and it nicely enough took me right to the line where nitro was being genarated.

but first the thing that gave me a error was the javascript was trying to call opreagx functions to genarate a uniqe ID from my browser. (most likely to track a user)

so i just ignored it and went to look at the more juicy stuff.
```javascript
this.DISCORD_API_URL = 'https://api.discord.gx.games/v1/direct-fulfillment'

const t = await fetch(
              this.DISCORD_API_URL,
              {
                method: 'POST',
                headers: {
                  'Content-Type': 'application/json'
                },
                body: JSON.stringify(e)
              }
            );
```
so this nifty fetch request calls the oprea gx rest api that genarates a discord token. it requres just a body that has "partnerUserId"

well it turns out this "partnerUserId" is just useless but you need to at least present it in the api call. if you leave it out it will just complain saying "partner-user-id-missing"

```javascript
this.generateUUID = () => 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(
          /[xy]/g,
          (
            function (t) {
              const e = 16 * Math.random() | 0;
              return ('x' === t ? e : 3 & e | 8).toString(16)
            }
          )
        ),
```
this would have been the "partnerUserId" but you can leave it blank in the rest call and it works fine.


## how to use

you will need
- bash
- [jq](https://github.com/jqlang/jq)

after that you can run the bash script in this repo or just paste this into ur bash prompt.

```bash 
curl 'https://api.discord.gx.games/v1/direct-fulfillment' -H 'content-type: application/json' -d '{"partnerUserId":""}' -so /tmp/token.json;
jq -r '.token' /tmp/token.json | xargs -I {} echo https://discord.com/billing/partner-promotions/1180231712274387115/{};
```

running this to much will cause a rate limit and you would need a new ip. running this thu torsocks seemed to work for me.

using/abusing this might be get you banned. i have not read into anything on what you are and are not allowed to do
