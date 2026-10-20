// Bottle drying tree peg: 12 mm socket spigot 20 mm long pushing into the tree column, 8 mm peg 70 mm long angled up 20 degrees with a 10 mm rounded tip
let peg = 70.0; // [50.0, 100.0] Peg length (mm)
let angle = 20.0; // [5.0, 35.0] Peg tilt (degrees)
const spigot = 12.0;
let s = cylinder([-20.0, 0, 0], "X", spigot / 2.0, 20.01);
let collar = cylinder([0, 0, 0], "X", 8.0, 4.0);
let arm = (cylinder([0, 0, 0], "X", 4.0, peg) + sphere([peg, 0, 0], 5.0)).rotate_y(-angle).translate([3.0, 0, 0]);
s + collar + arm
