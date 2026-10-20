// Steerer tube cutting guide: block with 11 mm walls round a 28.8 mm bore (50.8 x 50.8 x 45 mm) for 1 1/8 in steerers, 1.2 mm saw slot across the middle cut from the front to 4 mm past the bore, leaving a solid back spine, M6 clamp screw hole (5 mm) from the side into the bore below the slot
let steerer_d = 28.6; // [25.4, 38.1] Steerer diameter (mm)
let height = 45.0; // [30.0, 60.0] Guide height (mm)
let slot_w = 1.2; // [0.8, 2.0] Saw slot width (mm)
const wall = 11.0;
let bore = steerer_d + 0.2;
let width = bore + 2.0 * wall;
let depth = bore + 2.0 * wall;
let block = box_centered(width, depth, height).translate([0, 0, height / 2.0]);
let block = block.chamfer(1.0, block.edges("|Z"));
let cuts = fuse_all([
    cylinder([0, 0, -1.0], "Z", bore / 2.0, height + 2.0),
    box_from_corners([-width, -depth, height / 2.0 - slot_w / 2.0], [width, bore / 2.0 + 4.0, height / 2.0 + slot_w / 2.0]),
    cylinder([-width, 0, height / 4.0], "X", 2.5, width),
]);
block - cuts
