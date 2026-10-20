// Diamond kite spar cross connector: two 6 mm spar sockets crossing at 90 degrees, 25 mm long arms with 1.5 mm walls stacked 1 mm apart, and a 3 mm bridle hole
let spar = 6.0; // [4.0, 8.0] Spar diameter (mm)
let arm = 25.0; // [15.0, 35.0] Socket arm length (mm)
const wall = 1.5;
let r = spar / 2.0 + 0.15;
let a = cylinder([-arm, 0, 0], "X", r + wall, 2.0 * arm) - cylinder([-arm - 1.0, 0, 0], "X", r, 2.0 * arm + 2.0);
let b = cylinder([0, -arm, 2.0 * r + wall + 1.0], "Y", r + wall, 2.0 * arm) - cylinder([0, -arm - 1.0, 2.0 * r + wall + 1.0], "Y", r, 2.0 * arm + 2.0);
let hub = box_centered(2.0 * r + 2.0 * wall, 2.0 * r + 2.0 * wall, r + wall + 1.0).translate([0, 0, r + wall / 2.0 + 0.5]) - cylinder([-arm - 1.0, 0, 0], "X", r, 2.0 * arm + 2.0) - cylinder([0, -arm - 1.0, 2.0 * r + wall + 1.0], "Y", r, 2.0 * arm + 2.0);
a + b + hub - cylinder([arm * 0.7, 0, -r - wall - 1.0], "Z", 1.5, 2.0 * r + 2.0 * wall + 2.0)
