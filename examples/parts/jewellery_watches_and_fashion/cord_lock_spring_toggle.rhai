// Spring cord lock (toggle stopper) for 4 mm cord: 12 mm body 18 mm tall with an 8 mm bore and a 4.4 mm cord hole, separate plunger with its cord hole 1.5 mm higher and a 10 mm press button
let body_diameter = 12.0; // [9.0, 18.0] Body diameter (mm)
let body_height = 18.0; // [12.0, 26.0] Body height (mm)
let cord_hole = 4.4; // [2.5, 7.0] Cord hole diameter (mm)
let button_diameter = 10.0; // [7.0, 16.0] Button diameter (mm)
let rbody = body_diameter / 2.0;
let rbore = rbody - 2.0;
let rh = min(cord_hole / 2.0, rbore - 0.6);
let zh = body_height * 0.55;
let body = cylinder(rbody, body_height).fillet(1.5, "<Z") - cylinder([0, 0, 2.0], "Z", rbore, body_height);
body = body - cylinder([-rbody - 1.0, 0, zh], "X", rh, body_diameter + 2.0);
// plunger in its released position: hole offset upwards so the cord is pinched
let rp = rbore - 0.2;
let plunger = cylinder([0, 0, 4.0], "Z", rp, body_height - 2.0) + cylinder([0, 0, body_height + 2.0], "Z", max(button_diameter / 2.0, rp + 0.5), 2.5).fillet(0.8, ">Z");
plunger = plunger + cylinder([0, 0, 2.5], "Z", 1.5, 1.6);
plunger = plunger - cylinder([-rbody, 0, zh + 1.5], "X", rh, 2.0 * rbody);
[body, plunger]
