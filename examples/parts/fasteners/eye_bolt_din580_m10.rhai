// Lifting eye bolt DIN 580 M10: 25 mm inner and 45 mm outer eye, 25 mm collar, 17 mm thread length, 230 kg working load
let thread_diameter = 10.0; // [6.0, 30.0] Thread size (mm)
let thread_length = 17.0; // [8.0, 50.0] Thread length (mm)
let eye_inner = 25.0; // [12.0, 70.0] Eye inner diameter (mm)
let eye_outer = 45.0; // [22.0, 120.0] Eye outer diameter (mm)
let collar_diameter = 25.0; // [12.0, 70.0] Collar diameter (mm)
let rt = thread_diameter / 2.0;
let tube = max((eye_outer - eye_inner) / 4.0, 1.5);
let ring_r = eye_inner / 2.0 + tube;
let rc = max(collar_diameter / 2.0, rt + 2.0);
let collar_h = tube * 1.2;
let zc = collar_h + tube * 0.6 + ring_r;
let eye = torus(ring_r, tube).rotate_x(90.0).translate([0, 0, zc]);
let collar = cylinder(rc, collar_h).fillet(min(collar_h * 0.4, 2.0), ">Z");
let neck = cone(rc * 0.7, tube * 1.1, zc - ring_r - collar_h + tube * 0.5).translate([0, 0, collar_h - 0.01]);
let shank = cylinder([0, 0, -thread_length], "Z", rt, thread_length + 0.01).chamfer(min(1.0, rt * 0.2), "<Z");
fuse_all([shank, collar, neck, eye])
