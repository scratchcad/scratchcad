// Flush aircraft fuel cap: 50 mm adapter, 60 mm flange 3 mm, folding tab recess 30 x 12 mm, 2 cam lugs, vent 2 mm
let opening = 50.0; // [40.0, 70.0] Filler diameter (mm)
let flange = 60.0; // [45.0, 80.0] Flange diameter (mm)
let depth = 15.0; // [10.0, 25.0] Plug depth (mm)
let cap = cylinder(flange / 2.0, 3.0) + cylinder([0, 0, -depth], "Z", opening / 2.0 - 0.5, depth + 0.01);
let lugs = [];
for s in [-1.0, 1.0] { lugs.push(box_from_corners([s * (opening / 2.0 - 1.0), -5.0, -depth], [s * (opening / 2.0 + 3.0), 5.0, -depth + 3.0])); }
let recess = box_centered(30.0, 12.0, 4.0).translate([0, 0, 3.0]);
let tab = box_centered(26.0, 8.0, 1.5).translate([0, 0, 1.75]);
cap + fuse_all(lugs) - recess + tab - cylinder([10.0, 0, -depth - 1.0], "Z", 1.0, depth + 6.0) - cylinder([0, 0, -depth - 1.0], "Z", opening / 2.0 - 3.5, depth - 2.0)
