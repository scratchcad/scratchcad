// Belt strap end template: 38 mm (1.5 in) wide, 150 mm long, round end, 3 mm acrylic-style, 5 hole guides on 25 mm pitch
let width = 38.0; // [20.0, 50.0] Strap width (mm)
let length = 150.0; // [100.0, 200.0] Template length (mm)
let t = 3.0; // [2.0, 5.0] Thickness (mm)
let tmpl = box_from_corners([0, -width / 2.0, 0], [length, width / 2.0, t]);
let tt = tmpl.fillet(width / 2.0 - 0.01, tmpl.edges("|Z and >X"));
let holes = [];
for k in 0..5 { holes.push(cylinder([length - 30.0 - k.to_float() * 25.0, 0, -1], "Z", 1.5, t + 2.0)); }
tt - compound(holes) - box_from_corners([10.0, -width / 2.0 - 1.0, t - 0.5], [11.0, width / 2.0 + 1.0, t + 1.0])
