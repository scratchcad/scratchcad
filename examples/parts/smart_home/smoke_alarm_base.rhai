// Smoke alarm twist-lock mounting base: 110 mm ring 6 mm deep, 3 bayonet lugs 12 mm, 2 slots for a 83.5 mm octagon box
let d = 110.0; // [90.0, 140.0] Base diameter (mm)
let depth = 6.0; // [4.0, 10.0] Base depth (mm)
let t = 2.0; // [1.5, 3.0] Wall (mm)
let base = cylinder(d / 2.0, depth) - cylinder([0, 0, t], "Z", d / 2.0 - t, depth);
let lugs = [];
for k in 0..3 { lugs.push((box_from_corners([d / 2.0 - t - 4.0, -6.0, depth - 2.0], [d / 2.0 - t + 0.01, 6.0, depth])).rotate_z(k.to_float() * 120.0)); }
let slots = [];
for s in [-1.0, 1.0] { slots.push(box_centered(14.0, 4.2, t + 2.0).translate([s * 41.75, 0, t / 2.0]) + cylinder([s * 35.0, 0, -1], "Z", 3.5, t + 2.0)); }
base + fuse_all(lugs) - fuse_all(slots) - cylinder([0, 0, -1], "Z", 15.0, t + 2.0)
