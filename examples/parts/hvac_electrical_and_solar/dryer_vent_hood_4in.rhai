// Louvered dryer vent hood for 4 in (102 mm) duct: 165 mm square wall flange, 125 x 125 x 70 mm hood box with three hinged louver flaps, 100 mm round tail pipe 110 mm long
let duct_d = 102.0; // [76.0, 152.0] Duct diameter (mm)
let flange = 165.0; // [130.0, 220.0] Flange size (mm)
let hood_depth = 70.0; // [40.0, 100.0] Hood depth (mm)
let tail = 110.0; // [50.0, 200.0] Tail pipe length (mm)
let flaps = 3; // [2, 5] Number of louver flaps
const t = 1.5;
let hw = duct_d + 23.0;
let fl = box_centered(flange, flange, t).translate([0, 0, t / 2.0]).fillet(5.0, "|Z");
let hood = box_from_corners([-hw / 2.0, -hw / 2.0, 0], [hw / 2.0, hw / 2.0, hood_depth]) - box_from_corners([-hw / 2.0 + t, -hw / 2.0 + t, -1], [hw / 2.0 - t, hw / 2.0 + 1.0, hood_depth - t]);
let pipe = cylinder([0, 0, -tail], "Z", duct_d / 2.0, tail + t) - cylinder([0, 0, -tail - 1.0], "Z", duct_d / 2.0 - t, tail + 4.0);
let base = fl - cylinder([0, 0, -1], "Z", duct_d / 2.0 - t, 4.0);
let fh = hood_depth / flaps.to_float();
let louvers = [];
for i in 0..flaps {
    let zh = fh * (i.to_float() + 1.0) - 1.0;
    louvers.push(box_from_corners([-hw / 2.0 + t + 0.5, -t / 2.0, -fh - 2.0], [hw / 2.0 - t - 0.5, t / 2.0, 0]).rotate_x(25.0).translate([0, hw / 2.0 + 1.0, zh]));
    louvers.push(cylinder([-hw / 2.0, hw / 2.0 + 1.0, zh], "X", 1.5, hw));
}
fuse_all([base, hood, pipe] + louvers)
