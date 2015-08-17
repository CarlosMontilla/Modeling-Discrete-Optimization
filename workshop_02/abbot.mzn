var 1..100: men; 
var 1..100: women;
var 1..100: children;

constraint men + women + children = 100;
constraint 6*men + 4*women + children = 200;
constraint women = 5*men;
solve satisfy;

output["Men = ", show(men),
       "\nWomen = " ,show(women),
       "\nChildren = ", show(children)];
