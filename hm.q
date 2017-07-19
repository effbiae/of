call:0h
.h.HOME:0N!first system$[.z.o in`w32`w64;"cd";"pwd"]
n:5;c:`${"hsl(",string[60*m-x%m:n-1],",100%,50%)"}'[til n];a:`$" "vs"GBP USD EUR JPY CHF CAD AUD NZD"
info:{(-1_'(a;reverse a)),enlist c}
sub:{system"t 1000";.z.ts:{0N!mat`};"ok"};
mat:{sp[0N!hand]0N!((n;n)#(n*n)?4)*not (max[x]-x)<\:x:til n:count[a]-1}
prot:{@[{(1;0N!x)};x;(0;)]}
send:{neg[x]{0N!"sending ",-9!x;x} -8!y}
sp:{send[x]prot 0N!y}
.z.wo:{0N!call+::1;0N!hand::x}
.z.ws:{0N!neg call+::1;sp[0N!.z.w]value 0N!-9!x}
/.z.wc: .z.ws: .z.ts
