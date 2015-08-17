var bool: H;
var bool: D;
var bool: L;

constraint D <-> L;
constraint H -> D;
constraint (D /\ L) = false;

solve satisfy;
output["Louis = ", show(L),
       "\nDewey = ", show(D),
       "\nHuey  = ", show(H)];