// Toy car wheel pair on an axle: 24 mm wheels 10 mm wide with tread grooves and 5-spoke hub recess, 3 mm axle 60 mm long
let d = 24.0; // [12.0, 50.0] Wheel diameter (mm)
let track = 50.0; // [30.0, 100.0] Track width (mm)
let r = d / 2.0;
let wheel = cylinder(r, 10.0).fillet(1.5, "%CIRCLE");
for k in 0..3 { wheel -= torus(r + 0.2, 0.6).translate([0, 0, 2.5 + k.to_float() * 2.5]); }
wheel -= cylinder([0, 0, 8.0], "Z", r - 3.0, 3.0);
for k in 0..5 { wheel += box_from_corners([0, -1.0, 8.0], [r - 2.5, 1.0, 10.0]).rotate("Z", k.to_float() * 72.0); }
let axle = cylinder([0, 0, -6.0], "Z", 1.5, track + 2.0 * 6.0 - 10.0 + 10.0);
fuse_all([wheel.mirror([0, 0, 1]).translate([0, 0, 10.0]), wheel.translate([0, 0, track - 10.0]), axle]).rotate_x(90.0)
