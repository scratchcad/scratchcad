// Pull-out carrier for a 10 x 38 mm cartridge fuse in a DIN fuse holder: 17.5 mm wide, 62 mm tall, 24 mm deep body with a 10.4 mm bore 38.5 mm long open through a 7 mm side window, 22 x 12 mm grip on top with three 1 mm grip ribs
let fuse_d = 10.0; // [5.0, 14.0] Fuse diameter (mm)
let fuse_len = 38.0; // [20.0, 51.0] Fuse length (mm)
const width = 17.5;
const depth = 24.0;
let body_h = fuse_len + 24.0;
let body = box_from_corners([-width / 2.0, 0, 0], [width / 2.0, depth, body_h]);
let body = body.fillet(1.0, body.edges("|Z"));
const z0 = 11.0;
let bore = cylinder([0, depth / 2.0, z0], "Z", fuse_d / 2.0 + 0.2, fuse_len + 0.5);
let window = box_from_corners([-fuse_d * 0.35, -1.0, z0 + 3.0], [fuse_d * 0.35, depth / 2.0, z0 + fuse_len - 3.0]);
let grip = box_from_corners([-width / 2.0, 0, body_h - 0.5], [width / 2.0, 22.0, body_h + 12.0]);
let ribs = [];
for k in 0..3 {
    let z = body_h + 3.0 + k.to_float() * 3.0;
    ribs.push(box_from_corners([-width / 2.0, -1.0, z], [width / 2.0, 0.5, z + 1.2]));
}
body + grip + fuse_all(ribs) - bore - window
