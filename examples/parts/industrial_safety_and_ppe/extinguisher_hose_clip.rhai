// Fire extinguisher hose clip: snap clip for a 14 mm discharge hose, 3 mm C-ring 12 mm wide with a 10 mm mouth, strapped to the 160 mm cylinder by a 30 mm curved saddle
let hose = 14.0; // [10.0, 20.0] Hose diameter (mm)
let cylinder_d = 160.0; // [110.0, 200.0] Extinguisher diameter (mm)
let width = 12.0; // [8.0, 20.0] Clip width (mm)
let wall = 3.0; // [2.0, 4.0] Wall thickness (mm)
let ro = hose / 2.0 + wall;
let ring = cylinder([0, 0, 0], "Z", ro, width) - cylinder([0, 0, -1], "Z", hose / 2.0, width + 2.0);
let mouth = box_from_corners([-(hose * 0.7) / 2.0, 0, -1], [(hose * 0.7) / 2.0, ro + 1.0, width + 1.0]);
let rc = cylinder_d / 2.0;
// saddle: a slice of a tube hugging the extinguisher body, below the ring
let cy = -ro + 1.0 - rc - wall;
let saddle = (cylinder([0, cy, 0], "Z", rc + wall, width) - cylinder([0, cy, -1.0], "Z", rc, width + 2.0)) & box_from_corners([-15.0, -ro - wall - 6.0, -1.0], [15.0, -ro + 0.5, width + 1.0]);
ring - mouth + saddle
