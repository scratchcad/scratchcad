// Manual butterfly volume damper for 6 in (150 mm) round duct: 0.8 mm duct section 150 mm long, 146 mm blade at 30 degrees on a 3/8 in (9.5 mm) square rod, hand lever outside
let duct_d = 150.0; // [80.0, 300.0] Duct diameter (mm)
let length = 150.0; // [80.0, 300.0] Section length (mm)
let blade_angle = 30.0; // [0.0, 90.0] Blade angle from closed (degrees)
const wall = 0.8;
const rod = 9.5;
let r = duct_d / 2.0;
let zc = length / 2.0;
let duct = cylinder(r + wall, length) - cylinder([0, 0, -1], "Z", r, length + 2.0);
duct -= cylinder([-r - 5.0, 0, zc], "X", rod * 0.75, duct_d + 10.0);
let blade = cylinder([0, 0, -0.75], "Z", r - 2.0, 1.5).rotate_x(90.0 - blade_angle);
let shaft = box_centered(duct_d + 40.0, rod, rod);
let lever = box_from_corners([r + 12.0, -6.0, -1.5], [r + 18.0, 60.0, 1.5]).rotate([r + 15.0, 0, 0], "X", 90.0 - blade_angle);
let moving = fuse_all([blade, shaft, lever]).translate([0, 0, zc]);
compound([duct, moving])
