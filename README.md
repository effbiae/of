# Introduction
*kdb-openfin* (or *openfink*, *kdb+openfin*, *kopenfin*) 
 is a bridge between [openfin](http://openfin.co/) and kdb+ using pub+sub.  It includes a demo showing an HTML5 app running in openfin, using pub+sub.

## Contents
 - [hm.htm](hm.htm), [hm.q](hm.q) - an example HTML5 heatmap on localhost using Websocket
 - [kof.js](kof.js) - bridges openfin's [IAB](http://cdn.openfin.co/jsdocs/stable/fin.desktop.InterApplicationBus.html) and kdb+ pub+sub using Websocket
   - finds available subscriptions in kdb+, publishes symbols on topic "k"
   - listens for openfin IAB subs and forwards these to kdb over a Websocket
   - listens for kdb+ pubs and publishes to the openfin [IAB](http://cdn.openfin.co/jsdocs/stable/fin.desktop.InterApplicationBus.html)
   - [option] kdb+ requests sub on IAB and [kof.js](kof.js) sends any matching pubs
 - [index.htm](index.htm), [app.json](app.json) - an openfin headless app that opens [hm.htm](hm.htm)
   - [index.htm](index.htm) uses [kof.js](kof.js) to interface to the [IAB](http://cdn.openfin.co/jsdocs/stable/fin.desktop.InterApplicationBus.html)
   - [hm.htm](hm.htm) uses the IAB rather than a Websocket to get heat

## Background

 [openfin/app-bootstrap](https://github.com/openfin/app-bootstrap)

# Use
Get [c.js](https://raw.githubusercontent.com/KxSystems/kdb/master/c/c.js) eg. 
```
$ curl -o c.js https://raw.githubusercontent.com/KxSystems/kdb/master/c/c.js 
 ```

Run q on port 5000 with [hm.q](hm.q).  openfin needs the q webserver and openfin apps need Websocket server.

The one second timer (`-t 1000`) is for pub+sub
```
$ q hm.q -p 5000 -t 1000 
 ```

Open [hm.htm](hm.htm) in a browser that supports Websocket.  eg.
```
$ google-chrome http://localhost:5000/hm.htm 
 ```

## openfin 
Install `openfin` if not installed
```
$ npm install -g openfin-cli 
 ```

Run q as in the previous example (if not still running)
```
$ q hm.q -p 5000 -t 1000 
 ```

Run openfin with [app.json](app.json) 
```
$ openfin -l -c app.json 
 ```

