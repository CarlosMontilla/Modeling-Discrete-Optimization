% Workshop 05 of Coursera Course: Modeling Discrete Optimization
% Team selection problem
% Programmed by: Carlos Montilla

% Playes
int: n;
set of int: PLAYERS = 1..n;

% Capitains
int: m;
set of int: CAPITAINS = 1..m;

% Value array
array[CAPITAINS, PLAYERS] of int: value;

% Variables
array[CAPITAINS] of var set of PLAYERS: team;
array[PLAYERS] of var CAPITAINS: capt;

% All different using set intersection
constraint forall(i,j in CAPITAINS where i < j)(team[i] intersect team[j] = {});

% All Team with the same numbers of players
constraint forall(i,j in CAPITAINS where i < j)(abs(card(team[i]) - card(team[j])) <= 1);

% Channel
constraint forall(i in PLAYERS, c in CAPITAINS)((capt[i] = c) <-> (i in team[c]));

% Objective function
var int: total_value = sum(p in PLAYERS)(value[capt[p], p]);


solve maximize total_value;

output["Obj = ", show(total_value), "\n",
        show(team)];
