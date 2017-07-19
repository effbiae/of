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
