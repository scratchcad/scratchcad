// Bobbin case latch lever for a class 15 bobbin case: 16 x 7 x 1 mm steel blade with 3.5 mm rounded ends, 3.2 mm hole over the centre stud, 1.4 mm rivet hole, 4 mm wide finger tab rising 3 mm at the free end
let length = 16.0; // [13.0, 20.0] Latch length (mm)
let width = 7.0; // [6.0, 9.0] Latch width (mm)
let thickness = 1.0; // [0.6, 1.5] Blade thickness (mm)
let tab_h = 3.0; // [2.0, 4.5] Finger tab height (mm)
const stud = 3.2;
const rivet = 1.4;
let blade = box_from_corners([0, -width / 2.0, 0], [length, width / 2.0, thickness]);
let blade = blade.fillet(width / 2.0 - 0.1, blade.edges("|Z and <X"));
let tab = box_from_corners([length - 1.2, -2.0, 0], [length, 2.0, thickness + tab_h]);
let latch = blade + tab;
latch - fuse_all([
    cylinder([width / 2.0, 0, -1.0], "Z", stud / 2.0, thickness + 2.0),
    cylinder([width / 2.0 + 4.5, 0, -1.0], "Z", rivet / 2.0, thickness + 2.0),
])
