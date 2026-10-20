// Napkin ring: 45 mm OD, 38 mm ID, 30 mm wide, with a beaded edge and 12 oval cut-outs
let outer_d = 45.0; // [39.0, 60.0] Outside diameter (mm)
let inner_d = 38.0; // [28.0, 43.0] Inside diameter (mm)
let width = 30.0; // [15.0, 45.0] Width (mm)
let windows = 12; // [0, 20] Cut-outs
let ring = cylinder(outer_d / 2.0, width) - cylinder([0, 0, -1], "Z", inner_d / 2.0, width + 2.0);
ring = ring + torus(outer_d / 2.0 - 0.8, 1.6).translate([0, 0, 1.6]) + torus(outer_d / 2.0 - 0.8, 1.6).translate([0, 0, width - 1.6]);
let cuts = [];
for i in 0..windows { cuts.push((cylinder([0, 0, width / 2.0], "X", 4.0, outer_d) & box_centered(outer_d * 2.0, 6.0, 30.0).translate([0, 0, width / 2.0])).rotate_z(i.to_float() * 360.0 / windows.to_float())); }
if windows > 0 { ring - fuse_all(cuts) } else { ring }
