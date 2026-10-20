// Bathtub lift-and-turn drain stopper: 40 mm domed cap 7 mm high, 16 mm knob 11 mm tall, 5/16 in (8 mm) threaded post 25 mm, gasket groove underneath
let cap_d = 40.0; // [34.0, 50.0] Cap diameter (mm)
let cap_h = 7.0; // [5.0, 10.0] Cap height at the centre (mm)
let knob_d = 16.0; // [12.0, 22.0] Knob diameter (mm)
let knob_h = 11.0; // [8.0, 15.0] Knob height (mm)
let post_l = 25.0; // [15.0, 40.0] Post length (mm)
let r = cap_d / 2.0;
const rise = 3.0;
let sr = (r * r + rise * rise) / (2.0 * rise);
let cap = sphere([0, 0, cap_h - sr], sr) & cylinder(r, cap_h);
let knob = cylinder([0, 0, cap_h - 1.0], "Z", knob_d / 2.0, knob_h + 1.0);
let k = knob.chamfer(1.0, knob.edges(">Z"));
let post = cylinder([0, 0, -post_l], "Z", 4.0, post_l + 1.0);
let groove = cylinder([0, 0, -1], "Z", r - 2.0, 2.5) - cylinder([0, 0, -2], "Z", r - 5.0, 4.0);
cap + k + post - groove
