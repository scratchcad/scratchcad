// Book page weight snake: 300 mm long flat bar 20 x 10 mm with rounded ends and 4 mm decorative grooves every 30 mm
let length = 300.0; // [200.0, 400.0] Length (mm)
let width = 20.0; // [15.0, 30.0] Width (mm)
let t = 10.0; // [6.0, 15.0] Height (mm)
let bar = box_centered(length, width, t).translate([0, 0, t / 2.0]);
let b = bar.fillet(width / 2.0 - 0.5, bar.edges("|Z"));
let bb = b.fillet(3.0, b.edges(">Z"));
let grooves = [];
for k in 1..10 { grooves.push(box_centered(2.0, width + 2.0, 4.0).translate([-length / 2.0 + k.to_float() * 30.0, 0, t])); }
bb - compound(grooves)
