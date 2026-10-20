// Arrow nock for 6.2 mm shafts: 5.2 mm push-in shank 8 mm long, 7.2 mm body with a 2.8 mm string throat 6 mm deep and rounded ears
let throat = 2.8; // [2.2, 3.5] String groove width (mm)
let n = cylinder([0, 0, -8.0], "Z", 2.6, 8.1) + cylinder(3.6, 10.0) + sphere([0, 0, 10.0], 3.6);
n = n - box_centered(throat, 10.0, 7.0).translate([0, 0, 10.5]) - cylinder([0, -6, 7.5], "Y", throat / 2.0, 12.0);
n - box_centered(20, 20, 10).translate([0, 0, 17.0])
