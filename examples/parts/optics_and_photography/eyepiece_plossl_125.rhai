// 1.25 in Plossl eyepiece, 25 mm focal length: 31.7 mm barrel 28 mm long with a safety undercut and M28.5 x 0.6 filter thread (shown as a 27.9 mm bore), 36 mm ribbed grip body 32 mm tall, two cemented achromat doublets set in the body
let barrel_od = 31.7; // [31.6, 31.75] Barrel diameter (mm)
let barrel_length = 28.0; // [15.0, 35.0] Barrel length (mm)
let body_od = 36.0; // [32.0, 50.0] Body diameter (mm)
let body_height = 32.0; // [20.0, 50.0] Body height (mm)
let lens_diameter = 22.0; // [15.0, 27.0] Lens diameter (mm)
let rib_count = 3; // [0, 6] Grip ribs
let rb = barrel_od / 2.0;
let rd = body_od / 2.0;
let barrel = cylinder(rb, barrel_length + 0.1) - torus(rb + 0.2, 0.8).translate([0, 0, 6.0]);
barrel = barrel.chamfer(0.4, "%CIRCLE and <Z");
let body = cylinder([0, 0, barrel_length], "Z", rd, body_height).fillet(1.5, "%CIRCLE and >Z");
for i in 0..rib_count {
    body -= torus(rd + 0.4, 0.9).translate([0, 0, barrel_length + body_height * (0.3 + 0.12 * i.to_float())]);
}
let housing = barrel + body;
let rl = min(lens_diameter / 2.0, rb - 2.0);
let top = barrel_length + body_height;
housing -= cylinder([0, 0, -1.0], "Z", 13.95, 7.0);
housing -= cylinder([0, 0, 5.0], "Z", rl - 1.0, top);
// eyecup recess and lens seats
housing -= cylinder([0, 0, top - 4.0], "Z", rl + 0.1, 5.0);
housing -= cylinder([0, 0, top - 18.0], "Z", rl + 0.1, 7.0);
let doublet = cylinder(rl, 6.0) & sphere([0, 0, -28.0], 34.0);
let lens_a = doublet.translate([0, 0, top - 17.9]);
let lens_b = doublet.rotate_x(180.0).translate([0, 0, top - 11.1]);
compound([housing, lens_a, lens_b])
