// 100 ml volumetric flask: 60 mm bulb flattened at the base, 14 mm neck to 150 mm with a calibration ring, 1.5 mm wall
let bulb = 60.0; // [30.0, 96.0] Bulb diameter (mm)
let h = 150.0; // [108.0, 300.0] Height (mm)
let R = bulb / 2.0;
let outer = (sphere([0, 0, R - 3.0], R) - box_centered(3.0 * R, 3.0 * R, 10.0).translate([0, 0, -5.0])) + cylinder([0, 0, R], "Z", 7.0, h - R);
let inner = (sphere([0, 0, R - 3.0], R - 1.5) - box_centered(3.0 * R, 3.0 * R, 10.0).translate([0, 0, -3.5])) + cylinder([0, 0, R], "Z", 5.5, h);
fuse_all([outer - inner, torus(7.0, 0.4).translate([0, 0, h - 40.0]), torus(7.0, 1.0).translate([0, 0, h])]) - cylinder([0, 0, h - 5.0], "Z", 5.5, 20.0)
