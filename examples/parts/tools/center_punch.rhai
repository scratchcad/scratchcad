// Centre punch: 12 mm knurled body 100 mm long, 25 mm taper to a 3 mm tip with a 90 deg point, chamfered striking end
let d = 12.0; // [8.0, 16.0] Body diameter (mm)
let len = 100.0; // [80.0, 160.0] Body length (mm)
let body = cylinder(d / 2.0, len).chamfer(1.0, ">Z");
for k in 0..12 { body -= torus(d / 2.0 + 0.2, 0.5).translate([0, 0, 40.0 + k.to_float() * 4.0]); }
fuse_all([body, cone(1.5, d / 2.0, 25.0).translate([0, 0, -25.0]), cone(0.05, 1.5, 1.45).translate([0, 0, -26.45])])
