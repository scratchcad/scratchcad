// Milking cluster teat cup shell: 140 mm long, 40 mm OD steel-style shell, 34 mm bore, liner groove and 10 mm pulse nipple
let length = 140.0; // [110.0, 170.0] Length (mm)
let od = 40.0; // [32.0, 50.0] Outside diameter (mm)
let wall = 2.0; // [1.2, 3.0] Wall (mm)
let shell = cylinder(od / 2.0, length) + cone(od / 2.0 - 6.0, od / 2.0, 20.0).translate([0, 0, -19.99]);
let bore = cylinder([0, 0, -21.0], "Z", od / 2.0 - wall - 6.0, 30.0) + cylinder([0, 0, 0], "Z", od / 2.0 - wall, length + 1.0);
let nipple = cylinder([0, 0, length - 30.0], "X", 5.0, od / 2.0 + 14.0) - cylinder([0, 0, length - 30.0], "X", 3.0, od / 2.0 + 15.0);
shell - bore + (nipple - cylinder([0, 0, -1], "Z", od / 2.0 - wall, length + 2.0))
