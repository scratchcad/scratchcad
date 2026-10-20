// XLR female cable connector: 19.5 mm shell 50 mm long, 3-pin insert with 1.6 mm sockets on a 7.9 mm circle, latch button, boot
let d = 19.5; // [18.0, 22.0] Shell diameter (mm)
let r = d / 2.0;
let shell = cylinder(r, 30.0) - cylinder([0, 0, -1], "Z", r - 1.0, 12.0);
let insert = cylinder(r - 1.0, 12.0);
for k in 0..3 { insert -= cylinder([7.9 / 2.0, 0, -1], "Z", 0.8, 10.0).rotate_z(90.0 + k.to_float() * (if k == 1 { 120.0 } else { 120.0 })); }
insert -= box_centered(3.0, 2.0, 14.0).translate([0, -(r - 1.5), 6.0]);
let latch = box_centered(5.0, 3.0, 9.0).translate([0, r + 0.5, 20.0]).fillet(1.0, ">Y");
let boot = cone(r - 0.5, 4.5, 20.0).translate([0, 0, 30.0]) - cylinder([0, 0, 29.0], "Z", 3.0, 25.0);
fuse_all([shell, insert, latch, boot])
