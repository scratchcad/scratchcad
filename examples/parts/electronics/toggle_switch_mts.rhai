// MTS-102 mini toggle switch: 13 x 8 x 10 mm body, 6 mm threaded bushing 9 mm long, 11 mm lever tilted 12 degrees
let body_w = 13.0; // [8.0, 20.0] Body width (mm)
let body_d = 8.0; // [6.0, 14.0] Body depth (mm)
let body_h = 10.0; // [8.0, 16.0] Body height (mm)
let bushing_d = 6.0; // [5.0, 12.0] Bushing diameter (mm)
let lever_l = 11.0; // [6.0, 20.0] Lever length (mm)
let body = box_centered(body_w, body_d, body_h).translate([0, 0, -body_h / 2.0]);
let bushing = cylinder(bushing_d / 2.0, 9.0) - cylinder([0, 0, 5.0], "Z", 1.8, 5.0);
let lever = (cylinder(1.0, lever_l) + cone(1.0, 1.4, 1.5).translate([0, 0, lever_l - 0.01])).rotate_y(12).translate([0, 0, 5.0]);
let lugs = [];
for x in [-4.7, 0.0, 4.7] { lugs.push(box_centered(1.5, 0.5, 4.0).translate([x, 0, -body_h - 2.0]) - cylinder([x, -1, -body_h - 3.0], "Y", 0.5, 2.0)); }
fuse_all([body, bushing, lever] + lugs)
