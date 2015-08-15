int: d;
var int: x;
constraint x = d;
solve satisfy;

output ["d = \(x)"]