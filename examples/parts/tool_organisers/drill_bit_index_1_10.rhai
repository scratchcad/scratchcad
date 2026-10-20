// Drill bit index 1 to 10 mm in 0.5 mm steps: 19 holes 0.2 mm oversize, 25 mm deep in two staggered rows, 190 x 45 x 30 mm block with 1 mm chamfered edges
let depth = 25.0; // [15.0, 28.0] Hole depth (mm)
let length = 190.0; // [170.0, 250.0] Block length (mm)
const w = 45.0;
const h = 30.0;
let b = box_from_corners([0, 0, 0], [length, w, h]);
let b = b.chamfer(1.0, b.edges(">Z"));
let holes = [];
for i in 0..19 {
    let d = 1.0 + 0.5 * i.to_float();
    let x = 8.0 + i.to_float() * (length - 16.0) / 18.0;
    let y = if i % 2 == 0 { 14.0 } else { 31.0 };
    holes.push(cylinder([x, y, h - depth], "Z", d / 2.0 + 0.1, depth + 1.0));
}
b - fuse_all(holes)
