int: n;                 % number of gangs
set of int: Gang = 1..n; 
array[Gang] of int: m;  % size of each gang
int: t = sum(i in Gang)(m[i]);
set of int: Time = 1..t;
set of int: Student = 1..t;
int: r; % number of rivalries
set of int: Rival = 1..r;
array[Rival] of Gang: g1;
array[Rival] of Gang: g2;
var int: obj;

%%%%%%%

% add your constraints here

%%%%%%%

solve::int_search(order, first_fail, indomain_max, complete)
maximize obj;


output ["order = ",show(order),
	";\nobj = ", show(obj),
	";\n" ];




