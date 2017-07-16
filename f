@README.md
divert(-1)dnl
define(`Lsrc',`[$1]($1)')
define(`kofjs',`Lsrc(kof.js)')
define(`Ixht', `index.htm')
define(`Hmht', `hm.htm')
define(`ixht', `Lsrc(Ixht)')
define(`hmht', `Lsrc(Hmht)')
define(`Hmq',  `hm.q')
define(`hmq',  `Lsrc(Hmq)')
define(`appjson',`Lsrc(app.json)')
define(`ti',    changequote([,])[changequote([,])`$1`changequote(`,')]changequote(`,'))
define(`_c',changequote([,])[changequote([,])```
changequote(`,')]changequote(`,'))
define(`nl',`
')
define(`_C',`nl _c')
define(`NAME',`kdb-openfin')
define(`Name',`*NAME*')
define(`iab',`[IAB](http://cdn.openfin.co/jsdocs/stable/fin.desktop.InterApplicationBus.html)')
divert(1)dnl
# Introduction
Name (or *openfink*, *kdb+openfin*, *kopenfin*) 
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
_c$ curl -o c.js cjs _C
Run q on port 5000 with hmq.  openfin needs the q webserver and openfin apps need Websocket server.

The one second timer (ti(-t 1000)) is for pub+sub
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
@index.htm
<!--script src="kof.js"></script-->
<script>
L=function(x){return console.log(x);}

function hm()
{ g.loginWindow = new fin.desktop.Window({
    name: "hm",
    url: "hm.htm",
    defaultWidth: 512,
    defaultHeight: 512,
    frame: false,
    resize: false,
    autoShow: true,
}, () => { L("The window has successfully been created"); },
   () => { L("Error creating window"); });
}
</script>
@hm.htm
<html><head><title>fsb</title>
<style type="text/css">canvas{}</style>
<script type="text/javascript">
function take(x,y){var r=[];if(x>0){r[x-1]=0;r.fill(y,0,x);}return r;}
function til(x){var r=[];return take(x,0).map(function(v,i,a){return i;});}
function sho(x){console.log(x);return x;}
R=Math.round;F=Math.floor;
function fr(x,r,c){x.fillStyle='rgb('+c.map(R).join()+')';x.fillRect.apply(x,r);return x;}
function tx(x,t,p,z,c){x.fillStyle='rgb('+c.join()+')';x.font=z+'px sans';x.fillText(t,p[0],p[1]);return x;}
function cs(n){return til(n).map(function(x){return[x>n/2?256/n*x:0,0,x<=n/2?256/n*(x+n/2):0];});}
function rani(x){return F(Math.random()*x);}
function rand(x){return x[rani(x.length)];}
function draw(){
  var u="GBP USD EUR JPY CHF CAD AUD NZD".split(" "),c=document.getElementById('canvas');
  if(c.getContext){
   var g=c.getContext('2d');
   var w=512;c.width=w;c.height=w;
   var n=u.length;var o=[50,70];var rw=(w-o[0])/n,rh=(w-o[1])/n;
   var v=cs(5);
   var G=til(n).map(function(x){return til(n).map(function(y){var X=n-x-1;return X>y?[rand(v),F(x*rw)+o[0],F(y*rh+o[1]),F(rw-1),F(rh-1)]:[];})});
   G.map(function(x){x.map(function(y){y.length?fr(g,y.slice(1),y[0]):0;})});
   var Tx=til(n-1).map(function(x){tx(g,u[x],[F(x*rw)+o[0]+10,o[1]-10],12,[50,0,100]);});
   var Ty=til(n-1).map(function(y){tx(g,u[n-1-y],[10,F(y*rh)+10+o[1]+15],12,[50,0,100]);});
   tx(g,"Currency Pair Volatility",[80,30],20,[0,0,0]);
}}
/*
//define onpub for both websocket and openfin
var onpub;
document.addEventListener("DOMContentLoaded", function(){ init(); });
function openfin()
{
}
function wsconnect()
{if ("WebSocket" in window)
 {var l=window.location,ws=new WebSocket("ws://"+(l.hostname||"localhost")+":"+(l.port||"5000")+"/");function wL(x){console.Log(x);}
  wL("connecting...");
  ws.onopen=function(e){wL("connected");} ws.onclose=function(e){wL("disconnected");} ws.onmessage=function(e){wL(e.data);} ws.onerror=function(e){wL(e.data);}
  return ws;
 }else return 0;
}
function openfin(){fin.desktop.main(()=>(return 1;))}
function init()
{if("fin"       in window) openfin();   else
 if("Websocket" in window) wsconnect(); else
 fail()
}
*/
</script></head>

<body onload="draw();"><canvas id="canvas"></canvas></body>
</html>
@hm.q
.h.HOME:first system"pwd"
@s.sh
rm -rI public tmpl.zip
curl http://cdn.openfin.co.s3-website-us-east-1.amazonaws.com/templates/OfTemplate.zip -otmpl.zip
unzip tmpl.zip
cd public
openfin -l -c app.json 
cd ..
@up
./gen && git add gen up `grep ^@ f |cut -b2-` && git commit -m 'x' && git push -u origin master
@app.json
{
    "startup_app": {
        "url": "http://localhost:5000/index.htm",
        "name": "hm",
        "uuid": "hm",
        "autoShow": true
    },
    "runtime": {
        "version": "6.49.20.22",
        "forcelatest": true,
        "arguments": ""
    },
    "shortcut": {}
}