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

array[Student] of var Time: student;
array[Time] of var Student: order;

include "inverse.mzn";
constraint inverse(student, order);

% Leaders of each gang
array[Gang] of int: leaders = [1] ++ [1 + sum([m[g] | g in 1..i])| i in 1..n-1];

%% To construct array of leaders
array[Gang] of 1..t: cumul = [sum(k in Gang where k<=j)(m[k])|j in Gang];
array[Student] of Gang: which =  [min(j in Gang where cumul[j]>=i)(j) | i in Student];
array[Student] of var 1..t: leader = [leaders[which[st]] | st in Student];

% Construction of each gang
array[Gang] of set of int: gangs = [{s | s in leaders[g]..(leaders[g] + m[g] - 1)} | g in Gang];

% No consecutive members
constraint forall(g in Gang)(forall(s1, s2 in gangs[g] where s1 < s2)(student[s1] != student[s2] + 1 /\ student[s1] != student[s2] - 1));

% Points system
array[Student] of var 0..3: points = [if st != leader[st] /\ student[st] > student[leader[st]] then 0
                                      elseif st != leader[st] /\ student[st] < student[leader[st]] then 1
                                      elseif st == leader[st] /\ student[st] < t div 2 then 3
                                      else 0 endif
                                      | st in Student];

constraint obj= sum(points);

%%%%%%%

solve::int_search(order, first_fail, indomain_max, complete)
maximize obj;


output ["order = ",show(order),
	";\nobj = ", show(obj),
	";\n" ];
