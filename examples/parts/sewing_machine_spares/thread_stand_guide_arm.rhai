// Thread stand antenna guide arm: 16 mm hub 14 mm tall with an 8.2 mm socket for the antenna rod and an M4 set screw hole (3.3 mm), 120 mm wide 8 x 4 mm arm across the top with a 10 mm eyelet boss and 3 mm thread eye at each end above the spool pins
let span = 120.0; // [60.0, 160.0] Eyelet spacing (mm)
let rod_d = 8.2; // [6.0, 10.0] Rod socket diameter (mm)
let hub_h = 14.0; // [10.0, 20.0] Hub height (mm)
let eye_d = 3.0; // [2.0, 4.5] Thread eye diameter (mm)
const hub_d = 16.0;
const arm_w = 8.0;
const arm_t = 4.0;
let hd = max(hub_d, rod_d + 6.0);
let parts = [
    cylinder(hd / 2.0, hub_h),
    box_from_corners([-span / 2.0, -arm_w / 2.0, hub_h - arm_t], [span / 2.0, arm_w / 2.0, hub_h]),
];
for s in [-1.0, 1.0] {
    parts.push(cylinder([s * span / 2.0, 0, hub_h - arm_t], "Z", 5.0, arm_t));
}
let cuts = [
    cylinder([0, 0, -1.0], "Z", rod_d / 2.0, hub_h - arm_t + 1.0),
    cylinder([0, -hd, (hub_h - arm_t) / 2.0], "Y", 1.65, hd),
];
for s in [-1.0, 1.0] {
    cuts.push(cylinder([s * span / 2.0, 0, hub_h - arm_t - 1.0], "Z", eye_d / 2.0, arm_t + 2.0));
}
fuse_all(parts) - fuse_all(cuts)
