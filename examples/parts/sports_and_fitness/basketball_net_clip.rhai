// Basketball rim net clip: snaps over a 16 mm rim rod, 10 mm wide, 2.5 mm wall C ring with a 12 mm snap opening, 14 mm hook tab with a 5 mm net loop slot
let rod_d = 16.0; // [12.0, 20.0] Rim rod diameter (mm)
let wall = 2.5; // [1.5, 4.0] Wall thickness (mm)
let width = 10.0; // [6.0, 16.0] Clip width (mm)
let opening = 12.0; // [8.0, 15.0] Snap opening (mm)
let tab_length = 14.0; // [8.0, 24.0] Hook tab length (mm)
let ri = rod_d / 2.0;
let ro = ri + wall;
let op = min(opening, rod_d - 1.0);
let ring = cylinder([0, -width / 2.0, 0], "Y", ro, width) - cylinder([0, -width, 0], "Y", ri, 2.0 * width);
ring = ring - box_centered(op, width + 2.0, ro).translate([0, 0, ro]);
let tab = box_from_corners([-3.0, -width / 2.0, -ro - tab_length], [3.0, width / 2.0, -ri - 0.5]);
let clip = ring + tab;
clip = clip - box_from_corners([-4.0, -2.5, -ro - tab_length + 3.0], [4.0, 2.5, -ro - tab_length + 8.0]);
clip - box_from_corners([-4.0, -1.0, -ro - tab_length - 1.0], [4.0, 1.0, -ro - tab_length + 3.0 + 0.01])
