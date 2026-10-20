// Edge finder and indicator holder block: 80 x 40 x 30 mm with three 10 mm holes 25 mm deep for edge finders, a 20 mm hole for a test indicator stem and 1 mm chamfers
let length = 80.0; // [60.0, 120.0] Block length (mm)
let depth = 25.0; // [15.0, 28.0] Hole depth (mm)
const w = 40.0;
const h = 30.0;
let b = box_from_corners([0, 0, 0], [length, w, h]);
let b = b.chamfer(1.0, b.edges(">Z"));
let holes = [cylinder([length - 15.0, w / 2.0, h - depth], "Z", 10.0, depth + 1.0)];
for i in 0..3 { holes.push(cylinder([12.0 + i.to_float() * 15.0, w / 2.0, h - depth], "Z", 5.1, depth + 1.0)); }
b - fuse_all(holes)
