// Z-axis top mount for an 8 mm smooth rod and T8 leadscrew: 46 x 30 x 10 mm block, 8.1 mm rod clamp bore with a 1.5 mm slit and M3 clamp screw, 22.2 mm 608 bearing pocket 7 mm deep 17 mm from the rod with a 10 mm clearance hole, 46 x 30 mm drop tab 5 mm with 2 x M5 holes 30 mm apart for 2020 extrusion
let rod = 8.1; // [6.1, 12.1] Rod bore (mm)
let lead_offset = 17.0; // [14.0, 30.0] Rod to leadscrew distance (mm)
let bearing = 22.2; // [13.0, 22.4] Bearing pocket diameter (mm)
let tab_h = 30.0; // [20.0, 45.0] Mounting tab height (mm)
const block_t = 10.0;
const depth = 30.0;
const tab_t = 5.0;
const pocket = 7.0;
let length = lead_offset + bearing / 2.0 + rod / 2.0 + 14.0;
let xr = -lead_offset / 2.0;
let xl = lead_offset / 2.0;
let block = box_from_corners([-length / 2.0, 0, 0], [length / 2.0, depth, block_t]);
let tab = box_from_corners([-length / 2.0, depth - tab_t, -tab_h], [length / 2.0, depth, 0.5]);
let mount = (block + tab).fillet(2.0, "|Y and >Z");
let yc = (depth - tab_t) / 2.0;
let cuts = [
    cylinder([xr, yc, -1], "Z", rod / 2.0, block_t + 2.0),
    box_from_corners([-length / 2.0 - 1.0, yc - 0.75, -1.0], [xr, yc + 0.75, block_t + 1.0]),
    cylinder([xr - rod / 2.0 - 3.0, -1.0, block_t / 2.0], "Y", 1.6, yc + 6.0),
    cylinder([xl, yc, -0.01], "Z", bearing / 2.0, pocket),
    cylinder([xl, yc, -1], "Z", 5.0, block_t + 2.0)
];
for sx in [-1.0, 1.0] {
    cuts.push(cylinder([sx * 15.0, depth - tab_t - 1.0, -tab_h / 2.0 - 2.0], "Y", 2.6, tab_t + 2.0));
}
mount - fuse_all(cuts)
