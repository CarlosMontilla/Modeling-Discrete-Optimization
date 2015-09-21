% Third assignment
% Programmed by Carlos Montilla
int: f;
int: g;
int: c;
int: k;
set of int: Cap = 0..k;
int: t;
set of int: Trips = 1..t;
int: pf;
int: pg;
int: pc;

array[Trips] of var Cap: fox;
array[Trips] of var Cap: geese;
array[Trips] of var Cap: corn;
var 0..t: trips;

var int: obj;

%%%%%%%%%%%%%%%%%%%%%%%%%%% ADD constraints in here %%%%%%%%%%%%%
int: maxValue = f + g + c;

array[0..t, 1..3] of var 0..maxValue: leftSideUnchanged;
array[0..t, 1..3] of var 0..maxValue: leftSide;

array[0..t, 1..3] of var 0..maxValue: rightSideUnchanged;
array[0..t, 1..3] of var 0..maxValue: rightSide;


%% ----  Inicial Conditions
constraint leftSideUnchanged[0, 1] = f;
constraint leftSideUnchanged[0, 2] = g;
constraint leftSideUnchanged[0, 3] = c;

constraint leftSide[0, 1] = f;
constraint leftSide[0, 2] = g;
constraint leftSide[0, 3] = c;

constraint rightSideUnchanged[0, 1] = 0;
constraint rightSideUnchanged[0, 2] = 0;
constraint rightSideUnchanged[0, 3] = 0;

constraint rightSide[0, 1] = 0;
constraint rightSide[0, 2] = 0;
constraint rightSide[0, 3] = 0;


%% Actualization Dynamics

% Aller
constraint forall(t in Trips where t mod 2 != 0)(rightSideUnchanged[t, 1] = rightSide[t-1, 1] + fox[t]);
constraint forall(t in Trips where t mod 2 != 0)(rightSideUnchanged[t, 2] = rightSide[t-1, 2] + geese[t]);
constraint forall(t in Trips where t mod 2 != 0)(rightSideUnchanged[t, 3] = rightSide[t-1, 3] + corn[t]);

constraint forall(t in Trips where t mod 2 != 0)(leftSideUnchanged[t, 1] = leftSide[t-1, 1] - fox[t]);
constraint forall(t in Trips where t mod 2 != 0)(leftSideUnchanged[t, 2] = leftSide[t-1, 2] - geese[t]);
constraint forall(t in Trips where t mod 2 != 0)(leftSideUnchanged[t, 3] = leftSide[t-1, 3] - corn[t]);

% Retour
constraint forall(t in Trips where t mod 2 = 0)(leftSideUnchanged[t, 1] = leftSide[t-1, 1] + fox[t]);
constraint forall(t in Trips where t mod 2 = 0)(leftSideUnchanged[t, 2] = leftSide[t-1, 2] + geese[t]);
constraint forall(t in Trips where t mod 2 = 0)(leftSideUnchanged[t, 3] = leftSide[t-1, 3] + corn[t]);


constraint forall(t in Trips where t mod 2 = 0)(rightSideUnchanged[t, 1] = rightSide[t-1, 1] - fox[t]);
constraint forall(t in Trips where t mod 2 = 0)(rightSideUnchanged[t, 2] = rightSide[t-1, 2] - geese[t]);
constraint forall(t in Trips where t mod 2 = 0)(rightSideUnchanged[t, 3] = rightSide[t-1, 3] - corn[t]);

% Dynamics aller
constraint forall(t in Trips where t mod 2 != 0)(
if sum([bool2int(leftSideUnchanged[t,i] > 0) | i in 1..3]) < 2 \/ transported[t] = 0 then
          leftSide[t,1] = leftSideUnchanged[t,1] /\
          leftSide[t,2] = leftSideUnchanged[t,2] /\
          leftSide[t,3] = leftSideUnchanged[t,3]
  elseif leftSideUnchanged[t,2] = 0 then
          leftSide[t,1] = leftSideUnchanged[t,1] - 1 /\
          leftSide[t,2] = leftSideUnchanged[t,2] /\
          leftSide[t,3] = leftSideUnchanged[t,3] - 1
  elseif leftSideUnchanged[t,1] = 0 /\ leftSideUnchanged[t,2] > leftSideUnchanged[t,3] then
         leftSide[t,1] = leftSideUnchanged[t,1] /\
         leftSide[t,2] = leftSideUnchanged[t,2] - 1 /\
         leftSide[t,3] = leftSideUnchanged[t,3] - 1
  elseif leftSideUnchanged[t,1] = 0 /\ leftSideUnchanged[t,2] <= leftSideUnchanged[t,3] then
         leftSide[t,1] = leftSideUnchanged[t,1] /\
         leftSide[t,3] = leftSideUnchanged[t,3] - leftSideUnchanged[t,2] /\
         leftSide[t,2] = leftSideUnchanged[t,2]
  elseif leftSideUnchanged[t, 1] > leftSideUnchanged[t,2] then
         leftSide[t,1] = leftSideUnchanged[t,1] - 1 /\
         leftSide[t,2] = leftSideUnchanged[t,2] /\
         leftSide[t,3] = leftSideUnchanged[t,3]
  else leftSide[t,1] = leftSideUnchanged[t,1] /\
       leftSide[t,2] = leftSideUnchanged[t,2] - leftSideUnchanged[t,1] /\
       leftSide[t,3] = leftSideUnchanged[t,3]

endif);

