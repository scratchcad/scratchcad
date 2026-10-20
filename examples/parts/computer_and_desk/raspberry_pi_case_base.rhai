// Raspberry Pi 4 case base: 85 x 56 mm board on 2.5 mm standoffs at 58 x 49 mm, 2 mm wall, port openings
let board_l = 85.0; // [65.0, 100.0] Board length (mm)
let board_w = 56.0; // [30.0, 70.0] Board width (mm)
let wall = 2.0; // [1.5, 3.0] Wall (mm)
let height = 20.0; // [12.0, 30.0] Base height (mm)
const gap = 1.0;
let box_ = box_from_corners([-wall - gap, -wall - gap, 0], [board_l + wall + gap, board_w + wall + gap, height]);
let shell = box_.fillet(3.0, box_.edges("|Z")) - box_from_corners([-gap, -gap, wall], [board_l + gap, board_w + gap, height + 1.0]);
let posts = [];
for p in [[3.5, 3.5], [61.5, 3.5], [3.5, 52.5], [61.5, 52.5]] { posts.push(cylinder([p[0], p[1], wall - 0.01], "Z", 3.0, 5.0) - cylinder([p[0], p[1], wall], "Z", 1.25, 6.0)); }
let usb_eth = box_from_corners([board_l - 1.0, 2.0, wall + 5.0], [board_l + wall + gap + 1.0, board_w - 2.0, height + 1.0]);
let side = box_from_corners([3.5 + 7.7 - 5.0, -wall - gap - 1.0, wall + 5.0], [3.5 + 7.7 + 14.5 + 13.5 + 14.5 + 5.0, 0.0, height + 1.0]);
shell + fuse_all(posts) - usb_eth - side
