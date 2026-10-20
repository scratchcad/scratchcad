// 1U horizontal cable management bar: 482.6 x 44 mm face 2 mm thick with 5 fingers 70 mm deep, 12 mm wide, 3 mm thick with 10 mm retaining tips, and 4 mounting holes
let fingers = 5; // [3, 9] Number of fingers
let depth = 70.0; // [40.0, 100.0] Finger depth (mm)
const t = 2.0;
const span = 440.0;
let face_ = box_from_corners([-241.3, 0, 0], [241.3, t, 43.65]);
let f = [];
for i in 0..fingers {
    let x = -span / 2.0 + span * i.to_float() / (fingers - 1).to_float();
    f.push(box_from_corners([x - 6.0, t - 0.01, 15.0], [x + 6.0, t + depth, 18.0]) + box_from_corners([x - 6.0, t + depth - 3.0, 15.0], [x + 6.0, t + depth, 28.0]));
}
let holes = [];
for sx in [-1.0, 1.0] { for z in [6.35, 37.3] { holes.push(cylinder([sx * 232.55, -1.0, z], "Y", 3.5, t + 2.0)); } }
face_ + fuse_all(f) - fuse_all(holes)
