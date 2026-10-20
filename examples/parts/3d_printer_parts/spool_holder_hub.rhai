// Filament spool hub: 52 mm stepped cone fitting 52-56 mm spool holes, 608 bearing seat, 30 mm long
let small_d = 50.0; // [30.0, 60.0] Small end diameter (mm)
let large_d = 58.0; // [35.0, 80.0] Large end diameter (mm)
let length = 30.0; // [15.0, 50.0] Length (mm)
let bearing_d = 22.0; // [10.0, 30.0] Bearing seat (mm)
let hub = cone(large_d / 2.0, small_d / 2.0, length) + cylinder([0, 0, -2.0], "Z", large_d / 2.0 + 4.0, 2.01);
hub = hub.shell(-2.0, ">Z");
let seat = cylinder(bearing_d / 2.0 + 3.0, length) - cylinder([0, 0, -3], "Z", bearing_d / 2.0, length + 6);
let spokes = [];
for i in 0..4 { spokes.push(box_from_corners([bearing_d / 2.0 + 2.0, -1.5, -2.0], [large_d / 2.0, 1.5, length * 0.6]).rotate_z(i * 90)); }
fuse_all([hub, seat] + spokes) & cylinder([0, 0, -2], "Z", large_d / 2.0 + 4.0, length + 2.0)
