int: d;
array[1..d] of var 1..9: x;

constraint forall(i in 1..(d-1))(x[i] <= x[i+1]);
constraint sum(x) = product(x);

solve satisfy;

output[show(x)];