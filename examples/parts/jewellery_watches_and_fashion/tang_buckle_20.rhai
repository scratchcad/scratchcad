// Tang (pin) buckle for a 20 mm watch strap: 25 x 18 mm frame of 3 mm bars, 1.2 mm spring-bar hole through the hinge end, and a separate 1.6 mm wide tang that pivots on the spring bar
let strap_width = 20.0; // [12.0, 26.0] Strap width (mm)
let bar = 3.0; // [2.0, 4.0] Frame bar width and height (mm)
let frame_depth = 18.0; // [14.0, 24.0] Frame depth along the strap (mm)
let tang_width = 1.6; // [1.0, 2.5] Tang width (mm)
let spring_bar = 1.2; // [0.8, 1.8] Spring bar hole diameter (mm)
let ow = strap_width + 0.5 + 2.0 * bar;
let hd = frame_depth / 2.0;
let frame = box_centered(ow, frame_depth, bar).fillet(bar, "|Z") - box_centered(strap_width + 0.5, frame_depth - 2.0 * bar, bar + 2.0).fillet(1.0, "|Z");
frame = frame.translate([0, 0, bar / 2.0]);
let yp = -hd + bar / 2.0;
// notch in the hinge bar for the tang's curl, and the spring-bar hole along X
frame = frame - box_centered(tang_width + 1.0, bar + 1.0, bar + 2.0).translate([0, yp, bar / 2.0]);
frame = frame - cylinder([-ow, yp, bar / 2.0], "X", spring_bar / 2.0, 2.0 * ow);
// tang: curl around the spring bar, then a tapered arm resting on the far bar
let rc = spring_bar / 2.0 + 0.5;
let curl = cylinder([-tang_width / 2.0, yp, bar / 2.0], "X", rc, tang_width);
let y_tip = hd - bar / 2.0 + 0.5;
let z_rest = bar + 0.05;
let slope = (z_rest - (bar / 2.0 - 0.5)) / (hd - bar - yp);
let z_tip = bar / 2.0 - 0.5 + slope * (y_tip - yp);
let arm = polygon("YZ", [[yp, bar / 2.0 - 0.5], [y_tip, z_tip], [y_tip, z_tip + 1.1], [yp, bar / 2.0 + 0.6]]).to_face().extrude([tang_width, 0, 0]).translate([-tang_width / 2.0, 0, 0]);
let tang = (curl + arm) - cylinder([-tang_width, yp, bar / 2.0], "X", spring_bar / 2.0 + 0.05, 2.0 * tang_width);
[frame, tang]
