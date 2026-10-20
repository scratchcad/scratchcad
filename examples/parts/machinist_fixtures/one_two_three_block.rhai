// 1-2-3 setup block: 25.4 x 50.8 x 76.2 mm block with 19 holes: a 5 x 3 grid through the big face (6.8 mm M8 tap drill and 11 mm clearance alternating) and 4 cross holes, 0.5 mm edge chamfers
let scale = 1.0; // [1.0, 2.0] Size multiplier (1 = 1-2-3, 2 = 2-4-6)
let a = 25.4 * scale;
let b = 50.8 * scale;
let c = 76.2 * scale;
let blk = box_from_corners([0, 0, 0], [c, b, a]);
let blk = blk.chamfer(0.5, blk.edges());
let holes = [];
for i in 0..5 { for j in 0..3 {
    let x = c * (i.to_float() + 0.5) / 5.0;
    let y = b * (j.to_float() + 0.5) / 3.0;
    let r = if (i + j) % 2 == 0 { 5.5 } else { 3.4 };
    holes.push(cylinder([x, y, -1.0], "Z", r, a + 2.0));
} }
for i in 0..4 { holes.push(cylinder([c * (i.to_float() + 0.5) / 4.0, -1.0, a / 2.0], "Y", 3.4, b + 2.0)); }
blk - fuse_all(holes)
