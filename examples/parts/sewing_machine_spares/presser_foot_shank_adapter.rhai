// Snap-on presser foot holder for low-shank machines: 12 x 9 mm body 25 mm tall, 4.2 mm wide open slot 10 mm deep from the top for the presser bar thumb screw, 2.6 mm snap-bar channel near the bottom with a 2.0 mm entry slot underneath, 0.5 mm chamfered vertical edges
let width = 12.0; // [10.0, 16.0] Holder width (mm)
let depth = 9.0; // [7.0, 12.0] Holder depth (mm)
let height = 25.0; // [20.0, 32.0] Holder height (mm)
let screw_slot = 4.2; // [3.5, 5.0] Thumb screw slot width (mm)
let bar_d = 2.6; // [2.0, 3.2] Snap bar channel diameter (mm)
const slot_depth = 10.0;
let body = box_from_corners([-width / 2.0, -depth / 2.0, 0], [width / 2.0, depth / 2.0, height]);
let body = body.chamfer(0.5, body.edges("|Z"));
let cuts = fuse_all([
    box_from_corners([-screw_slot / 2.0, -depth, height - slot_depth + screw_slot / 2.0], [screw_slot / 2.0, depth, height + 1.0]),
    cylinder([0, -depth, height - slot_depth + screw_slot / 2.0], "Y", screw_slot / 2.0, 2.0 * depth),
    cylinder([-width, 0, 3.0], "X", bar_d / 2.0, 2.0 * width),
    box_from_corners([-width, -1.0, -1.0], [width, 1.0, 3.0]),
]);
body - cuts
