divert(-1)
define(`src',`[$1]($1)')
define(`kofjs',`src(kof.js)')
define(`Hmht', `hm.html')
define(`hmht', `src(Hmht)')
define(`Hmq',  `hm.q')
define(`hmq',  `src(Hmq)')
define(`appjson',`src(app.json)')
define(`ti',    changequote([,])[changequote([,])`$1`changequote(`,')]changequote(`,'))
define(`_c',changequote([,])[changequote([,])
```
changequote(`,')]changequote(`,'))
define(`NAME',`kdb-openfin')
define(`name',`*NAME*')
divert(1)

# Introduction
name (or *openfink*, *kdb+openfin*, *kopenfin*) 
 is a bridge between [openfin](http://openfin.co/) and kdb+ using pub+sub.  It includes a demo showing an HTML5 app running in openfin, using pub+sub.

## Contents
More precisely, name contains:
 - kofjs - an openfin headless app that bridges kdb+ and openfin pub+sub
   - listens for openfin IAB subs and forwards these to kdb over a Websocket
   - listens for kdb+ pubs and publishes to the openfin IAB
   - [option] kdb+ requests sub on IAB and kofjs sends any matching pubs
 - hmht hmq - an example HTML5 heatmap on localhost with 2 modes of operation selected from the window:
   - *Websocket* directly subscribes to kdb+
   - *openfin* subscribes to openfin
 - appjson - the configuration needed to run openfin

define(`cjs',`https://raw.githubusercontent.com/KxSystems/kdb/master/c/c.js')
# Use
Get [c.js](cjs) eg:
 _c $ curl -o c.js cjs _c

Run q on port 5000 with hmq
 _c $ q Hmq -p 5000 _c

Open hmht in a browser that supports Websocket.  eg:
 ti($ google-chrome Hmht)

## openfin 
Install ti(openfin) if not installed,
 ti($ npm install -g openfin-cli)

Run q as in the previous example, but with a timer for pub+sub
 ti($ q Hmq -p 5000 -t 100)

Run openfin with appjson 
 ti($ openfin -l -c app.json)
