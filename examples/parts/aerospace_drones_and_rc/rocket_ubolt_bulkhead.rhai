// Model rocket recovery bulkhead: 40 mm disc 3 mm thick with a 4 mm wire U-bolt 20 mm wide and 16 mm tall
let d = 40.0; // [25.0, 100.0] Bulkhead diameter (mm)
let span = 20.0; // [12.0, 40.0] U-bolt width (mm)
let disc = cylinder(d / 2.0, 3.0);
let arch = torus(span / 2.0, 2.0).rotate_x(90.0).translate([0, 0, 10.0]) & box_centered(span + 10.0, 10.0, 20.0).translate([0, 0, 20.0]);
let legs = [cylinder([-span / 2.0, 0, -6.0], "Z", 2.0, 16.0), cylinder([span / 2.0, 0, -6.0], "Z", 2.0, 16.0)];
let nuts = [cylinder([-span / 2.0, 0, -4.0], "Z", 3.5, 4.0), cylinder([span / 2.0, 0, -4.0], "Z", 3.5, 4.0)];
fuse_all([disc, arch] + legs + nuts)
