% Programmed by Carlos Montilla
int: f;
int: g;
int: c;
int: k;
set of int: Cap = 0..k;
int: t;
set of int: Trips = 1..t;
int: pf;
int: pg;
int: pc;

array[Trips] of var Cap: fox;
array[Trips] of var Cap: geese;
array[Trips] of var Cap: corn;
var 0..t: trips;

var int: obj;

%%%%%%%%%%%%%%%%%%%%%%%%%%% ADD constraints in here %%%%%%%%%%%%%


%%%%%%%%%%%%%%%%% you may want to modify the search strategy below

solve maximize obj;


output ["  fox = ", show(fox),
     ";\ngeese = ", show(geese),
     ";\n corn = ", show(corn),
     ";\ntrips = ", show(trips),
     ";\n  obj = ", show(obj), ";\n"];
