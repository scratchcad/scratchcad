// 12 kg kettlebell: 180 mm ball flattened at the base, 33 mm handle loop 140 mm wide rising 90 mm above the ball
let d = 180.0; // [150.0, 230.0] Bell diameter (mm)
let r = d / 2.0;
let bell = sphere([0, 0, r - 12.0], r) - box_centered(2.0 * d, 2.0 * d, 20.0).translate([0, 0, -10.0]);
let handle = (torus(55.0, 16.5).rotate_x(90.0).translate([0, 0, 2.0 * r - 12.0]) & box_centered(200.0, 60.0, 200.0).translate([0, 0, 2.0 * r - 12.0 + 100.0 - 60.0])) + cylinder([-55.0, 0, r], "Z", 16.5, r - 52.0) + cylinder([55.0, 0, r], "Z", 16.5, r - 52.0);
bell + handle
