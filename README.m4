divert(-1)
define(`src',`[$1]($1)')
define(`kofjs',`src(kof.js)')
define(`Hmht', `hm.html')
define(`hmht', `src(Hmht)')
define(`Hmq',  `hm.q')
define(`hmq',  `src(Hmq)')
define(`appjson',`src(app.json)')
define(`ti',    changequote([,])[changequote([,])`$1`changequote(`,')]changequote(`,'))
define(`_code',changequote([,])[changequote([,])```changequote(`,')]changequote(`,'))
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

# Use
Run q on port 5000 with hmq
 ti($ q Hmq -p 5000)

Open hmtm in a browser that supports Websocket.  eg:
 ti($ google-chrome Hmht)

## openfin 
Run q as in the previous example, but with a timer for pub+sub
 ti($ q Hmq -p 5000 -t 100)

If ti(openfin) is not installed, install with:
 ti($ npm install -g openfin-cli)

Run openfin with the app.json 
 ti($ openfin -l -c app.json)
