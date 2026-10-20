// Ladle hook clip for a 16 mm round utensil rail: 10 mm wide snap ring with 3 mm wall and a top snap opening, 30 mm stem and a J hook with a 12 mm lip for ladle handles
let rail_d = 16.0; // [12.0, 25.0] Rail diameter (mm)
let stem = 30.0; // [15.0, 60.0] Stem length (mm)
let hook_depth = 16.0; // [10.0, 25.0] Hook depth (mm)
const wall = 3.0;
const width = 10.0;
let ri = rail_d / 2.0 + 0.2;
let ro = ri + wall;
let ring = cylinder([-width / 2.0, 0, 0], "X", ro, width) - cylinder([-width / 2.0 - 1.0, 0, 0], "X", ri, width + 2.0);
ring = ring - box_from_corners([-width, -rail_d * 0.4, 0], [width, rail_d * 0.4, ro + 1.0]);
let zb = -(ro + stem);
let hook = fuse_all([
    box_from_corners([-width / 2.0, -2.0, zb], [width / 2.0, 2.0, -ri - 0.5]),
    box_from_corners([-width / 2.0, -2.0, zb], [width / 2.0, hook_depth, zb + 4.0]),
    box_from_corners([-width / 2.0, hook_depth - 4.0, zb], [width / 2.0, hook_depth, zb + 12.0]),
]);
ring + hook
