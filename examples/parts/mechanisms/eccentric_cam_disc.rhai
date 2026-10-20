// Eccentric cam disc: 40 mm disc, 5 mm eccentricity (10 mm lift), 10 mm thick, 8 mm bore, M4 grub screw
let diameter = 40.0; // [20.0, 80.0] Disc diameter (mm)
let ecc = 5.0; // [1.0, 15.0] Eccentricity (mm)
let thickness = 10.0; // [5.0, 20.0] Thickness (mm)
let bore = 8.0; // [4.0, 15.0] Bore (mm)
let disc = cylinder([ecc, 0, 0], "Z", diameter / 2.0, thickness);
let hub = cylinder([0, 0, thickness - 0.01], "Z", bore / 2.0 + 5.0, 8.0);
let d = disc + hub;
d - cylinder([0, 0, -1], "Z", bore / 2.0, thickness + 10.0) - cylinder([0, 0, thickness + 4.0], "X", 1.6, diameter)
