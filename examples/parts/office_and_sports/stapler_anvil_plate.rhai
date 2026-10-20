// Desk stapler anvil plate: 50 x 12 x 1.2 mm with two 13 x 2.5 mm clinch grooves 0.6 mm deep (one curving, one straight-out), two rivet holes
let len = 50.0; // [35.0, 70.0] Plate length (mm)
let plate = box_centered(len, 12.0, 1.2).translate([0, 0, 0.6]).fillet(1.5, "|Z");
let grooves = [];
for s in [-1.0, 1.0] { grooves.push(box_centered(13.0, 2.5, 1.0).translate([0, s * 2.2, 1.2])); }
let p = plate - fuse_all(grooves);
for x in [-len / 2.0 + 6.0, len / 2.0 - 6.0] { p -= cylinder([x, 0, -1], "Z", 1.5, 3.0); }
p
