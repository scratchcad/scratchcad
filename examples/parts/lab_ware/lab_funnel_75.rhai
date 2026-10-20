// 75 mm glass funnel: 60 deg cone 60 mm tall, 1.2 mm wall, beaded rim, 8 mm stem 50 mm long cut at 30 deg
let d = 75.0; // [40.0, 150.0] Mouth diameter (mm)
let r = d / 2.0;
let cone_h = 60.0; // [30.0, 120.0] Cone height (mm)
let slope = (r - 4.5) / cone_h;
let body = cone(4.5, r, cone_h) - cone(4.5 - 1.2 - 0.5 * slope, r - 1.2 + 0.5 * slope, cone_h + 1.0).translate([0, 0, -0.5]);
let stem = cylinder([0, 0, -50.0], "Z", 4.0, 50.5) - cylinder([0, 0, -51.0], "Z", 3.0, 53.0);
let f = fuse_all([body, stem, torus(r, 1.2).translate([0, 0, cone_h])]);
f - box_centered(30.0, 30.0, 30.0).rotate_y(30.0).translate([0, 0, -62.0])
