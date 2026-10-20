// Tripod leg foot: fits a 22 mm leg tube, 30 mm rubber-style dome foot with 5 rings and a 3/8-16 threaded 25 mm spike stub
let leg = 22.0; // [16.0, 32.0] Leg tube OD (mm)
let foot = 30.0; // [22.0, 40.0] Foot diameter (mm)
let sleeve = cylinder(leg / 2.0 + 2.5, 25.0) - cylinder([0, 0, 5.0], "Z", leg / 2.0, 25.0);
let dome = cone(foot / 2.0, leg / 2.0 + 2.5, 10.0).translate([0, 0, -10.0 + 0.01]);
let rings = [];
for k in 0..5 { rings.push(cylinder([0, 0, -9.0 + k.to_float() * 1.8], "Z", foot, 0.6) - cylinder([0, 0, -10.0 + k.to_float() * 1.8], "Z", foot / 2.0 - 1.5 + k.to_float() * 0.3, 3.0)); }
let spike = cylinder([0, 0, -10.0 - 15.0], "Z", 4.76, 15.01) + cone(0.5, 4.76, 10.0).translate([0, 0, -35.0]);
sleeve + dome - compound(rings) + spike
