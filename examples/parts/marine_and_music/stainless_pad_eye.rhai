// Stainless pad eye: 50 x 30 x 4 mm base with four 5.5 mm holes, 8 mm wire loop 22 mm wide rising 18 mm
let w = 50.0; // [35.0, 80.0] Base length (mm)
let wire = 8.0; // [5.0, 12.0] Loop wire diameter (mm)
let base = box_centered(w, 30.0, 4.0).translate([0, 0, 2.0]).fillet(6.0, "|Z").chamfer(0.8, ">Z");
for x in [-w / 2.0 + 7.0, w / 2.0 - 7.0] { for y in [-8.0, 8.0] { base -= cylinder([x, y, -1], "Z", 2.75, 6.0); } }
let loop_ = (torus(11.0, wire / 2.0) & box_centered(40.0, 40.0, 40.0).translate([0, 0, 20.0])).rotate_x(90.0).rotate_x(-90.0);
let arch = (torus(11.0, wire / 2.0).rotate_x(90.0) & box_centered(40.0, 40.0, 40.0).translate([0, 0, 20.0])).translate([0, 0, 4.0]);
base + arch
