var kof,wscon,wsset,wsget,wsclo;
(function(){ "use strict";
  function L(x){console.log(x);}
  wsset=function(w,x,f,g){w.onmessage=f;w.onerror=g;return w.send(x);};
  wscon=function(f)
  {var l=window.location,w=new WebSocket("ws://"+(l.hostname||"localhost")+":"+(l.port||"5000")+"/");
   f("connecting...");w.onopen=f;w.onclose=f;return w;
  };
  wsget=function(w,x){return new Promise((f,g)=>{wsset(w,x,f,g)});};
  wsclo=function(w){w.close();}
 }
 kofcon=function(x)
 {if("fin"       in window) openfin();
  else wscon(L);
 }
})();
