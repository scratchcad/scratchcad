// Chainring nut wrench: 100 x 16 x 4 mm handle with 8 mm rounded ends, 9.5 mm wide 1.8 mm thick blade 4.5 mm long under one end to turn slotted chainring nuts, 5 mm hang hole at the other end
let length = 100.0; // [70.0, 130.0] Handle length (mm)
let width = 16.0; // [12.0, 20.0] Handle width (mm)
let blade_w = 9.5; // [8.0, 11.0] Blade width (mm)
let blade_t = 1.8; // [1.5, 2.2] Blade thickness (mm)
const thickness = 4.0;
const blade_len = 4.5;
let handle = box_from_corners([0, -width / 2.0, 0], [length, width / 2.0, thickness]);
let handle = handle.fillet(width / 2.0 - 0.5, handle.edges("|Z"));
let blade = box_from_corners([8.0 - blade_t / 2.0, -blade_w / 2.0, -blade_len], [8.0 + blade_t / 2.0, blade_w / 2.0, 0.5]);
(handle + blade) - cylinder([length - 8.0, 0, -1.0], "Z", 2.5, thickness + 2.0)
