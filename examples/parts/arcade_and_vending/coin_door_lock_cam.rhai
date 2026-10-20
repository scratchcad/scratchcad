// Coin door lock cam: 45 x 18 mm cam 3 mm thick with a 16 x 12 mm double-D hole for a cam lock spindle and a 12 mm rounded tip
let length = 45.0; // [30.0, 60.0] Cam length (mm)
let flats = 12.0; // [9.0, 14.0] Spindle across flats (mm)
const t = 3.0;
let cam = box_from_corners([9.0, -9.0, 0], [length - 6.0, 9.0, t]) + cylinder([9.0, 0, 0], "Z", 9.0, t) + cylinder([length - 6.0, 0, 0], "Z", 6.0, t) + box_from_corners([9.0, -9.0, 0], [length - 6.0, 6.0, t]);
let hole = cylinder([9.0, 0, -1.0], "Z", 8.0, t + 2.0) & box_centered(flats, 20.0, t + 4.0).translate([9.0, 0, t / 2.0]);
cam - hole
