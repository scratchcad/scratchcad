// ATO / mini blade fuse puller: 50 mm long tweezer, 8 mm wide, 2.5 mm arms with a 6 mm jaw gap closing to 4 mm hooks at the tips, ribbed grip
let length = 50.0; // [35.0, 70.0] Length (mm)
let width = 8.0; // [5.0, 12.0] Width (mm)
let arm = 2.5; // [1.5, 4.0] Arm thickness (mm)
let gap = 6.0; // [4.0, 9.0] Jaw gap (mm)
let hook_gap = 4.0; // [2.0, 6.0] Gap between the hooks (mm)
let grip_ribs = 5; // [0, 10] Number of grip ribs per side
let hg = min(hook_gap, gap - 0.5);
let g = gap / 2.0;
let back = box_from_corners([0, -g - arm, 0], [6.0, g + arm, width]);
let arm_top = box_from_corners([0, g, 0], [length, g + arm, width]);
let arm_bot = box_from_corners([0, -g - arm, 0], [length, -g, width]);
let hook_top = box_from_corners([length - 4.0, hg / 2.0, 0], [length, g + 0.5, width]);
let hook_bot = box_from_corners([length - 4.0, -g - 0.5, 0], [length, -hg / 2.0, width]);
let parts = [back, arm_top, arm_bot, hook_top, hook_bot];
for i in 0..grip_ribs {
    let x = 14.0 + i.to_float() * 4.0;
    parts.push(box_from_corners([x, g + arm - 0.1, 0], [x + 1.5, g + arm + 0.8, width]));
    parts.push(box_from_corners([x, -g - arm - 0.8, 0], [x + 1.5, -g - arm + 0.1, width]));
}
let puller = fuse_all(parts);
puller - cylinder([3.0, 0, -1.0], "Z", 1.0, width + 2.0)
