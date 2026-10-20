// Crochet hook, 5 mm (US H-8): 150 mm long, 5 mm shaft, throat cut 2 mm deep, flat 12 mm thumb rest
let shaft_d = 5.0; // [2.0, 10.0] Hook size (mm)
let length = 150.0; // [120.0, 180.0] Length (mm)
let r = shaft_d / 2.0;
let shaft = cylinder([0, 0, 0], "X", r, length - r) + sphere([length - r, 0, 0], r);
let throat = box_from_corners([length - 9.0, -r - 1.0, r * 0.15], [length - 4.0, r + 1.0, r + 1.0]).rotate([length - 9.0, 0, r * 0.15], "Y", -15.0);
let rest = box_from_corners([55.0, -6.0, -1.2], [75.0, 6.0, 1.2]);
let thumb = rest.fillet(1.0, rest.edges("|Z"));
shaft - throat + thumb
