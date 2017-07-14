

# Introduction
`kdb-openfin` (footnote: naming convention - kdb+openfin, kopenfin, openfink) 
 is a bridge between [openfin](http://openfin.co/) and kdb+ using pub+sub.  It includes a demo showing an HTML5 app running in openfin, using pub+sub.

## Contents
More precisely, `kdb-openfin` contains:
 - [kof.js](kof.js) - an openfin headless app that bridges kdb+ and openfin pub+sub
   - listens for openfin IAB subs and forwards these to kdb over a Websocket
   - listens for kdb+ pubs and publishes to the openfin IAB
   - [option] kdb+ requests sub on IAB and [kof.js](kof.js) sends any matching pubs
 - [hm.js](hm.js) [hm.q](hm.q) - an example kdb+HTML5 heatmap on localhost (no openfin)
 - [ofhm.js](ofhm.js) [package.json](package.json) - an openfin heatmap window using [kof.js](kof.js) pub+sub on openfin plus Websocket direct to kdb+

# API
```
some code
```
