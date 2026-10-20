// Female Luer lock hub: 6% taper bore from 4.3 mm, 8 mm hub 10 mm long, two thread lugs, 4 mm hose barb on the back
let barb_d = 4.0; // [2.0, 6.0] Barb diameter (mm)
let hub = cylinder(4.0, 10.0) + box_centered(10.0, 2.0, 1.0).translate([0, 0, 9.5]);
let barb = cylinder([0, 0, -12.0], "Z", barb_d / 2.0, 12.1);
for k in 0..2 { barb += cone(barb_d / 2.0 + 0.6, barb_d / 2.0, 3.0).translate([0, 0, -12.0 + k.to_float() * 5.0]); }
fuse_all([hub, barb]) - cone(2.0, 2.15, 7.6).translate([0, 0, 2.5]) - cylinder([0, 0, -13.0], "Z", barb_d / 2.0 - 0.8, 16.0)
