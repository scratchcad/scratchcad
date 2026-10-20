// Irrigation stake dripper: 140 mm stake, cross section 10 mm, 4 mm barb, adjustable cap seat
let length = 140.0; // [80.0, 200.0] Stake length (mm)
let vane = 10.0; // [6.0, 14.0] Vane width (mm)
let v = box_centered(vane, 2.0, length).translate([0, 0, length / 2.0]) + box_centered(2.0, vane, length).translate([0, 0, length / 2.0]);
let tip = cone(vane, 0.0, 30.0).rotate_x(180.0).translate([0, 0, 30.0]) + cylinder([0, 0, 29.99], "Z", vane, length);
let stake = v & tip;
let head = cylinder([0, 0, length - 0.01], "Z", 8.0, 12.0) - cylinder([0, 0, length + 4.0], "Z", 5.0, 10.0);
let barb = cylinder([0, 0, length + 3.0], "X", 2.0, 15.0) + cone(2.6, 1.6, 4.0).rotate_y(90.0).translate([14.0, 0, length + 3.0]);
stake + head + barb - cylinder([0, 0, length + 3.0], "X", 1.0, 19.0)
