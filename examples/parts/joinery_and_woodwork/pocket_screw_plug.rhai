// Pocket hole plug for a 3/4 in board: 9.5 mm round, 15 degree angled face, 30 mm long
let d = 9.5; // [8.0, 12.0] Plug diameter (mm)
let length = 30.0; // [20.0, 40.0] Length (mm)
let angle = 15.0; // [10.0, 20.0] Pocket angle (degrees)
let plug = cylinder(d / 2.0, length);
let cut = box_centered(d * 4.0, d * 4.0, d * 4.0).translate([0, 0, length + d * 2.0]).rotate([0, 0, length], "X", 90.0 - angle);
plug - cut
