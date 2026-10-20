// Dog-bone antenna end insulator: 100 mm long, 20 mm wide, 8 mm thick ribbed body, 2 x 8 mm eye holes
let length = 100.0; // [60.0, 150.0] Length (mm)
let width = 20.0; // [14.0, 30.0] Width (mm)
let t = 8.0; // [5.0, 12.0] Thickness (mm)
let b = box_centered(length, width, t).translate([0, 0, t / 2.0]);
let bb = b.fillet(width / 2.0 - 0.5, b.edges("|Z"));
let ribs = [];
for k in -3..=3 { ribs.push(box_centered(3.0, width + 2.0, 2.0).translate([k.to_float() * 8.0, 0, t])); }
bb - compound(ribs) - cylinder([-length / 2.0 + 10.0, 0, -1], "Z", 4.0, t + 2.0) - cylinder([length / 2.0 - 10.0, 0, -1], "Z", 4.0, t + 2.0)
