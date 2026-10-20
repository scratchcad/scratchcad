// Sock aid trough: flexible half-cone sock former 180 mm long, 80 mm diameter at the heel tapering to 65 mm at the toe, 2 mm wall, two 6 mm cord holes near the heel corners
// # Trough
let length = 180.0; // [140.0, 220.0] Trough length (mm)
let heel_d = 80.0; // [71.0, 95.0] Heel-end diameter (mm)
let toe_d = 65.0; // [50.0, 85.0] Toe-end diameter (mm)
let wall = 2.0; // [1.5, 3.0] Wall thickness (mm)
// # Cords
let cord_hole = 6.0; // [4.0, 8.0] Cord hole diameter (mm)
let outer = cone(heel_d / 2.0, toe_d / 2.0, length);
let inner = cone(heel_d / 2.0 - wall, toe_d / 2.0 - wall, length + 0.02).translate([0, 0, -0.01]);
let half = (outer - inner) - box_from_corners([-heel_d, 0, -1.0], [heel_d, heel_d, length + 1.0]);
let cords = [cylinder([heel_d / 2.0 - 10.0, -cord_hole, 12.0], "X", cord_hole / 2.0, 20.0), cylinder([-heel_d / 2.0 - 10.0, -cord_hole, 12.0], "X", cord_hole / 2.0, 20.0)];
(half - compound(cords)).rotate_y(90.0).translate([0, 0, heel_d / 2.0])
