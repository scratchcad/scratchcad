// E-bike display handlebar clamp: 22.2 mm bar, 16 mm wide split ring 3 mm, M3 pinch boss, 30 x 20 mm display pad tilted 15 degrees
let bar = 22.2; // [22.0, 31.8] Handlebar diameter (mm)
let width = 16.0; // [10.0, 25.0] Clamp width (mm)
let wall = 3.0; // [2.0, 5.0] Wall (mm)
let r = bar / 2.0;
let ring = cylinder([0, -width / 2.0, 0], "Y", r + wall, width) - cylinder([0, -width, 0], "Y", r, width * 2.0);
let boss = box_from_corners([-4.0, -width / 2.0, -r - wall - 8.0], [4.0, width / 2.0, -r + 0.5]) - box_from_corners([-0.75, -width, -r - wall - 9.0], [0.75, width, -r + 1.0]) - cylinder([-6.0, 0, -r - wall - 4.0], "X", 1.6, 12.0);
let pad = box_centered(30.0, 20.0, 3.0).translate([0, 0, r + wall + 4.0]).rotate([0, 0, r + wall], "Y", 15.0);
let neck = box_from_corners([-5.0, -width / 2.0, r + wall - 1.0], [5.0, width / 2.0, r + wall + 4.0]);
ring + boss + neck + pad - cylinder([0, -width, 0], "Y", r, width * 2.0)
