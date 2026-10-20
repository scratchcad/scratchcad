// Folding GPS mast: 20 x 20 x 6 mm base with two M3 holes and hinge cheeks, 10 mm tube 100 mm tall, 40 mm puck plate with four M2 holes
let h = 100.0; // [50.0, 200.0] Mast height (mm)
let base = box_centered(20.0, 20.0, 6.0).translate([0, 0, 3.0]);
for x in [-6.0, 6.0] { base -= cylinder([x, 6.0, -1], "Z", 1.6, 8.0); }
let cheeks = [box_from_corners([-6.0, -9.0, 6.0], [-3.0, -1.0, 14.0]), box_from_corners([3.0, -9.0, 6.0], [6.0, -1.0, 14.0])];
let knuckle = cylinder([-3.0, -5.0, 11.0], "X", 4.0, 6.0);
let tube = cylinder([0, -5.0, 11.0], "Z", 5.0, h) - cylinder([0, -5.0, 13.0], "Z", 4.0, h);
let plate = cylinder([0, -5.0, h + 10.0], "Z", 20.0, 2.0);
for k in 0..4 { plate -= cylinder([12.0, 0, h + 9.0], "Z", 1.1, 4.0).rotate("Z", 45.0 + k.to_float() * 90.0).translate([0, -5.0, 0]); }
fuse_all([base, knuckle, tube, plate] + cheeks) - cylinder([-7.0, -5.0, 11.0], "X", 1.6, 14.0)
