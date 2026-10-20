// DIN 471 external retaining ring for a 10 mm shaft: 9.3 mm free ID, 1 mm thick, lug holes 1 mm
let shaft = 10.0; // [6.0, 50.0] Shaft diameter (mm)
let thickness = 1.0; // [0.6, 2.5] Thickness (mm)
let width = 1.8; // [1.0, 5.0] Ring width (mm)
let inner_r = shaft * 0.93 / 2.0;
let ring = cylinder(inner_r + width, thickness) - cylinder([0, 0, -1], "Z", inner_r, thickness + 2.0);
let lugs = cylinder([inner_r + width * 0.8, 1.6, 0], "Z", 1.6, thickness) + cylinder([inner_r + width * 0.8, -1.6, 0], "Z", 1.6, thickness);
let open = box_centered(inner_r * 2.0, 1.2, thickness + 2.0).translate([inner_r, 0, thickness / 2.0]);
let holes = cylinder([inner_r + width * 0.8, 1.6, -1], "Z", 0.5, thickness + 2.0) + cylinder([inner_r + width * 0.8, -1.6, -1], "Z", 0.5, thickness + 2.0);
(ring + lugs) - open - holes
