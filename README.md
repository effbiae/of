# Introduction
*kdb-openfin* (or *openfink*, *kdb+openfin*, *kopenfin*) 
 is a bridge between [Openfin](http://openfin.co/) and kdb+ using pub+sub.  It includes a demo showing an HTML5 app running in Openfin, using pub+sub.

## Contents
 - A bridge bewteen Openfin and kdb+  ([ws.js](ws.js), [kof.js](kof.js))
   - uses a Websocket to kdb+
   - finds available subscriptions in kdb+, publishes symbols on topic "k"
   - listens for Openfin IAB subs and forwards these to kdb over a Websocket
   - listens for kdb+ pubs and publishes to the Openfin IAB
   - [option] kdb+ requests sub on IAB and [kof.js](kof.js) sends any matching pubs
 - HTML5 canvas heat map demo with kdb+ ([hm.htm](hm.htm), [hm.js](hm.js), [hm.q](hm.q), [ws.js](ws.js))
   - hosted locally using kdb+ server for http and Websocket
 - An example Openfin site using the heat map demo ([index.htm](index.htm), [app.json](app.json))
   - an Openfin headless app that opens [hm.htm](hm.htm)
   - [index.htm](index.htm) uses [kof.js](kof.js) to interface Openfin
   - [hm.htm](hm.htm) uses the [IAB](http://cdn.openfin.co/jsdocs/stable/fin.desktop.InterApplicationBus.html) rather than a Websocket to get heat values

## Background

 [openfin/app-bootstrap](https://github.com/openfin/app-bootstrap)

# Use
Get [c.js](https://raw.githubusercontent.com/KxSystems/kdb/master/c/c.js) eg. 
```
$ curl -o c.js https://raw.githubusercontent.com/KxSystems/kdb/master/c/c.js 
 ```

Run q on port 5000 with [hm.q](hm.q).  Openfin needs the q webserver and Openfin apps need Websocket server.

The one second timer (`-t 1000`) is for pub+sub
```
$ q hm.q -p 5000 -t 1000 
 ```

Open [hm.htm](hm.htm) in a browser that supports Websocket.  eg.
```
$ google-chrome http://localhost:5000/hm.htm 
 ```

## Of 
Install `Openfin` if not installed
```
$ npm install -g openfin-cli 
 ```

Run q as in the previous example (if not still running)
```
$ q hm.q -p 5000 -t 1000 
 ```

Run Openfin with [app.json](app.json) 
```
$ openfin -l -c app.json 
 ```

