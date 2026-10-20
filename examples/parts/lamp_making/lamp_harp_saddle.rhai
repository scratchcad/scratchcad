// Lamp harp saddle: 1/8 IPS (10 mm) threaded nipple hole in a 30 x 12 x 3 mm bridge with two 5 mm harp-leg sockets 8 mm deep on 50 mm centres
let span = 50.0; // [35.0, 70.0] Harp leg spacing (mm)
let leg = 5.0; // [3.0, 7.0] Harp leg wire diameter (mm)
const t = 3.0;
let bridge = box_centered(span + 16.0, 12.0, t).translate([0, 0, t / 2.0]);
let sockets = cylinder([-span / 2.0, 0, 0], "Z", leg / 2.0 + 2.5, 10.0) + cylinder([span / 2.0, 0, 0], "Z", leg / 2.0 + 2.5, 10.0);
bridge + sockets - cylinder([0, 0, -1.0], "Z", 5.1, t + 2.0) - cylinder([-span / 2.0, 0, 2.0], "Z", leg / 2.0 + 0.1, 9.0) - cylinder([span / 2.0, 0, 2.0], "Z", leg / 2.0 + 0.1, 9.0)
