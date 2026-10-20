// Garden cart tipping bed latch: 50 mm lever 15 mm wide 5 mm thick with a 6 mm pivot hole, a hooked catch 8 mm deep for a 10 mm pin and a 12 mm thumb tab
let lever = 50.0; // [35.0, 80.0] Lever length (mm)
let pin = 10.0; // [6.0, 14.0] Catch pin diameter (mm)
const t = 5.0;
let l = box_from_corners([0, -7.5, 0], [lever, 7.5, t]) + cylinder([0, 0, 0], "Z", 7.5, t);
let hook = box_from_corners([lever - pin - 6.0, 6.5, 0], [lever, 7.5 + 8.0 + 3.0, t]) - cylinder([lever - pin / 2.0 - 3.0, 7.5 + 4.0, -1.0], "Z", pin / 2.0 + 0.3, t + 2.0) - box_from_corners([lever - pin - 3.3, 7.5 + 4.0, -1.0], [lever - 2.7, 30.0, t + 1.0]);
let tab = box_from_corners([-4.0, -7.5 - 12.0, 0], [4.0, -6.5, t]);
l + hook + tab - cylinder([0, 0, -1.0], "Z", 3.0, t + 2.0)
