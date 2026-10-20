// Adjustable Z endstop flag that clamps on an 8 mm smooth rod: 20 x 16 x 10 mm clamp block with an 8.1 mm bore, 1.5 mm split and M3 clamp screw, 25 mm arm 10 mm wide 3 mm thick ending in an M3 adjusting screw hole 2.6 mm (self-tapping)
let rod = 8.1; // [6.1, 12.1] Rod bore (mm)
let arm_l = 25.0; // [15.0, 40.0] Arm length (mm)
let block_h = 10.0; // [8.0, 16.0] Clamp height (mm)
let arm_t = 3.0; // [2.0, 5.0] Arm thickness (mm)
const arm_w = 10.0;
let rr = rod / 2.0;
let bw = rod + 8.0;
let bl = rod + 12.0;
let block = box_from_corners([-bw / 2.0, -bw / 2.0, 0], [bl - bw / 2.0, bw / 2.0, block_h]);
block = block.fillet(2.0, "|Z");
let arm = box_from_corners([-arm_w / 2.0, bw / 2.0 - 0.5, 0], [arm_w / 2.0, bw / 2.0 + arm_l, arm_t]);
arm = arm.fillet(arm_w / 2.0 - 0.5, arm.edges("|Z and >Y"));
let flag = block + arm;
let cuts = fuse_all([
    cylinder([0, 0, -1], "Z", rr, block_h + 2.0),
    box_from_corners([0, -0.75, -1], [bl, 0.75, block_h + 1.0]),
    cylinder([rr + 4.0, -bw, block_h / 2.0], "Y", 1.6, 2.0 * bw),
    cylinder([0, bw / 2.0 + arm_l - arm_w / 2.0 + 0.5, -1], "Z", 1.3, arm_t + 2.0)]);
flag - cuts
