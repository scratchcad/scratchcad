// Wing tie-down ring: 3/8-16 threaded shank 30 mm, 38 mm OD ring 8 mm section, 16 mm hex collar
let ring_od = 38.0; // [25.0, 60.0] Ring outside diameter (mm)
let section = 8.0; // [5.0, 12.0] Ring section (mm)
let shank = 30.0; // [15.0, 50.0] Shank length (mm)
let ring = cylinder([0, -section / 2.0, shank + 8.0 + ring_od / 2.0 - 1.0], "Y", ring_od / 2.0, section) - cylinder([0, -section, shank + 8.0 + ring_od / 2.0 - 1.0], "Y", ring_od / 2.0 - section, section * 2.0);
let pts = [];
for i in 0..6 { let a = (i.to_float() * 60.0) * PI() / 180.0; pts.push([16.0 / 3.0.sqrt() * a.cos(), 16.0 / 3.0.sqrt() * a.sin()]); }
let hex = polygon(pts).to_face().extrude([0, 0, 8.0]).translate([0, 0, shank]);
let s = cylinder(4.76, shank + 0.01);
ring + hex + s
