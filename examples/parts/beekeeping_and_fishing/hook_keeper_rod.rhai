// Rod hook keeper: snaps on an 8 to 10 mm blank, 2 mm wire-style eye 5 mm, 12 mm wide band 1 mm
let blank = 9.0; // [6.0, 14.0] Blank diameter (mm)
let band_w = 12.0; // [8.0, 18.0] Band width (mm)
let t = 1.2; // [0.8, 2.0] Band thickness (mm)
let r = blank / 2.0;
let band = cylinder(r + t, band_w) - cylinder([0, 0, -1], "Z", r, band_w + 2.0) - box_from_corners([-r * 0.6, -r - t - 1.0, -1], [r * 0.6, -r * 0.3, band_w + 1.0]);
let post = box_from_corners([-1.0, r + t - 0.1, band_w / 2.0 - 1.0], [1.0, r + t + 5.0, band_w / 2.0 + 1.0]);
let eye = cylinder([-1.0, r + t + 7.0, band_w / 2.0], "X", 3.0, 2.0) - cylinder([-1.5, r + t + 7.0, band_w / 2.0], "X", 1.5, 3.0);
band + post + eye
