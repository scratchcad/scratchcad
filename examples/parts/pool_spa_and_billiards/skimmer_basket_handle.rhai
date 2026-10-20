// Skimmer basket handle: 150 mm bail 6 mm round on two 10 mm pivot lugs with 4 mm pins, 30 mm grip
let span = 150.0; // [100.0, 200.0] Bail span (mm)
let rod = 6.0; // [4.0, 10.0] Rod diameter (mm)
let rise = 60.0; // [30.0, 100.0] Bail height (mm)
let r = rod / 2.0;
let legs = cylinder([-span / 2.0, 0, 0], "Z", r, rise) + cylinder([span / 2.0, 0, 0], "Z", r, rise);
let top = cylinder([-span / 2.0, 0, rise], "X", r, span) + sphere([-span / 2.0, 0, rise], r + 0.4) + sphere([span / 2.0, 0, rise], r + 0.4);
let grip = cylinder([-15.0, 0, rise], "X", r + 4.0, 30.0);
let lugs = [];
for s in [-1.0, 1.0] { lugs.push(cylinder([s * span / 2.0, 0, 0], "Z", 5.0, 6.0) - cylinder([s * span / 2.0 - 6.0, 0, 3.0], "X", 2.0, 12.0)); }
legs + top + grip + fuse_all(lugs)