constraint forall(t in Trips, i in 1..3 where t mod 2 != 0)(rightSide[t,i] = rightSideUnchanged[t,i]);

% Dynamics retour
constraint forall(t in Trips where (t mod 2 = 0))(
  if sum([bool2int(rightSideUnchanged[t,i] > 0) | i in 1..3]) < 2 \/ transported[t] = 0 \/ sum([leftSide[t,i] | i in 1..3]) = 0 then
          rightSide[t,1] = rightSideUnchanged[t,1] /\
          rightSide[t,2] = rightSideUnchanged[t,2] /\
          rightSide[t,3] = rightSideUnchanged[t,3]
  elseif rightSideUnchanged[t,2] = 0 then
          rightSide[t,1] = rightSideUnchanged[t,1] - 1 /\
          rightSide[t,2] = rightSideUnchanged[t,2] /\
          rightSide[t,3] = rightSideUnchanged[t,3] - 1
  elseif rightSideUnchanged[t,1] = 0 /\ rightSideUnchanged[t,2] > rightSideUnchanged[t,3] then
         rightSide[t,1] = rightSideUnchanged[t,1] /\
         rightSide[t,2] = rightSideUnchanged[t,2] - 1 /\
         rightSide[t,3] = rightSideUnchanged[t,3] - 1
  elseif rightSideUnchanged[t,1] = 0 /\ rightSideUnchanged[t,2] <= rightSideUnchanged[t,3] then
         rightSide[t,1] = rightSideUnchanged[t,1] /\
         rightSide[t,3] = rightSideUnchanged[t,3] - rightSideUnchanged[t,2] /\
         rightSide[t,2] = rightSideUnchanged[t,2]
  elseif rightSideUnchanged[t, 1] > rightSideUnchanged[t,2] then
         rightSide[t,1] = rightSideUnchanged[t,1] - 1 /\
         rightSide[t,2] = rightSideUnchanged[t,2] /\
         rightSide[t,3] = rightSideUnchanged[t,3]
  else rightSide[t,1] = rightSideUnchanged[t,1] /\
       rightSide[t,2] = rightSideUnchanged[t,2] - rightSideUnchanged[t,1] /\
       rightSide[t,3] = rightSideUnchanged[t,3]

endif);
constraint forall(t in Trips, i in 1..3 where t mod 2 = 0)(leftSide[t,i] = leftSideUnchanged[t,i]);

%No unnecessary trip
%constraint forall(t in 1..(t-1) where transported[t] = 1)(fox[t] != fox[t+1] /\
%                                  geese[t] != geese[t+1] /\
%                                  corn[t] != corn[t+1]);

% Boat capacity
array[Trips] of var 0..maxValue: totalTransported;
constraint forall(t in Trips)(totalTransported[t] = fox[t] + geese[t] + corn[t]);
constraint forall (t in Trips)(totalTransported[t] <= k);

array[Trips] of var 0..1: transported;

constraint forall(t in 1..t)(totalTransported[t] > 0 -> transported[t] = 1);
constraint forall(t in 1..t-1)(if transported[t+1] > 0 then transported[t] = 1
                               else transported[t] = 0 endif);

constraint trips = sum(transported);

constraint obj = rightSide[t,1] * pf + rightSide[t,2]*pg + rightSide[t,3]*pc;
%%%%%%%%%%%%%%%%% you may want to modify the search strategy below

solve maximize obj;


output ["  fox = ", show(fox),
     ";\ngeese = ", show(geese),
     ";\n corn = ", show(corn),
     ";\ntrips = ", show(trips),
     ";\n  obj = ", show(obj), ";\n"] %% Extra
