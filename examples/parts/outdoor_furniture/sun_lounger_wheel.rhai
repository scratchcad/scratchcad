// Sun lounger wheel: 100 mm wheel 25 mm wide with 6 spokes, 8 mm axle bore, 2 mm tread grooves
let d = 100.0; // [70.0, 150.0] Wheel diameter (mm)
let width = 25.0; // [15.0, 40.0] Wheel width (mm)
let axle = 8.0; // [6.0, 12.0] Axle bore (mm)
let rim = cylinder(d / 2.0, width) - cylinder([0, 0, -1], "Z", d / 2.0 - 6.0, width + 2.0);
let hub = cylinder(10.0, width);
let spokes = [];
for k in 0..6 { spokes.push(box_from_corners([8.0, -3.0, width / 2.0 - 4.0], [d / 2.0 - 5.0, 3.0, width / 2.0 + 4.0]).rotate_z(k.to_float() * 60.0)); }
let grooves = [];
for z in [6.0, width / 2.0, width - 6.0] { grooves.push(cylinder([0, 0, z - 1.0], "Z", d / 2.0 + 1.0, 2.0) - cylinder([0, 0, z - 2.0], "Z", d / 2.0 - 1.0, 4.0)); }
rim + hub + fuse_all(spokes) - compound(grooves) - cylinder([0, 0, -1], "Z", axle / 2.0, width + 2.0)
