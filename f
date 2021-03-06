@README.md
divert(-1)dnl
define(`H1',`# $1')
define(`H2',`## $1')
define(`Lsrc',`[$1]($1)')
define(`kofjs',`Lsrc(kof.js)')
define(`hmjs',`Lsrc(hm.js)')
define(`Ixht', `index.htm')
define(`Hmht', `hm.htm')
define(`Get',  `Lsrc(get)')
define(`ixht', `Lsrc(Ixht)')
define(`hmht', `Lsrc(Hmht)')
define(`Hmq',  `hm.q')
define(`hmq',  `Lsrc(Hmq)')
define(`POrt', `5000')
define(`appjson',`Lsrc(app.json)')
define(`ti',    changequote([,])[changequote([,])`$1`changequote(`,')]changequote(`,'))
define(`_c',changequote([,])[changequote([,])```
changequote(`,')]changequote(`,'))
define(`nl',`
')
define(`_C',`nl _c')
define(`NAME',`kof')
define(`Of',`Openfin')
define(`Name',`*NAME*')
define(`iab',`[IAB](http://cdn.openfin.co/jsdocs/stable/fin.desktop.InterApplicationBus.html)')
divert(1)dnl
H1(NAME)
Name is a bridge between [Of](http://openfin.co/) and kdb+ using pubsub.  It includes an HTML5 heat map widget running in Of.

H2(Requirements)
 - kdb+ v3.3 or later (for .z.wo)
 - Node npm (to install openfin)

H2(Overview)
 - Name is a bridge between Of and kdb+  (kofjs)
   - uses a Websocket to kdb+
   - finds subscriptions provided by kdb+, publishes those names to the Of iab (topic "k")
   - listens for Of IAB subs and forwards these to kdb over a Websocket
   - listens for kdb+ pubs and publishes to the Of IAB
   - [option] kdb+ requests sub on IAB and kofjs sends any matching pubs
 - HTML5 canvas heat map demo on Of with kdb+  (ixht, kofjs, appjson, hmht, hmjs, hmq)
   - an Of headless [app](app.json) that loads ixht.
   - ixht creates an Of window for hmht 
   - hosted locally using kdb+ server for http and Websocket
   - ixht uses kofjs to interface Of iab


 [openfin/app-bootstrap](https://github.com/openfin/app-bootstrap)

define(`cjs',`https://raw.githubusercontent.com/KxSystems/kdb/master/c/c.js')dnl
define(`uq', `https://raw.githubusercontent.com/KxSystems/kdb-tick/master/tick/u.q')dnl
H1(Gettting Started)
Kx libraries required:
 - [c.js](cjs)
 - [u.q](uq)

on unix, use the Get script:
_c$ . get _C

Install Of if not installed
_c$ npm install -g openfin-cli _C

Run q on port POrt with hmq.
  - Of needs the kdb+ http httpserver to deliver ixht
  - Of apps (in this case, the heat map demo) need the kdb+ Websocket server.

The one second timer (ti(-t 1000)) is for pubsub
_c$ q Hmq -p POrt -t 1000 _C

Run Of with appjson 
_c$ openfin -l -c app.json _C

![Heat map](hm.png)*NB still random and contradictory*

@index.htm
<html><head><title>openfin headless</title>
<script src="c.js"></script>
<script src="kof.js"></script>
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
document.addEventListener("DOMContentLoaded",hm);
</script></head><body></body></html>
@hm.js
define(`_',`ignore')dnl
var hmtest,hmini,hmupd,til;
(function(){ "use strict";
 function take(x,y){var r=[];if(x>0){r[x-1]=0;r.fill(y,0,x);}return r;}
 til=(x)=>take(x,0).map((_,i)=>i);
 function drop(x,y){return x<0?y.slice(0,x):y.slice(x,y.length);}
 function reversed(x){var r=[].concat(x).reverse();return r;}
 function fr(x,r,c){x.fillStyle=c;x.fillRect.apply(x,r);return x;}
 function tx(x,t,p,z,c){x.fillStyle='rgb('+c.join()+')';x.font=z+'px sans';x.fillText(t,p[0],p[1]);return x;}
 var floor=Math.floor;
 function rand(x){return floor(Math.random()*x);}
 /*the hm api requires the user to
    - hmini(name,xlabels,ylabels,colors) to name the hm and label the axes and set the palette (colors)
    - hmupd(x,y,color-index) to update the values
 */
 var G,g,p; //p is palette
 hmini=function(name,a,b,c){
   var e=document.getElementById('canvas');g=e.getContext('2d');//will throw error if no canvas in browser
   var w=e.height=e.width||512;
   p=c.concat(['hsl(0,0%,100%)']);
   var n=a.length;if(n!=b.length){throw new Error("mismatch");}var o=[50,70],rw=(w-o[0])/n,rh=(w-o[1])/n;
   G=til(n).map(function(x){return til(n).map(function(y){return [[(x*rw)+o[0],y*rh+o[1],rw-1,rh-1].map(floor),p[p.length-1]];});});
   G.map(function(x){x.map(function(y){fr(g,y[0],y[1]);});});
   var Tx=til(n).map(function(x){tx(g,a[x],[floor(x*rw)+o[0]+10,o[1]-10],12,[50,0,100]);});
   var Ty=til(n).map(function(y){tx(g,b[y],[10,floor(y*rh)+10+o[1]+15],12,[50,0,100]);});
   tx(g,name,[80,30],20,[0,0,0]);
 };
 hmupd=function(x,y,z){fr(g,G[x][y][0],p[z]);};
 function cs(w){return til(w).map(function(x){return[x>w/2?256/w*x:0,0,x<=w/2?256/w*(x+w/2):0];});}
 hmtest=function(){
   var a="GBP USD EUR JPY CHF CAD AUD NZD".split(" "),n=a.length-1;
   hmini("Currency Pair Volatility",drop(-1,a),reversed(drop(1,a)),cs(n));
   til(n).map(function(x){til(n).map(function(y){hmupd(x,y,rand(n));});});
 };
})();
undefine(`_')dnl
@hm.htm
changequote(<<,>>)dnl
<html><head><title>Openfin Heat Map Demo</title>
<script src="c.js"></script>
<script src="kof.js"></script>
<script src="hm.js"></script>
<script>
function run(){ "use strict";
 function upd(u) {
   if(u=='ok') return;//first time
   til(u.length).map(function(y){return til(u[y].length).map(function(x){return hmupd(x,y,u[x][y]);});});
 }
 var l=window.location,h=l.hostname||"localhost",p=l.port||"POrt";
 function L(x){
  return Promise.resolve(console.log(x));
 }
 wshot(h,p,"til 6").then(L)
 .then(()=>wshot(h,p,"info`").then(x=>{hmini("<<Name>>",x[0],x[1],x[2]);return L(x)}))
 .then(()=>wscon(h,p).then(x=>wsset(x,'sub`',upd,L))).catch(L);
}
document.addEventListener("DOMContentLoaded",run);
</script>
<body><canvas id="canvas" width="512"></canvas></body></html>
@hm.q
call:0h
.h.HOME:0N!first system$[.z.o in`w32`w64;"cd";"pwd"]
C:5;c:`${"hsl(",string[60*x],",100%,50%)"}'[til C];a:`$" "vs"GBP USD EUR JPY CHF CAD AUD NZD"
info:{(-1_'(a;reverse a)),enlist c}
sub:{system"t 1000";.z.ts:mat;"ok"};
mat:{sp[h]0N!((n;n)#(n*n)?5)|C*t:(n-x+1)<\:x:til n:count[a]-1}
prot:{@[{(1;x)};x;(0;)]}
send:{neg[x] -8!y}
sp:{send[x]prot y}
.z.wo:{call+::1;h::x}
.z.ws:{neg call+::1;sp[0N!.z.w]value 0N!-9!x}
/.z.wc: .z.ws: .z.ts
changequote(`,')dnl
@kof.js
var ofcon,opub,wscon,wsset,wsget,wsclo,wshot;
(function(){ "use strict";
  function L(x){console.log(x);}
  wsset=function(w,x,f,g){ 
   w.onmessage=xx=>{var d=deserialize(xx.data);if(d[0])f(d[1]);else g(d[1]);};
   w.onerror=g;
   return w.send(serialize(x));};
  wscon=function(h,p){return new Promise(function(f,g){
    var w=new WebSocket("ws://"+h+":"+p+"/");w.binaryType="arraybuffer";
    w.onopen=()=>f(w);w.onerror=g;
  });};
  wsget=function(w,x){return new Promise((f,g)=>wsset(w,x,f,g));};
  wshot=function(h,p,x){return new Promise((f,g)=>wscon(h,p).then(w=>wsget(w,x).then(x=>{wsclo(w);f(x);})).catch(g));};
  wsclo=function(w){w.close();};
  ofcon=function(x)
  {if("fin"       in window) openfin();
   else wscon(L);
  };
})();
@.jshintrc
{ "esversion": 6 }
@s.sh
rm -rI public tmpl.zip
curl http://cdn.openfin.co.s3-website-us-east-1.amazonaws.com/templates/OfTemplate.zip -otmpl.zip
unzip tmpl.zip
cd public
openfin -l -c app.json 
cd ..
@app.json
{
    "startup_app": { "url": "http://localhost:POrt/index.htm", "name": "hm", "uuid": "hm", "autoShow": true },
    "runtime": { "version": "6.49.20.22", "forcelatest": true, "arguments": "" },
    "shortcut": {}
}
@get
rm -f u.q c.js
wget uq
wget cjs
@u
make && git add makefile ti(grep ^@ f |cut -b2-) && git commit -m 'x' && git push -u origin master
