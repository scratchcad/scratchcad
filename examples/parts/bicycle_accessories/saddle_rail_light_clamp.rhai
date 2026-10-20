// Saddle rail rear-light clamp: fits 7 mm round rails 42 mm apart, 50 x 16 x 10 mm bar with 2 snap clips, 20 mm light mount face
let rail = 7.0; // [7.0, 9.0] Rail diameter (mm)
let spacing = 42.0; // [38.0, 45.0] Rail spacing (mm)
let bar = box_centered(spacing + 14.0, 16.0, 10.0).translate([0, 0, 5.0]);
let b = bar.fillet(3.0, bar.edges("|Z"));
let clips = [];
for s in [-1.0, 1.0] { clips.push(cylinder([s * spacing / 2.0, -8.0, 10.0], "Y", rail / 2.0, 16.0) + box_centered(rail * 0.7, 16.0, 5.0).translate([s * spacing / 2.0, 0, 12.0])); }
let face = box_from_corners([-10.0, -8.0 - 3.0, -20.0], [10.0, -8.0 + 0.01, 10.0]);
b + face - fuse_all(clips) - cylinder([-5.0, -12.0, -10.0], "Y", 1.6, 5.0) - cylinder([5.0, -12.0, -10.0], "Y", 1.6, 5.0)
