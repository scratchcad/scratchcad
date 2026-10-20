// TO-220 package: 10 x 4.5 x 9.2 mm body, 1.3 mm tab 6.3 mm above with a 3.6 mm hole, three leads at 2.54 mm
let width = 10.0; // [9.5, 10.5] Body width (mm)
let body_h = 9.2; // [8.5, 9.5] Body height (mm)
let body_t = 4.5; // [4.2, 4.8] Body thickness (mm)
let body = box_centered(width, body_t, body_h).translate([0, 0, body_h / 2.0]);
let tab = box_centered(width, 1.3, 6.3 + 0.1).translate([0, -body_t / 2.0 + 0.65, body_h + 3.15 - 0.05]) - cylinder([0, -5, body_h + 2.8], "Y", 1.8, 10.0);
let leads = [];
for x in [-2.54, 0.0, 2.54] { leads.push(box_centered(0.8, 0.5, 13.0).translate([x, 0, -6.5]) + box_centered(1.4, 0.5, 2.0).translate([x, 0, -1.0])); }
fuse_all([body, tab] + leads)
