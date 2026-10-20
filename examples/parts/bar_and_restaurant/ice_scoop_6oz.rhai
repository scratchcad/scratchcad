// Bar ice scoop, 6 oz: 140 mm long, 75 mm wide half-round 1.8 mm wall, closed back, 100 mm handle
let length = 140.0; // [100.0, 200.0] Scoop length (mm)
let width = 75.0; // [55.0, 100.0] Scoop width (mm)
let wall = 1.8; // [1.2, 3.0] Wall (mm)
let r = width / 2.0;
let outer = cylinder([0, 0, 0], "X", r, length) & box_from_corners([-1, -r - 1.0, -r - 1.0], [length + 1.0, r + 1.0, r * 0.3]);
let inner = cylinder([wall, 0, 0], "X", r - wall, length) & box_from_corners([wall, -r, -r], [length + 2.0, r, r]);
let mouth = box_centered(width, width * 2.0, width * 2.0).translate([length + width / 2.0 - 15.0, 0, 0]).rotate([length - 15.0, 0, r * 0.3], "Y", 30.0);
let handle = cylinder([-100.0, 0, -8.0], "X", 10.0, 100.01);
outer - inner - mouth + handle
