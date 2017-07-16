var kof;
(function(){ "use strict";
 kof.connect=function(x)
 {if("fin"       in window) openfin();   else
  if("Websocket" in window) wsconnect(); else
 }
})();
