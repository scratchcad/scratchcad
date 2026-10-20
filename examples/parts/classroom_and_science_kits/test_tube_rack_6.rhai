// Student test tube rack: 6 holes 18 mm for 16 mm tubes, 150 x 50 x 60 mm, two-tier with 6 drying pegs
let n = 6; // [3, 12] Number of tubes
let hole = 18.0; // [12.0, 25.0] Hole diameter (mm)
let pitch = 24.0; // [18.0, 35.0] Pitch (mm)
let length = n.to_float() * pitch + 6.0;
let base = box_from_corners([0, 0, 0], [length, 50.0, 4.0]);
let top = box_from_corners([0, 0, 50.0], [length, 50.0, 55.0]);
let ends = box_from_corners([0, 0, 0], [4.0, 50.0, 55.0]) + box_from_corners([length - 4.0, 0, 0], [length, 50.0, 55.0]);
let holes = [];
let pegs = [];
for i in 0..n { let x = 3.0 + pitch / 2.0 + i.to_float() * pitch; holes.push(cylinder([x, 18.0, 49.0], "Z", hole / 2.0, 8.0)); pegs.push(cylinder([x, 40.0, 54.99], "Z", 3.0, 40.0)); }
base + top + ends - compound(holes) + compound(pegs)
