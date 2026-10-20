// HK0810 drawn cup needle roller bearing: 8 mm shaft, 12 mm OD, 10 mm long, 12 needles of 2 mm
let shaft = 8.0; // [3.0, 10.5] Shaft diameter (mm)
let outer = 12.0; // [9.8, 50.0] Outside diameter (mm)
let length = 10.0; // [6.0, 30.0] Length (mm)
let needles = 12; // [10, 23] Number of needles
let cup_wall = 0.5;
let cup = (cylinder(outer / 2.0, length) - cylinder([0, 0, cup_wall], "Z", outer / 2.0 - cup_wall, length - 2.0 * cup_wall)) - cylinder([0, 0, -1], "Z", shaft / 2.0 + 0.6, length + 2.0);
let needle_d = (outer / 2.0 - cup_wall - shaft / 2.0) * 0.98;
let r = shaft / 2.0 + needle_d / 2.0;
let parts = [cup];
for i in 0..needles { parts.push(cylinder([r, 0, cup_wall + 0.3], "Z", needle_d / 2.0 * 0.95, length - 2.0 * cup_wall - 0.6).rotate_z(i * 360.0 / needles.to_float())); }
compound(parts)
