// DIN 464 M4 x 10 knurled thumb screw: 16 mm knurled head 3.5 mm tall plus 5 mm collar
let head_d = 16.0; // [10.0, 30.0] Head diameter (mm)
let head_h = 3.5; // [2.5, 7.0] Knurl height (mm)
let collar_d = 8.0; // [5.0, 16.0] Collar diameter (mm)
let collar_h = 5.0; // [2.0, 9.0] Collar height (mm)
let length = 10.0; // [5.0, 30.0] Thread length (mm)
let diameter = 4.0; // [3.0, 8.0] Thread diameter (mm)
let ridges = 36; // [12, 60] Knurl ridges
let head = cylinder([0, 0, collar_h], "Z", head_d / 2.0, head_h).chamfer(0.4);
let grooves = [];
for i in 0..ridges { grooves.push(cylinder([head_d / 2.0 + 0.15, 0, collar_h - 1], "Z", 0.45, head_h + 2.0).rotate_z(i * 360.0 / ridges.to_float())); }
fuse_all([head - fuse_all(grooves), cylinder(collar_d / 2.0, collar_h + 0.01), cylinder([0, 0, -length], "Z", diameter / 2.0, length + 0.1)])
