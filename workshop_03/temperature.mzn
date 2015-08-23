array[int] of int: readings;
int: start; 
int: n = length(readings);
set of int: HOURS = 1..n;
set of int: HOURS0 = 0..n;       
int: low = 16;
int: high = 22;

set of int: CTR = 1..5; % Numbers of actions 
array[CTR] of int: tmp_control = [1, 4, -2, -5, 0]; % Changes in temperature
array[CTR] of int: cst_control = [10, 50, 30, 90, 0]; %Cost of each action
array[HOURS] of var CTR: actions;
array[HOURS0] of var low..high: tmp;
constraint tmp[0] = start;

constraint forall(h in HOURS)(tmp[h] = (tmp[h-1] + readings[h]) div 2 +
                                        tmp_control[actions[h]]);

var int: total_cost = sum(a in actions)(cst_control[a]);
solve minimize total_cost;

output [show(tmp),"\n", show(actions),"\n", show(total_cost)];