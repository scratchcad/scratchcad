// Knock-down barrel nut / cross dowel M6: 10 mm diameter, 14 mm long, M6 cross hole, slotted end
let d = 10.0; // [8.0, 14.0] Diameter (mm)
let length = 14.0; // [10.0, 25.0] Length (mm)
let bolt = 6.0; // [4.0, 10.0] Bolt size (mm)
let nut = cylinder([0, 0, 0], "Z", d / 2.0, length);
let n = nut.chamfer(0.6, nut.edges("%CIRCLE"));
n - cylinder([-d, 0, length / 2.0], "X", bolt / 2.0 - 0.5, d * 2.0) - box_centered(1.2, d + 2.0, 3.0).translate([0, 0, length])
