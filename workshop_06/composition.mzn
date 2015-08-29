int: n;
set of int: NOTE = 1..n;
array[NOTE] of var NOTE: notes;
array[1..n-1] of var 1..n-1: differances = [abs(notes[i+1] - notes[i]) | i in 1..n-1];

include "alldifferent.mzn";
constraint alldifferent(notes);
constraint alldifferent(differances);

solve satisfy;

output[show(notes)];