// Neoprene cloning collar for a 2 inch net pot: 51 mm disc 12.7 mm thick (1/2 inch) with a 6 mm stem hole in the middle and a 1 mm slit from the hole to the edge to slip the cutting in
let collar_d = 51.0; // [38.0, 76.0] Collar diameter (mm)
let thickness = 12.7; // [6.0, 20.0] Collar thickness (mm)
let stem_hole = 6.0; // [2.0, 12.0] Stem hole diameter (mm)
let slit_w = 1.0; // [0.5, 2.0] Slit width (mm)
let r = collar_d / 2.0;
let disc = cylinder([0, 0, 0], "Z", r, thickness);
let disc = disc.chamfer(0.8, disc.edges("%CIRCLE"));
let hr = min(stem_hole / 2.0, r / 3.0);
let cut = cylinder([0, 0, -1.0], "Z", hr, thickness + 2.0) + box_from_corners([0, -slit_w / 2.0, -1.0], [r + 1.0, slit_w / 2.0, thickness + 1.0]);
disc - cut
