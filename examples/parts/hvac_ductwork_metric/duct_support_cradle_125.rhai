// Duct support cradle for 125 mm duct: 30 mm wide saddle block on a 170 x 30 mm foot 6 mm thick, 125.5 mm half-round seat 8 mm under the duct, 2 x 6.5 mm foot holes, 25 x 3 mm strap slots in both horns
let duct_d = 125.5; // [80.0, 250.0] Duct diameter (mm)
let width = 30.0; // [20.0, 50.0] Cradle width (mm)
let under = 8.0; // [5.0, 20.0] Material under the duct (mm)
let foot_t = 6.0; // [4.0, 10.0] Foot thickness (mm)
let r = duct_d / 2.0;
const horn = 8.0;
let zc = foot_t + under + r;
let foot_l = duct_d + 45.0;
let foot = box_from_corners([-foot_l / 2.0, -width / 2.0, 0], [foot_l / 2.0, width / 2.0, foot_t]);
let block = box_from_corners([-r - horn, -width / 2.0, foot_t - 1.0], [r + horn, width / 2.0, zc]);
let cradle = foot + block - cylinder([0, -width / 2.0 - 1.0, zc], "Y", r, width + 2.0);
// lighten the block between seat and foot with a window on each side
for sx in [-1.0, 1.0] {
    let xw = sx * (r * 0.85);
    cradle = cradle - cylinder([xw, -width / 2.0 - 1.0, foot_t + (under + r) * 0.25], "Y", r * 0.15, width + 2.0);
}
let slots = [];
for sx in [-1.0, 1.0] {
    slots.push(box_centered(3.0, min(25.0, width - 6.0), 12.0).translate([sx * (r + horn / 2.0), 0, zc - 10.0]));
    slots.push(cylinder([sx * (foot_l / 2.0 - 10.0), 0, -1], "Z", 3.25, foot_t + 2.0));
}
cradle - fuse_all(slots)
