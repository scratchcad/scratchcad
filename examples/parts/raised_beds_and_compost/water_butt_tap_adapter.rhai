// Water butt tap outlet adapter: 3/4 in BSP stub 20 mm, 50 mm flange 4 mm, 13 mm hose tail 35 mm with 3 barbs
let flange = 50.0; // [35.0, 70.0] Flange diameter (mm)
let hose = 13.0; // [10.0, 19.0] Hose ID (mm)
let stub = cylinder([0, 0, -20.0], "Z", 13.0, 20.01);
let f = cylinder(flange / 2.0, 4.0);
let tail = cylinder([0, 0, 3.99], "Z", hose / 2.0 - 0.5, 35.0);
let barbs = [];
for k in 0..3 { barbs.push(cone(hose / 2.0 + 1.0, hose / 2.0 - 0.5, 6.0).translate([0, 0, 12.0 + k.to_float() * 8.0])); }
stub + f + tail + fuse_all(barbs) - cylinder([0, 0, -21.0], "Z", hose / 2.0 - 2.5, 62.0)
