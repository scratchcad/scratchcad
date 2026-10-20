// Baseplate compass body: 125 x 60 x 3 mm plate with a 45 mm bezel well, 25 mm magnifier hole and lanyard slot
let length = 125.0; // [90.0, 150.0] Plate length (mm)
let width = 60.0; // [45.0, 75.0] Plate width (mm)
let thickness = 3.0; // [2.0, 4.0] Plate thickness (mm)
let bezel_d = 45.0; // [35.0, 55.0] Capsule diameter (mm)
let plate = box_from_corners([0, -width / 2.0, 0], [length, width / 2.0, thickness]);
let p = plate.fillet(6.0, plate.edges("|Z"));
let bezel = cylinder([length - 40.0, 0, 0], "Z", bezel_d / 2.0 + 3.0, 10.0) - cylinder([length - 40.0, 0, 1.5], "Z", bezel_d / 2.0, 10.0);
let ridges = [];
for k in 0..36 { ridges.push(box_centered(2.0, 1.2, 8.0).translate([bezel_d / 2.0 + 3.0, 0, 5.5]).rotate_z(k.to_float() * 10.0).translate([length - 40.0, 0, 0])); }
p - cylinder([length - 40.0, 0, -1], "Z", bezel_d / 2.0, 4.0) + bezel - compound(ridges) - cylinder([28.0, 0, -1], "Z", 12.5, 5.0) - box_from_corners([4.0, -6.0, -1], [8.0, 6.0, 5.0])
