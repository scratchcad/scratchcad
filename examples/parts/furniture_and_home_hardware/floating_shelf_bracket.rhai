// Hidden floating shelf bracket: 100 x 40 x 5 mm wall plate with three countersunk holes, two 12 mm rods 120 mm long
let rod_len = 120.0; // [80.0, 200.0] Rod length (mm)
let span = 70.0; // [40.0, 90.0] Rod spacing (mm)
let plate = box_from_corners([-50.0, 0, -20.0], [50.0, 5.0, 20.0]).fillet(3.0, "|Y");
for x in [-35.0, 0.0, 35.0] { plate -= cylinder([x, -1, 0], "Y", 2.25, 7.0) + cone(4.5, 2.25, 2.25).rotate_x(-90.0).translate([x, 5.01, 0]); }
let rods = [];
for x in [-span / 2.0, span / 2.0] { rods.push(cylinder([x, 4.0, 0], "Y", 6.0, rod_len + 1.0).chamfer(1.0, ">Y")); }
fuse_all([plate] + rods)
