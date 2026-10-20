// Cubicle door rising hinge cam (one half of the pair): 22 mm round cam 20 mm tall with an 8.2 mm pin bore, a ramp face cut as two flat 8 mm rises meeting at a ridge so the door lifts and self-closes, and a 6 x 6 mm square locating lug 5 mm long underneath
let cam_d = 22.0; // [16.0, 32.0] Cam diameter (mm)
let cam_h = 20.0; // [14.0, 30.0] Cam height (mm)
let rise = 8.0; // [3.0, 10.0] Ramp rise (mm)
let pin_d = 8.2; // [5.0, 12.0] Pin bore diameter (mm)
let r = cam_d / 2.0;
let pr = min(pin_d / 2.0, r - 3.0);
let rs = min(rise, cam_h - 6.0);
let body = cylinder([0, 0, 0], "Z", r, cam_h);
let lug = box_centered(6.0, 6.0, 5.5).translate([r - 1.0, 0, -2.25]);
let lug = lug & cylinder([0, 0, -6.0], "Z", r, 6.5);
let w = r + 2.0;
let ramp = face(polygon([[-w, 0, cam_h - rs], [0, 0, cam_h], [w, 0, cam_h - rs], [w, 0, cam_h + 1.0], [-w, 0, cam_h + 1.0]])).extrude([0, 2.0 * w, 0]).translate([0, -w, 0]);
(body + lug) - ramp - cylinder([0, 0, -7.0], "Z", pr, cam_h + 8.0)
