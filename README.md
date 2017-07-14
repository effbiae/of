

# Introduction
*kdb-openfin* (or *openfink*, *kdb+openfin*, *kopenfin*) 
 is a bridge between [openfin](http://openfin.co/) and kdb+ using pub+sub.  It includes a demo showing an HTML5 app running in openfin, using pub+sub.

## Contents
More precisely, *kdb-openfin* contains:
 - [kof.js](kof.js) - an openfin headless app that bridges kdb+ and openfin pub+sub
   - listens for openfin IAB subs and forwards these to kdb over a Websocket
   - listens for kdb+ pubs and publishes to the openfin IAB
   - [option] kdb+ requests sub on IAB and [kof.js](kof.js) sends any matching pubs
 - [hm.html](hm.html) [hm.q](hm.q) - an example HTML5 heatmap on localhost with 2 modes of operation selected from the window:
   - *Websocket* directly subscribes to kdb+
   - *openfin* subscribes to openfin
 - [app.json](app.json) - the configuration needed to run openfin

# Use
Run q on port 5000 with [hm.q](hm.q)
 `$ q hm.q -p 5000`

Open hmtm in a browser that supports Websocket.  eg:
 `$ google-chrome hm.html`

## openfin 
Run q as in the previous example, but with a timer for pub+sub
 `$ q hm.q -p 5000 -t 100`

If `openfin` is not installed, install with:
 `$ npm install -g openfin-cli`

Run openfin with the app.json 
 `$ openfin -l -c app.json`
