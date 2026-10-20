// Espresso knock box: 110 mm round bin 100 mm tall, 3 mm wall, 20 mm knock bar on 2 saddles, 5 mm drain-free base
let d = 110.0; // [90.0, 150.0] Bin diameter (mm)
let height = 100.0; // [70.0, 140.0] Bin height (mm)
let wall = 3.0; // [2.0, 5.0] Wall (mm)
let bin = cylinder(d / 2.0, height) - cylinder([0, 0, 5.0], "Z", d / 2.0 - wall, height);
let saddles = box_centered(10.0, 26.0, 30.0).translate([d / 2.0 - wall - 5.0, 0, height - 15.0]) + box_centered(10.0, 26.0, 30.0).translate([-d / 2.0 + wall + 5.0, 0, height - 15.0]);
let bar = cylinder([-d / 2.0 + 1.0, 0, height - 14.0], "X", 10.0, d - 2.0);
((bin + saddles) & cylinder([0, 0, -1], "Z", d / 2.0, height + 2.0)) + bar - cylinder([-d / 2.0 - 1.0, 0, height - 14.0], "X", 5.0, d + 2.0)
