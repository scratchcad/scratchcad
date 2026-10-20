// TowerPro SG90 micro servo
let body_l = 22.2; // [20.0, 24.0] Case length (mm)
let body_w = 11.8; // [11.0, 13.0] Case width (mm)
let body_h = 22.7; // [20.0, 25.0] Case height (mm)
let ear_span = 32.2; // [30.0, 34.0] Length over the mounting ears (mm)
let ear_holes = 27.8; // [26.0, 30.0] Mounting hole spacing (mm)
let ear_top = 15.9; // [14.0, 18.0] Ear top above the base (mm)
let ear_t = 2.5; // [1.5, 3.0] Ear thickness (mm)
let housing = box_centered(body_l, body_w, body_h).translate([0, 0, body_h / 2.0]);
let ears = box_centered(ear_span, body_w, ear_t).translate([0, 0, ear_top - ear_t / 2.0]);
for s in [-1, 1] {
    ears -= cylinder([s * ear_holes / 2.0, 0, 0], "Z", 1.0, 30);
    ears -= box_centered(2.0, 1.0, 10).translate([s * (ear_span / 2.0), 0, ear_top]);
}
// gear housing: a round boss over the output and a smaller one beside it
let shaft_x = body_l / 2.0 - body_w / 2.0;
let top = body_h;
let boss1 = cylinder([shaft_x, 0, top - 0.01], "Z", body_w / 2.0, 4.0);
let boss2 = cylinder([shaft_x - 5.5, 0, top - 0.01], "Z", 2.75, 4.0);
let shaft = cylinder([shaft_x, 0, top + 3.99], "Z", 2.4, 3.2);
// 21 splines on the output shaft
let splines = [];
for i in 0..21 { splines.push(box_centered(0.5, 0.5, 3.4).rotate_z(45).translate([2.4, 0, top + 5.6]).rotate(vec3(shaft_x, 0, 0), "Z", i * 360.0 / 21.0)); }
let output = shaft - fuse_all(splines) - cylinder([shaft_x, 0, top + 5.0], "Z", 0.9, 5.0);
let cable = box_centered(4.0, 3.0, 1.2).translate([-body_l / 2.0 - 1.5, 0, 4.5]);
fuse_all([housing, ears, boss1, boss2, output, cable])
