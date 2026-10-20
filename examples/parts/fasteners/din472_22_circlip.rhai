// DIN 472 internal retaining ring for a 22 mm bore: 23.2 mm free OD, 1 mm thick, lugs inward
let bore = 22.0; // [14.8, 80.0] Bore diameter (mm)
let thickness = 1.0; // [0.6, 3.0] Thickness (mm)
let width = 2.2; // [1.2, 6.0] Ring width (mm)
let outer_r = bore * 1.055 / 2.0;
let ring = cylinder(outer_r, thickness) - cylinder([0, 0, -1], "Z", outer_r - width, thickness + 2.0);
let lug_r = outer_r - width - 0.8;
let lugs = cylinder([lug_r, 2.2, 0], "Z", 1.9, thickness) + cylinder([lug_r, -2.2, 0], "Z", 1.9, thickness);
let open = box_centered(width * 3.0, 1.6, thickness + 2.0).translate([outer_r - width, 0, thickness / 2.0]);
let holes = cylinder([lug_r, 2.2, -1], "Z", 0.75, thickness + 2.0) + cylinder([lug_r, -2.2, -1], "Z", 0.75, thickness + 2.0);
(ring + (lugs - cylinder([0, 0, -1], "Z", lug_r - 2.5, thickness + 2.0))) - open - holes
