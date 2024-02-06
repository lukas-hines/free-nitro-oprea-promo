# free discord nitro! 100% real
Opera GX ran a promo where anyone can get a free discord nitro for using Opera GX.

Just like many company promos, users love to exploit them. So I went digging to see what type of free loot we can gain.

## the story
I didn't want to download spyware on my computer, so the first thing I tried was using a [user agent switcher](https://addons.mozilla.org/en-US/firefox/addon/user-agent-string-switcher/)
this seemed to work until I clicked the button, and I was not given a nitro. I check the console, and it nicely enough took me right to the line where nitro was being generated.

But first, the thing that gave me an error was the JavaScript was trying to call Opera GX functions to generate a unique ID from my browser. (most likely to track a user)

so I just ignored it and went to look at the more juicy stuff.
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
So this nifty fetch request calls the Opera GX rest API that generates a discord token. It requires just a body that has "partnerUserId"

Well, it turns out this "partnerUserId" is just useless, but you need to at least present it in the API call. If you leave it out it will just complain saying "partner-user-id-missing"

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
This would have been the "partnerUserId" but you can leave it blank in the rest call and it works fine.


## how to use

you will need
- bash
- [jq](https://github.com/jqlang/jq)

after that you can run the bash script in this repo or just paste this into your bash prompt.

```bash 
curl 'https://api.discord.gx.games/v1/direct-fulfillment' -H 'content-type: application/json' -d '{"partnerUserId":""}' -so /tmp/token.json;
jq -r '.token' /tmp/token.json | xargs -I {} echo https://discord.com/billing/partner-promotions/1180231712274387115/{};
```

Running this too much will cause a rate limit, and you would need a new IP. running this through torsocks seemed to work for me.

Using/abusing this might get you banned. I have not read into anything on what you are and are not allowed to do.
