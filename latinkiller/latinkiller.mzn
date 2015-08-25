int: n;
set of int: Num = 1..n;
int: m;
set of int: Group = 1..m;
set of int: Group0 = 0..m;
array[Group] of int: s;
array[Num,Num] of Group0: a;

array[Num,Num] of var Num: x;

%%%%%%%
include "alldifferent.mzn";

%Different numbers in each column
constraint forall(col in Num)(alldifferent([x[r, col] | r in Num]));

% Different numbers in each row
constraint forall(row in Num)(alldifferent([x[row, c] | c in Num]));

% Different within the group
constraint forall(g in Group)(alldifferent([x[i,j] | i,j in Num where a[i,j] = g]));

% Sum of each group
array[Group0] of var int: total_sum;
constraint forall(g in Group0)(total_sum[g] =
                              sum([x[i,j] | i,j in Num where a[i,j] = g]));

constraint forall(g in Group)(total_sum[g] = s[g]);
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
