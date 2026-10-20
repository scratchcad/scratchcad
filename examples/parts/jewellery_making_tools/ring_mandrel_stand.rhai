// Ring mandrel stand: 100 x 60 mm base 15 mm, 25 mm socket angled 30 degrees for a 30 mm mandrel butt
let base_l = 100.0; // [70.0, 140.0] Base length (mm)
let base_w = 60.0; // [40.0, 80.0] Base width (mm)
let socket = 25.0; // [18.0, 32.0] Mandrel butt diameter (mm)
let base = box_centered(base_l, base_w, 15.0).translate([0, 0, 7.5]);
let b = base.fillet(8.0, base.edges("|Z"));
let boss = cylinder([0, 0, 0], "Z", socket / 2.0 + 5.0, 40.0).rotate_y(30.0).translate([-base_l / 2.0 + 30.0, 0, 5.0]);
let hole = cylinder([0, 0, 5.0], "Z", socket / 2.0, 50.0).rotate_y(30.0).translate([-base_l / 2.0 + 30.0, 0, 5.0]);
(b + boss) & box_from_corners([-base_l, -base_w, 0], [base_l, base_w, 100.0]) - hole
