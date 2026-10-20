// Embroidery hoop outer ring, 150 mm: fits over the 162 mm inner ring, split with a screw lug for an M4 thumbscrew
let inner_od = 162.0; // [90.0, 320.0] Inner ring outside diameter (mm)
let depth = 8.0; // [6.0, 15.0] Depth (mm)
let wall = 5.0; // [3.0, 8.0] Wall (mm)
let gap = 3.0; // [1.0, 6.0] Split gap (mm)
let r = inner_od / 2.0 + 0.3;
let ring = cylinder(r + wall, depth) - cylinder([0, 0, -1], "Z", r, depth + 2.0);
let lugs = box_from_corners([r - 1.0, -10.0, 0], [r + wall + 10.0, 10.0, depth]) - cylinder([0, 0, -1], "Z", r, depth + 2.0);
let hole = cylinder([r + wall + 5.0, -12.0, depth / 2.0], "Y", 2.2, 24.0);
ring + lugs - box_from_corners([r - 2.0, -gap / 2.0, -1], [r + wall + 12.0, gap / 2.0, depth + 1.0]) - hole
