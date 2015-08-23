array[1..3] of var bool: x;

constraint x[1] <-> (sum(x) = 1);
constraint x[2] <-> (sum(x) = 2);
constraint x[3] <-> (sum(x) = 3);

solve satisfy;