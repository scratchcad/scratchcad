// Feed scoop, 1 kg: 110 mm wide flat-front scoop, 180 mm long, 1.5 mm wall, 110 mm handle
let width = 110.0; // [80.0, 150.0] Scoop width (mm)
let length = 180.0; // [130.0, 250.0] Scoop length (mm)
let wall = 1.8; // [1.2, 3.0] Wall (mm)
let r = width / 2.0;
let body = cylinder([0, 0, 0], "X", r, length) & box_from_corners([-1, -r - 1.0, -r - 1.0], [length + 1.0, r + 1.0, r * 0.4]);
let solid_ = body + sphere([0, 0, 0], r) & box_from_corners([-r - 1.0, -r - 1.0, -r - 1.0], [length + 1.0, r + 1.0, r * 0.4]);
let shell = solid_ - (cylinder([0, 0, 0], "X", r - wall, length + 1.0) + sphere([0, 0, 0], r - wall));
let handle = cylinder([-r - 105.0, 0, -5.0], "X", 14.0, 110.0) - cylinder([-r - 106.0, 0, -5.0], "X", 11.0, 100.0);
shell + handle
