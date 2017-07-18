var ofcon, opub, wscon, wsset, wsget, wsclo, wshot;
(function () {
    "use strict";

    function L(x) {
        console.log(x);
    }
    wsset = function (w, x, f, g) {
        w.onmessage = xx => {
            var d = deserialize(xx.data);
            if (d[0]) f(d[1]);
            else g(d[1]);
        };
        w.onerror = g;
        return w.send(serialize(x));
    };
    wscon = function (h, p) {
        return new Promise(function (f, g) {
            var w = new WebSocket("ws://" + h + ":" + p + "/");
            w.binaryType = "arraybuffer";
            w.onopen = () => f(w);
            w.onerror = g;
        });
    };
    wsget = function (w, x) {
        return new Promise((f, g) => wsset(w, x, f, g));
    };
    wshot = function (h, p, x) {
        return new Promise((f, g) => wscon(h, p).then(w => wsget(w, x).then(x => {
            wsclo(w);
            f(x);
        })).catch(g));
    };
    wsclo = function (w) {
        w.close();
    };
    ofcon = function (x) {
        if ("fin" in window) openfin();
        else wscon(L);
    };
})();