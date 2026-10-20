// Bottle neck carry loop for 28 mm PCO necks: 33 mm ring, 2 mm thick, 40 mm loop for a carabiner
let neck = 33.0; // [25.0, 45.0] Neck ring bore (mm)
let loop_l = 40.0; // [25.0, 60.0] Loop length (mm)
let thickness = 2.5; // [1.5, 4.0] Thickness (mm)
let ring = cylinder(neck / 2.0 + 4.0, thickness) - cylinder([0, 0, -1], "Z", neck / 2.0, thickness + 2.0);
let loop_outer = box_from_corners([neck / 2.0, -9.0, 0], [neck / 2.0 + loop_l, 9.0, thickness]);
let lo = loop_outer.fillet(8.9, loop_outer.edges("|Z and >X"));
let li = box_from_corners([neck / 2.0 + 5.0, -5.0, -1], [neck / 2.0 + loop_l - 4.0, 5.0, thickness + 1.0]);
let lii = li.fillet(4.9, li.edges("|Z and >X"));
ring + lo - lii - cylinder([0, 0, -1], "Z", neck / 2.0, thickness + 2.0)
