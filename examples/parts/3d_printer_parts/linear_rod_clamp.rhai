// 8 mm linear rod clamp for printed frames: 30 x 12 x 16 mm block, split clamp with M3 screw, two M4 mount holes
let rod = 8.0; // [6.0, 12.0] Rod diameter (mm)
let length = 30.0; // [20.0, 45.0] Length (mm)
let depth = 12.0; // [8.0, 20.0] Depth (mm)
let height = 16.0; // [12.0, 25.0] Height (mm)
let block = box_centered(length, depth, height).translate([0, 0, height / 2.0]).fillet(2.0, "|Y and >Z");
block = block - cylinder([0, -depth, height * 0.6], "Y", rod / 2.0, depth * 2.0);
block = block - box_centered(1.0, depth + 2.0, height).translate([0, 0, height * 0.6 + height / 2.0]);
block = block - cylinder([-length, 0, height - 3.0], "X", 1.6, length * 2.0);
for s in [-1, 1] { block -= cylinder([s * (length / 2.0 - 4.0), 0, -1], "Z", 2.1, height * 0.4); }
block
