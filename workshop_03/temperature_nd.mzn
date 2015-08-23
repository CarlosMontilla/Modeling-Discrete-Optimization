array[int] of int: readings;
int: start;
int: n = length(readings);
array[1..n] of var int: tmp;

constraint tmp[1] = (start + readings[1]) div 2;
constraint forall(i in 2..n)(tmp[i] = (tmp[i-1] + readings[i]) div 2);

solve satisfy;