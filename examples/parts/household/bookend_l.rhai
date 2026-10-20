// L-shaped bookend: 140 mm tall, 120 mm base, 130 mm wide, 2.5 mm steel, rounded corners, anti-slip foot pads
let height = 140.0; // [80.0, 250.0] Height (mm)
let base = 120.0; // [60.0, 200.0] Base depth (mm)
let width = 130.0; // [60.0, 200.0] Width (mm)
let thickness = 2.5; // [1.5, 5.0] Thickness (mm)
let upright = box(width, thickness, height).fillet(12.0, "|Y and >Z");
let floor = box(width, base, thickness);
let pads = [];
for x in [15.0, width - 15.0] { pads.push(cylinder([x, base - 15.0, -1.0], "Z", 6.0, 1.01)); }
fuse_all([upright, floor] + pads)
