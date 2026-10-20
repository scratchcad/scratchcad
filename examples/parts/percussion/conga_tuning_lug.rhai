// Conga tuning lug: 70 mm tall body 20 x 15 mm, 2 M6 mounting studs 40 mm apart, 8 mm hook-bolt bore at the top
let height = 70.0; // [50.0, 90.0] Lug height (mm)
let width = 20.0; // [15.0, 25.0] Body width (mm)
let depth = 15.0; // [10.0, 20.0] Body depth (mm)
let body = box_from_corners([-width / 2.0, 0, 0], [width / 2.0, depth, height]);
let b = body.fillet(width / 2.0 - 1.0, body.edges("|Y"));
let studs = cylinder([0, -8.0, height / 2.0 - 20.0], "Y", 3.0, 8.01) + cylinder([0, -8.0, height / 2.0 + 20.0], "Y", 3.0, 8.01);
b + studs - cylinder([0, depth / 2.0, height - 25.0], "Z", 4.0, 30.0)
