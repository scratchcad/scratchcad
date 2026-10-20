// Wood stove door handle: 16 mm bar 120 mm long on two 30 mm standoffs 14 mm dia, each with an M6 tapped hole 12 mm deep (5 mm drill)
let length = 120.0; // [90.0, 180.0] Handle length (mm)
let bar_d = 16.0; // [12.0, 22.0] Bar diameter (mm)
let standoff = 30.0; // [20.0, 45.0] Standoff height (mm)
let pitch = length - 20.0;
let bar = cylinder([-length / 2.0, 0, standoff + bar_d / 2.0], "X", bar_d / 2.0, length);
let bar = bar.fillet(2.0, bar.edges("%CIRCLE"));
let legs = cylinder([-pitch / 2.0, 0, 0], "Z", 7.0, standoff + bar_d / 2.0) + cylinder([pitch / 2.0, 0, 0], "Z", 7.0, standoff + bar_d / 2.0);
bar + legs - cylinder([-pitch / 2.0, 0, -1.0], "Z", 2.5, 13.0) - cylinder([pitch / 2.0, 0, -1.0], "Z", 2.5, 13.0)
