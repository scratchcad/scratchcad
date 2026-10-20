// 9 mm rotary potentiometer: 9.5 x 10 mm body, M7 bushing 5 mm, 6 mm knurled shaft 15 mm with a slot, three pins
let body_w = 9.5; // [9.0, 17.0] Body width (mm)
let body_h = 10.0; // [9.0, 20.0] Body height (mm)
let shaft_l = 15.0; // [6.0, 25.0] Shaft length (mm)
let body = box_centered(body_w, 5.0, body_h).translate([0, 2.5, body_h / 2.0]);
let bushing = cylinder([0, 0, body_h * 0.55], "Y", 3.5, 5.0).rotate_z(180);
let shaft = cylinder([0, -5.0, body_h * 0.55], "Y", 3.0, shaft_l).rotate_z(180).translate([0, 0, 0]);
let slot = box_centered(1.0, 2.0, 7.0).translate([0, -5.0 - shaft_l + 1.0, body_h * 0.55]);
let shaft2 = cylinder([0, 0, body_h * 0.55], "Y", 3.0, shaft_l).translate([0, -5.0 - shaft_l, 0]);
let pins = [];
for x in [-2.5, 0.0, 2.5] { pins.push(box_centered(1.0, 0.3, 4.0).translate([x, 4.0, -2.0])); }
fuse_all([body, cylinder([0, -5.0, body_h * 0.55], "Y", 3.5, 5.0), shaft2 - slot] + pins)
