// Mop / broom handle wall clip: grips 22-25 mm handles, 3.5 mm wall C-clip 25 mm tall, 18 mm mouth, 40 x 50 mm back plate with 2 countersunk 4 mm screw holes
let handle_d = 23.0; // [18.0, 32.0] Handle diameter (mm)
let wall = 3.5; // [2.5, 5.0] Clip wall (mm)
let height = 25.0; // [15.0, 40.0] Clip height (mm)
let mouth = 18.0; // [12.0, 28.0] Mouth opening (mm)
let t = 4.0; // [3.0, 6.0] Plate thickness (mm)
let ri = handle_d / 2.0;
let ro = ri + wall;
let cy = t + ri + 1.0;
let clip = cylinder([0, cy, 0], "Z", ro, height) - cylinder([0, cy, -1], "Z", ri, height + 2.0) - box_from_corners([-mouth / 2.0, cy, -1], [mouth / 2.0, cy + ro + 1.0, height + 1.0]);
let bridge = box_from_corners([-ro * 0.6, 0, 0], [ro * 0.6, cy - ri + 0.5, height]);
let plate = box_from_corners([-20.0, 0, -12.5], [20.0, t, height + 12.5]);
let p = plate.fillet(4.0, plate.edges("|Y"));
let screws = [];
for z in [-6.5, height + 6.5] { screws.push(cylinder([0, -1, z], "Y", 2.0, t + 2.0) + cone(2.0, 4.2, 2.2).rotate_x(-90.0).translate([0, t - 2.19, z])); }
p + bridge + clip - cylinder([0, cy, -1], "Z", ri, height + 2.0) - fuse_all(screws)
