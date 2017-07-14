divert(-1)
define(`src',`[$1]($1)')
define(`kofjs',`src(kof.js)')
define(`hmjs', `src(hm.js)')
define(`hmq',  `src(hm.q)')
define(`ofhmjs',`src(ofhm.js)')
define(`packagejson',`src(package.json)')
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
 - src(kof.js) - an openfin headless app that bridges kdb+ and openfin pub+sub
   - listens for openfin IAB subs and forwards these to kdb over a Websocket
   - listens for kdb+ pubs and publishes to the openfin IAB
   - [option] kdb+ requests sub on IAB and kofjs sends any matching pubs
 - hmjs hmq - an example kdb+HTML5 heatmap on localhost (no openfin)
 - ofhmjs packagejson - an openfin heatmap window using kofjs pub+sub on openfin plus Websocket direct to kdb+

# API
_code
some code
_code
