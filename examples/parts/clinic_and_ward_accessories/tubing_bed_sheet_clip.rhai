// Bed sheet tubing clip: snap ring for 10 mm oxygen or drain tubing, 2 mm wall 12 mm wide with a 7 mm opening, on a 35 mm two-tine sheet clip with a 1 mm gap and a 2 mm grip ridge
let tube_d = 10.0; // [6.0, 16.0] Tubing diameter (mm)
let tine_l = 35.0; // [25.0, 50.0] Clip length (mm)
const wall = 2.0;
const w = 12.0;
let ri = tube_d / 2.0 + 0.2;
let ro = ri + wall;
let ring = cylinder([-w / 2.0, 0, ro + 3.0], "X", ro, w) - cylinder([-w / 2.0 - 1.0, 0, ro + 3.0], "X", ri, w + 2.0);
ring = ring - box_from_corners([-w, -tube_d * 0.35, ro + 3.0], [w, tube_d * 0.35, 2.0 * ro + 4.0]);
let clip = box_from_corners([-w / 2.0, -tine_l + ro, 0], [w / 2.0, ro, 5.0]) - box_from_corners([-w / 2.0 - 1.0, -tine_l + ro - 1.0, 2.0], [w / 2.0 + 1.0, ro - 6.0, 3.0]);
let ridge = box_from_corners([-w / 2.0, -tine_l + ro + 2.0, 1.99], [w / 2.0, -tine_l + ro + 4.0, 2.6]);
ring + clip + ridge
