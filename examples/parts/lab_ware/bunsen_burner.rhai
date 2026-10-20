// Bunsen burner: 90 mm weighted base 10 mm thick, 12 mm chimney 130 mm tall, rotating air collar with two 6 mm ports, 9 mm hose barb
let tube_h = 130.0; // [80.0, 180.0] Chimney height (mm)
let base = cylinder(45.0, 10.0).chamfer(2.0, ">Z") + cylinder([0, 0, 9.9], "Z", 12.0, 12.0);
let tube = cylinder([0, 0, 21.0], "Z", 6.0, tube_h) - cylinder([0, 0, 24.0], "Z", 5.0, tube_h);
let collar = cylinder([0, 0, 22.0], "Z", 8.0, 15.0) - cylinder([0, 0, 21.0], "Z", 6.05, 17.0);
for a in [0.0, 180.0] { collar -= cylinder([0, 0, 29.5], "X", 3.0, 10.0).rotate("Z", a); }
let barb = cylinder([10.0, 0, 15.0], "X", 4.5, 40.0);
for k in 0..3 { barb += cone(4.5, 5.5, 4.0).rotate_y(-90.0).translate([50.0 - k.to_float() * 6.0, 0, 15.0]); }
barb -= cylinder([5.0, 0, 15.0], "X", 2.5, 50.0);
compound([fuse_all([base, tube, barb]), collar])
