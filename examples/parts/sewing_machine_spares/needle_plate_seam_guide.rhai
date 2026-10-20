// Magnetic seam guide for the needle plate: 40 x 22 x 3 mm base with a 10 mm tall 3 mm thick fence along one long edge, two 12.2 mm magnet pockets 2 mm deep in the underside, 1 mm rounded fence top
let length = 40.0; // [30.0, 60.0] Guide length (mm)
let base_w = 22.0; // [18.0, 30.0] Base width (mm)
let fence_h = 10.0; // [6.0, 15.0] Fence height (mm)
let magnet_d = 12.2; // [8.0, 14.0] Magnet pocket diameter (mm)
const base_t = 3.0;
const fence_t = 3.0;
const pocket = 2.0;
let base = box_from_corners([0, 0, 0], [length, base_w, base_t]);
let fence = box_from_corners([0, 0, 0], [length, fence_t, fence_h]);
let fence = fence.fillet(1.0, fence.edges(">Z and |X"));
let guide = base + fence;
let pitch = length / 4.0;
let my = fence_t + (base_w - fence_t) / 2.0;
let r = min(magnet_d / 2.0, (base_w - fence_t) / 2.0 - 1.0);
guide - fuse_all([
    cylinder([pitch, my, -1.0], "Z", r, pocket + 1.0),
    cylinder([3.0 * pitch, my, -1.0], "Z", r, pocket + 1.0),
])
