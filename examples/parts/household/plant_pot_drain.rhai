// Tapered plant pot: 120 mm top, 90 mm base, 110 mm tall, 2.5 mm walls, rolled rim, 5 drain holes and a saucer
let top_d = 120.0; // [60.0, 250.0] Top diameter (mm)
let base_d = 90.0; // [40.0, 200.0] Base diameter (mm)
let height = 110.0; // [50.0, 250.0] Height (mm)
let wall = 2.5; // [1.5, 5.0] Wall thickness (mm)
let pot = cone(base_d / 2.0, top_d / 2.0, height).shell(-wall, ">Z");
pot = pot + torus(top_d / 2.0, wall).translate([0, 0, height - wall]);
pot = pot - cylinder([0, 0, -1], "Z", 6.0, wall + 2.0);
for i in 0..4 { pot -= cylinder([base_d * 0.3, 0, -1], "Z", 4.0, wall + 2.0).rotate_z(i * 90); }
let saucer = (cylinder(top_d * 0.45, 12.0) - cylinder([0, 0, 2.0], "Z", top_d * 0.45 - 2.0, 12.0)).translate([0, 0, -20.0]);
[pot, saucer]
