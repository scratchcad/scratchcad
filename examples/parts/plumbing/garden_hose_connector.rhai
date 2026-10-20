// Garden hose quick connector for 1/2 in hose: 24 mm body, sliding collar 28 mm, 13 mm barb tail with 3 rings
let body_d = 24.0; // [18.0, 34.0] Body diameter (mm)
let collar_d = 28.0; // [22.0, 40.0] Collar diameter (mm)
let length = 60.0; // [40.0, 90.0] Length (mm)
let barb_d = 14.0; // [10.0, 22.0] Barb diameter (mm)
let body = cylinder(body_d / 2.0, length * 0.45) + (cylinder([0, 0, length * 0.15], "Z", collar_d / 2.0, length * 0.2) - torus(collar_d / 2.0 + 1.0, 1.6).translate([0, 0, length * 0.25]));
let tail = [cylinder([0, 0, length * 0.45 - 0.01], "Z", barb_d / 2.0 - 1.5, length * 0.55)];
for k in 0..3 { tail.push(cone(barb_d / 2.0, barb_d / 2.0 - 1.5, 5.0).translate([0, 0, length * 0.5 + k.to_float() * 7.0])); }
fuse_all([body] + tail) - cylinder([0, 0, -1], "Z", 5.0, length + 2.0) - cylinder([0, 0, -1], "Z", 8.0, 12.0)
