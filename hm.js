var hmtest, hmini, hmupd, til;
(function () {
    "use strict";

    function take(x, y) {
        var r = [];
        if (x > 0) {
            r[x - 1] = 0;
            r.fill(y, 0, x);
        }
        return r;
    }
    til = (x) => take(x, 0).map((ignore, i) => i);

    function drop(x, y) {
        return x < 0 ? y.slice(0, x) : y.slice(x, y.length);
    }

    function reversed(x) {
        var r = [].concat(x).reverse();
        return r;
    }

    function fr(x, r, c) {
        x.fillStyle = c;
        x.fillRect.apply(x, r);
        return x;
    }

    function tx(x, t, p, z, c) {
        x.fillStyle = 'rgb(' + c.join() + ')';
        x.font = z + 'px sans';
        x.fillText(t, p[0], p[1]);
        return x;
    }
    var floor = Math.floor;

    function rand(x) {
        return floor(Math.random() * x);
    }
    /*the hm api requires the user to
       - hmini(name,xlabels,ylabels,colors) to name the hm and label the axes and set the palette (colors)
       - hmupd(x,y,color-index) to update the values
    */
    var G, g, p; //p is palette
    hmini = function (name, a, b, c) {
        var e = document.getElementById('canvas');
        g = e.getContext('2d'); //will throw error if no canvas in browser
        var w = e.height = e.width || 512;
        p = c.concat(['hsl(0,0%,100%)']);
        var n = a.length;
        if (n != b.length) {
            throw new Error("mismatch");
        }
        var o = [50, 70],
            rw = (w - o[0]) / n,
            rh = (w - o[1]) / n;
        G = til(n).map(function (x) {
            return til(n).map(function (y) {
                return [
                    [(x * rw) + o[0], y * rh + o[1], rw - 1, rh - 1].map(floor), p[p.length - 1]
                ];
            });
        });
        G.map(function (x) {
            x.map(function (y) {
                fr(g, y[0], y[1]);
            });
        });
        var Tx = til(n).map(function (x) {
            tx(g, a[x], [floor(x * rw) + o[0] + 10, o[1] - 10], 12, [50, 0, 100]);
        });
        var Ty = til(n).map(function (y) {
            tx(g, b[y], [10, floor(y * rh) + 10 + o[1] + 15], 12, [50, 0, 100]);
        });
        tx(g, name, [80, 30], 20, [0, 0, 0]);
    };
    hmupd = function (x, y, z) {
        fr(g, G[x][y][0], p[z]);
    };

    function cs(w) {
        return til(w).map(function (x) {
            return [x > w / 2 ? 256 / w * x : 0, 0, x <= w / 2 ? 256 / w * (x + w / 2) : 0];
        });
    }
    hmtest = function () {
        var a = "GBP USD EUR JPY CHF CAD AUD NZD".split(" "),
            n = a.length - 1;
        hmini("Currency Pair Volatility", drop(-1, a), reversed(drop(1, a)), cs(n));
        til(n).map(function (x) {
            til(n).map(function (y) {
                hmupd(x, y, rand(n));
            });
        });
    };
})();