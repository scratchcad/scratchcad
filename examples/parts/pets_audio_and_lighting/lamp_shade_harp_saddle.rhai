// Lamp harp saddle: 1/8 IP (10 mm) threaded hole in a 25 x 10 mm bar, two 4 mm harp sockets 63 mm apart
let span = 63.0; // [50.0, 90.0] Socket spacing (mm)
let bar = box_centered(span + 12.0, 10.0, 6.0).fillet(2.0, "|Z") + cylinder([0, 0, -3.0], "Z", 7.0, 6.0);
bar = bar - cylinder([0, 0, -5], "Z", 5.1, 10.0);
for x in [-span / 2.0, span / 2.0] { bar = bar + cylinder([x, 0, 3.0], "Z", 3.5, 8.0) - cylinder([x, 0, 3.5], "Z", 2.05, 8.0); }
bar
