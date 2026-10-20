// Sprayer boom fold rest buffer: polyurethane bump stop with a 38 mm round buffer 22 mm tall and a 4 mm chamfer on its striking face, on a 70 x 44 x 6 mm base with 5 mm rounded corners and two 8.5 mm bolt holes 54 mm apart for M8 bolts to the boom cradle
let buffer_d = 38.0; // [25.0, 50.0] Buffer diameter (mm)
let buffer_h = 22.0; // [10.0, 35.0] Buffer height (mm)
let base_len = 70.0; // [55.0, 100.0] Base length (mm)
let base_w = 44.0; // [30.0, 60.0] Base width (mm)
let hole_pitch = 54.0; // [40.0, 85.0] Bolt hole spacing (mm)
const base_t = 6.0;
const hole_d = 8.5;
let rb = min(buffer_d / 2.0, base_w / 2.0 - 2.0);
let hp = max(min(hole_pitch, base_len - 14.0), 2.0 * rb + hole_d + 4.0);
let bl = max(base_len, hp + 14.0);
let base = box_from_corners([-bl / 2.0, -base_w / 2.0, 0], [bl / 2.0, base_w / 2.0, base_t]);
let base = base.fillet(5.0, base.edges("|Z"));
let buffer = cylinder([0, 0, base_t - 0.5], "Z", rb, buffer_h + 0.5);
let buffer = buffer.chamfer(min(4.0, buffer_h / 3.0), buffer.edges(">Z"));
(base + buffer) - fuse_all([
    cylinder([-hp / 2.0, 0, -1.0], "Z", hole_d / 2.0, base_t + 2.0),
    cylinder([hp / 2.0, 0, -1.0], "Z", hole_d / 2.0, base_t + 2.0),
])
