var 1..9: x;
var 1..9: y;

constraint x >= 4 \/ y <= 5;
constraint y >= x + 4 \/ x >= y + 6;
constraint  x + y >= 8;
solve satisfy;

output ["(\(x),\(y))"]
