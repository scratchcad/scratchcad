// 90 mm petri dish: 14 mm base with 1 mm wall and floor, 10 mm lid 2 mm larger with three stacking vents, shown side by side
let d = 90.0; // [35.0, 150.0] Base diameter (mm)
let r = d / 2.0;
let base = cylinder(r, 14.0) - cylinder([0, 0, 1.0], "Z", r - 1.0, 14.0);
let lid = cylinder(r + 2.0, 10.0) - cylinder([0, 0, -1.0], "Z", r + 1.0, 10.0);
for k in 0..3 { lid += box_centered(4.0, 1.0, 1.0).translate([r - 2.0, 0, 8.5]).rotate("Z", k.to_float() * 120.0); }
compound([base, lid.translate([d + 10.0, 0, 0])])
