// Dinghy rudder gudgeon: 6.4 mm eye for a 6 mm pintle in a 14 mm boss 12 mm tall, 60 x 25 mm strap 3 mm
let pin = 6.4; // [5.2, 10.5] Eye bore (mm)
let length = 60.0; // [40.0, 80.0] Strap length (mm)
let width = 25.0; // [18.0, 35.0] Strap width (mm)
let t = 3.0; // [2.0, 5.0] Strap thickness (mm)
let strap = box_from_corners([0, -width / 2.0, 0], [length, width / 2.0, t]);
let s = strap.fillet(width / 2.0 - 0.5, strap.edges("|Z and >X"));
let boss = cylinder([-12.0, 0, 0], "Z", 7.0, 12.0) + box_from_corners([-12.0, -7.0, 0], [0.01, 7.0, t]);
s + boss - cylinder([-12.0, 0, -1], "Z", pin / 2.0, 14.0) - cylinder([20.0, 0, -1], "Z", 2.25, t + 2.0) - cylinder([45.0, 0, -1], "Z", 2.25, t + 2.0)
