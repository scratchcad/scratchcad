// 16 x 150 mm borosilicate test tube: hemispherical bottom, 1 mm wall, beaded rim
let d = 16.0; // [8.0, 30.0] Outer diameter (mm)
let len = 150.0; // [50.0, 200.0] Length (mm)
let r = d / 2.0;
let outer = cylinder([0, 0, r], "Z", r, len - r) + sphere([0, 0, r], r);
let inner = cylinder([0, 0, r], "Z", r - 1.0, len) + sphere([0, 0, r], r - 1.0);
(outer - inner) + torus(r, 0.6).translate([0, 0, len - 0.3])
