// Pottery trimming tool handle: 150 mm, 16 mm grip, 6 x 1.5 mm loop-blade slot 12 mm deep each end
let length = 150.0; // [120.0, 200.0] Handle length (mm)
let d = 16.0; // [12.0, 22.0] Grip diameter (mm)
let h = cylinder([0, 0, 0], "Z", d / 2.0, length);
let hh = h & (cone(5.0, d / 2.0, 30.0) + cylinder([0, 0, 29.99], "Z", d, length - 59.98) + cone(d / 2.0, 5.0, 30.0).translate([0, 0, length - 30.0]));
hh - box_centered(6.0, 1.5, 24.0) - box_centered(6.0, 1.5, 24.0).translate([0, 0, length])
