// Woodruff key DIN 6888, 5 x 6.5: 5 mm wide, 6.5 mm tall, cut from a 16 mm diameter disc (15.7 mm chord), small edge chamfers
let key_width = 5.0; // [1.5, 10.0] Key width (mm)
let key_height = 6.5; // [2.0, 16.0] Key height (mm)
let disc_diameter = 16.0; // [5.0, 45.0] Disc diameter (mm)
let r = disc_diameter / 2.0;
let h = min(key_height, disc_diameter * 0.9);
let disc = cylinder([0, -key_width / 2.0, r], "Y", r, key_width);
let keep = box_from_corners([-r - 1.0, -key_width, -1.0], [r + 1.0, key_width, h]);
let key = disc & keep;
let chord = 2.0 * sqrt(r * r - (h - r) * (h - r));
print(`chord length ${chord}`);
key.chamfer(0.2)
