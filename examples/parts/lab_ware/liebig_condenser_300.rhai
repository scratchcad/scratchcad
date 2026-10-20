// Liebig condenser: 12 mm inner tube 300 mm long, 30 mm water jacket 220 mm long, two 8 mm hose barbs near the ends
let len = 300.0; // [200.0, 500.0] Inner tube length (mm)
let jacket = 220.0; // [100.0, 400.0] Jacket length (mm)
let z0 = (len - jacket) / 2.0;
let cavity = cylinder([0, 0, z0 + 1.5], "Z", 13.5, jacket - 3.0) - cylinder([0, 0, 0], "Z", 6.0, len);
let body = cylinder(6.0, len) + cylinder([0, 0, z0], "Z", 15.0, jacket);
let barbs = [];
for z in [z0 + 15.0, z0 + jacket - 15.0] { barbs.push(cylinder([12.0, 0, z], "X", 4.0, 20.0) + cone(5.0, 4.0, 4.0).rotate_y(90.0).translate([26.0, 0, z])); }
let c = fuse_all([body] + barbs) - cavity - cylinder([0, 0, -1], "Z", 4.8, len + 2.0);
for z in [z0 + 15.0, z0 + jacket - 15.0] { c -= cylinder([10.0, 0, z], "X", 2.8, 22.0); }
c
