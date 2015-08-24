include "alldifferent.mzn";
int: n;
set of int: PERS = 1..n;
array[PERS, PERS] of bool: friend;
array[1..2, 1..(n div 2)] of var PERS: x;

constraint alldifferent([x[col, f] | f in 1..(n div 2), col in 1..2]);
constraint min([x[1,f] | f in 1..(n div 2)]) < min([x[2,f] | f in 1..(n div 2)]);

var int: match_lateral = sum(col in 1..2)(sum(i in 1..((n div 2) - 1))(bool2int(friend[x[col, i], x[col, i+1]])));
var int: match_front = sum(i in 1..(n div 2))(bool2int(friend[x[1,i], x[2,i]]));
var int: total_matchs = match_lateral + match_front;
solve maximize total_matchs;

output["obj = ",show(total_matchs), "\n",show([x[1, f] | f in (1..(n div 2))]), "\n", show([x[2, f] | f in (1..(n div 2))])];