// Wiper blade adapter for a 9 x 3 mm U-hook arm: 30 x 16 x 18 mm block, 9.4 mm wide hook channel that wraps a 3 mm radius pin, 4 mm saddle pivot hole, latch window on top
let hook_w = 9.4; // [8.0, 12.5] Hook width (mm)
let hook_t = 3.4; // [2.5, 4.5] Hook thickness (mm)
let bend_r = 3.0; // [2.0, 4.5] Hook inner bend radius (mm)
let length = 30.0; // [24.0, 40.0] Block length (mm)
let pivot = 4.0; // [3.0, 6.0] Saddle pivot hole (mm)

const side = 2.5;
const floor_t = 2.0;
let ro = bend_r + hook_t;
let zc = floor_t + ro;
let x0 = ro + 2.0;
let top = zc + ro + 2.5;
let w = hook_w + 2.0 * side;
let block = box_from_corners([0, -w / 2.0, 0], [length, w / 2.0, top]);
block = block.fillet(2.0, block.edges("|Y"));
let hw = hook_w / 2.0;
let channel = fuse_all([
    cylinder([x0, -hw, zc], "Y", ro, hook_w) - cylinder([x0, -hw - 1.0, zc], "Y", bend_r, hook_w + 2.0) - box_from_corners([x0, -hw - 1.0, zc - ro - 1.0], [x0 + ro + 1.0, hw + 1.0, zc + ro + 1.0]),
    box_from_corners([x0 - 0.5, -hw, zc + bend_r], [length + 1.0, hw, zc + ro]),
    box_from_corners([x0 - 0.5, -hw, zc - ro], [x0 + 8.0, hw, zc - bend_r])
]);
block = block - channel;
block = block - cylinder([length - pivot / 2.0 - 4.0, -w, zc], "Y", min(pivot / 2.0, bend_r - 0.5), 2.0 * w);
block - box_from_corners([x0 + 6.0, -2.5, zc + ro - 0.5], [x0 + 12.0, 2.5, top + 1.0])
