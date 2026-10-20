// E27 lamp holder: 40 mm body 50 mm tall, 27.5 mm threaded socket 25 mm deep with a raised thread ridge, base with 10 mm entry
let body_d = 40.0; // [36.0, 48.0] Body diameter (mm)
let r = body_d / 2.0;
let body = cylinder(r, 50.0).chamfer(1.0, ">Z") - cylinder([0, 0, 25.0], "Z", 13.75, 30.0) - cylinder([0, 0, -1], "Z", 5.0, 30.0);
let ridges = [];
for k in 0..7 { ridges.push(torus(13.75, 0.7).translate([0, 0, 28.0 + k.to_float() * 3.6])); }
body + (fuse_all(ridges) & cylinder(13.9, 60.0))
