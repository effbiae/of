/*
**  maybe send([n,x]) and buffer responses until message matching [n,...] is sent
*/
var wscon,wsset,wsget;
(function(){
  function L(x){console.log(x);}
  wsset=function(w,x,f,g){w.onmessage=f;w.onerror=g;return w.send(x);};
  wscon=function(f)
  {var l=window.location,w=new WebSocket("ws://"+(l.hostname||"localhost")+":"+(l.port||"5000")+"/");
   f("connecting...");w.onopen=f;w.onclose=f;return w;
  };
  wsget=function(w,x){return new Promise((f,g)=>{wsset(w,x,f,g)});};
 }
})();
