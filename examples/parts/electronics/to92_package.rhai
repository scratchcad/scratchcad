// TO-92 transistor: half-round 4.8 x 3.8 mm body 4.5 mm tall, three 0.45 mm leads at 1.27 mm
let diameter = 4.8; // [4.5, 5.2] Body diameter (mm)
let depth = 3.8; // [3.5, 4.2] Body depth (mm)
let height = 4.5; // [4.3, 5.2] Body height (mm)
let body = cylinder(diameter / 2.0, height) & box_from_corners([-diameter, diameter / 2.0 - depth, -1], [diameter, diameter, height + 1]);
let leads = [];
for x in [-1.27, 0.0, 1.27] { leads.push(box_centered(0.45, 0.4, 14.0).translate([x, 0.0, -7.0])); }
fuse_all([body] + leads)
