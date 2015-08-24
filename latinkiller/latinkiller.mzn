int: n;
set of int: Num = 1..n;
int: m;
set of int: Group = 1..m;
set of int: Group0 = 0..m;
array[Group] of int: s;
array[Num,Num] of Group0: a;

array[Num,Num] of var Num: x;

%%%%%%%

% add your constraints here

%%%%%%%

solve satisfy;

output ["x = [|"] ++
       [ if j = 1 /\ 2 <= i /\ i <= n then "| " else "" endif ++
         show(x[i,j]) ++ 
         if j == n then "\n" else ", " endif  
       | i,j in Num ] 
       ++
       ["|];\n"]
;

