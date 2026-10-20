// Oldham coupling center disc: 30 mm, 12 mm thick, perpendicular 6 x 3 mm tongues on each face
let diameter = 30.0; // [20.0, 60.0] Diameter (mm)
let thickness = 6.0; // [4.0, 12.0] Disc thickness (mm)
let tongue_w = 6.0; // [3.0, 12.0] Tongue width (mm)
let tongue_h = 3.0; // [2.0, 6.0] Tongue height (mm)
let disc = cylinder([0, 0, -thickness / 2.0], "Z", diameter / 2.0, thickness);
let t1 = box_centered(diameter, tongue_w, tongue_h * 2.0).translate([0, 0, thickness / 2.0]) & cylinder([0, 0, -20], "Z", diameter / 2.0, 40.0);
let t2 = box_centered(tongue_w, diameter, tongue_h * 2.0).translate([0, 0, -thickness / 2.0]) & cylinder([0, 0, -20], "Z", diameter / 2.0, 40.0);
disc + t1 + t2 - cylinder([0, 0, -20], "Z", 2.0, 40.0)
