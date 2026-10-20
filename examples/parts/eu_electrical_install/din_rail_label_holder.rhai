// DIN rail label holder strip: 72 mm (4 modules of 18 mm), 9 mm tall card channel 0.8 mm, snaps on a 45 mm cut-out edge
let modules = 4; // [1, 12] Number of 18 mm modules
let height = 9.0; // [6.0, 14.0] Label height (mm)
let length = modules.to_float() * 18.0;
let back = box_from_corners([0, 0, 0], [length, 1.5, height + 3.0]);
let front = box_from_corners([0, -2.3, 0], [length, -0.8, height + 3.0]) - box_from_corners([2.0, -3.0, 2.0], [length - 2.0, -0.7, height + 1.0]);
let bottom = box_from_corners([0, -2.3, 0], [length, 1.5, 1.5]);
let clip = box_from_corners([0, 1.49, height + 1.5], [length, 4.0, height + 3.0]) + box_from_corners([0, 3.0, height - 3.0], [length, 4.0, height + 3.0]);
back + front + bottom + clip
