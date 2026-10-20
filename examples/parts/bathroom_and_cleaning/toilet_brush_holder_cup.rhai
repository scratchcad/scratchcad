// Toilet brush holder cup: 100 mm OD x 120 mm tall, 2.5 mm wall, 4 mm base, raised 50 mm drip ring 10 mm tall with 6 drain notches, 104 mm foot ring
let od = 100.0; // [80.0, 130.0] Cup outside diameter (mm)
let height = 120.0; // [90.0, 160.0] Cup height (mm)
let wall = 2.5; // [1.8, 4.0] Wall thickness (mm)
let ring_d = 50.0; // [35.0, 70.0] Drip ring diameter (mm)
let r = od / 2.0;
let cup = cylinder(r, height) - cylinder([0, 0, 4.0], "Z", r - wall, height);
let foot = cylinder(r + 2.0, 3.0);
let f = foot.chamfer(1.0, foot.edges("<Z"));
let ring = cylinder([0, 0, 3.9], "Z", ring_d / 2.0, 10.1) - cylinder([0, 0, 3.0], "Z", ring_d / 2.0 - 2.0, 12.0);
let notches = [];
for i in 0..6 { notches.push(box_from_corners([ring_d / 2.0 - 4.0, -2.0, 4.0], [ring_d / 2.0 + 1.0, 2.0, 7.0]).rotate_z(i.to_float() * 60.0)); }
cup + f + ring - compound(notches)
