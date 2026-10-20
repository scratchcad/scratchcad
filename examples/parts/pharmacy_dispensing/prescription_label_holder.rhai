// Prescription label holder for dispensing baskets: 1.5 mm back plate taking a 70 x 35 mm label card in a 0.8 mm slot open at the top, with 3 mm side and bottom spacers under 5 mm front lips, and a 16 mm wide hook on the back with a 4.5 mm gap for the basket wire
let card_w = 70.0; // [50.0, 100.0] Card width (mm)
let card_h = 35.0; // [25.0, 60.0] Card height (mm)
let card_gap = 0.8; // [0.5, 1.5] Card slot thickness (mm)
let wire_gap = 4.5; // [3.0, 8.0] Basket wire gap (mm)
const back_t = 1.5;
const spacer = 3.0;
const lip = 5.0;
const lip_t = 1.0;
const hook_w = 16.0;
let w = card_w + 2.0 * spacer;
let h = card_h + spacer;
let x0 = -w / 2.0;
let x1 = w / 2.0;
let z1 = back_t + card_gap;
let parts = [
    box_from_corners([x0, 0, 0], [x1, h, back_t]),
    box_from_corners([x0, 0, back_t - 0.2], [x0 + spacer, h, z1]),
    box_from_corners([x1 - spacer, 0, back_t - 0.2], [x1, h, z1]),
    box_from_corners([x0, 0, back_t - 0.2], [x1, spacer, z1]),
    box_from_corners([x0, 0, z1 - 0.2], [x0 + lip, h, z1 + lip_t]),
    box_from_corners([x1 - lip, 0, z1 - 0.2], [x1, h, z1 + lip_t]),
    box_from_corners([x0, 0, z1 - 0.2], [x1, lip, z1 + lip_t]),
    box_from_corners([-hook_w / 2.0, h - 0.5, 0], [hook_w / 2.0, h + 8.0, back_t]),
    box_from_corners([-hook_w / 2.0, h + 6.5, -wire_gap - 1.5], [hook_w / 2.0, h + 8.0, 0.5]),
    box_from_corners([-hook_w / 2.0, h - 6.0, -wire_gap - 1.5], [hook_w / 2.0, h + 7.0, -wire_gap]),
];
fuse_all(parts)
