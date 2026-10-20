// Hockey stick end plug: 30 x 20 mm rounded-rectangle plug 25 mm long for a composite shaft (2 mm wall), with 3 ridges and a 35 x 25 mm knob 15 mm tall
let shaft_w = 30.0; // [26.0, 34.0] Shaft outer width (mm)
let shaft_h = 20.0; // [18.0, 24.0] Shaft outer depth (mm)
const wall = 2.0;
let plug = box_centered(shaft_w - 2.0 * wall - 0.3, shaft_h - 2.0 * wall - 0.3, 25.0).translate([0, 0, -12.5 + 0.01]);
let plug = plug.fillet(2.0, plug.edges("|Z"));
let knob = box_centered(shaft_w + 5.0, shaft_h + 5.0, 15.0).translate([0, 0, 7.5]);
let knob = knob.fillet(5.0, knob.edges("|Z"));
let knob = knob.fillet(3.0, knob.edges(">Z"));
let ridges = [];
for i in 0..3 { ridges.push(box_centered(shaft_w - 2.0 * wall + 0.5, 1.0, 1.0).translate([0, shaft_h / 2.0 - wall, -5.0 - i.to_float() * 6.0]) + box_centered(shaft_w - 2.0 * wall + 0.5, 1.0, 1.0).translate([0, -shaft_h / 2.0 + wall, -5.0 - i.to_float() * 6.0])); }
plug + knob + fuse_all(ridges)
