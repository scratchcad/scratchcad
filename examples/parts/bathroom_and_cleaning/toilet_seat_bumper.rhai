// Toilet seat bumper buffer: 22 mm domed pad 8 mm high, 5 mm push-in stem with a barb for a 5 mm hole in the seat
let pad_d = 22.0; // [14.0, 30.0] Pad diameter (mm)
let pad_h = 8.0; // [5.0, 12.0] Pad height (mm)
let stem_d = 5.0; // [3.5, 7.0] Stem diameter (mm)
let stem_l = 9.0; // [6.0, 14.0] Stem length (mm)
let r = pad_d / 2.0;
let dome_r = (r * r + pad_h * pad_h) / (2.0 * pad_h) + 2.0;
let pad = sphere([0, 0, pad_h - dome_r], dome_r) & cylinder(r, pad_h);
let sr = stem_d / 2.0;
let stem = cylinder([0, 0, -stem_l], "Z", sr, stem_l + 1.0);
let barb = cone(sr * 0.8, sr * 1.7, 4.0).translate([0, 0, -stem_l - 1.0]);
pad + stem + barb
