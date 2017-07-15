divert(-1)
define(`src',`[$1]($1)')
define(`kofjs',`src(kof.js)')
define(`Ixht', `index.htm')
define(`Hmht', `hm.htm')
define(`ixht', `src(Ixht)')
define(`hmht', `src(Hmht)')
define(`Hmq',  `hm.q')
define(`hmq',  `src(Hmq)')
define(`appjson',`src(app.json)')
define(`ti',    changequote([,])[changequote([,])`$1`changequote(`,')]changequote(`,'))
define(`_c',changequote([,])[changequote([,])```
changequote(`,')]changequote(`,'))
define(`L',`
')
define(`_C',`L _c')
define(`NAME',`kdb-openfin')
define(`name',`*NAME*')
define(`iab',`[IAB](http://cdn.openfin.co/jsdocs/stable/fin.desktop.InterApplicationBus.html)')
divert(1)
# Introduction
name (or *openfink*, *kdb+openfin*, *kopenfin*) 
 is a bridge between [openfin](http://openfin.co/) and kdb+ using pub+sub.  It includes a demo showing an HTML5 app running in openfin, using pub+sub.

## Contents
 - hmht, hmq - an example HTML5 heatmap on localhost using Websocket
 - kofjs - bridges openfin's iab and kdb+ pub+sub using Websocket
   - finds available subscriptions in kdb+, publishes symbols on topic "k"
   - listens for openfin IAB subs and forwards these to kdb over a Websocket
   - listens for kdb+ pubs and publishes to the openfin iab
   - [option] kdb+ requests sub on IAB and kofjs sends any matching pubs
 - ixht, appjson - an openfin headless app that opens hmht
   - ixht uses kofjs to interface to the iab
   - hmht uses the IAB rather than a Websocket to get heat

## Background

 [openfin/app-bootstrap](https://github.com/openfin/app-bootstrap)

define(`cjs',`https://raw.githubusercontent.com/KxSystems/kdb/master/c/c.js')dnl
# Use
Get [c.js](cjs) eg. 
_c$ curl -o c.js cjs L _c
Run q on port 5000 with hmq.  openfin needs the q webserver and openfin apps need Websocket server.
The one second timer is for pub+sub
_c$ q Hmq -p 5000 -t 1000 _C
Open hmht in a browser that supports Websocket.  eg.
_c$ google-chrome http://localhost:5000/Hmht _C
## openfin 
Install ti(openfin) if not installed
_c$ npm install -g openfin-cli _C
Run q as in the previous example (if not still running)
_c$ q Hmq -p 5000 -t 1000 _C
Run openfin with appjson 
_c$ openfin -l -c app.json _C
