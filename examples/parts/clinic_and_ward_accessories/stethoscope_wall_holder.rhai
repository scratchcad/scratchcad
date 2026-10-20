// Stethoscope wall holder: 50 x 80 mm back plate 4 mm thick with two 4.5 mm screw holes, a 45 mm arm and a 24 mm wide cradle with an 11 mm radius saddle for the tubing and an 8 mm front lip
let reach = 45.0; // [30.0, 70.0] Arm reach (mm)
let saddle_r = 11.0; // [7.0, 15.0] Saddle radius (mm)
let width = 24.0; // [16.0, 34.0] Cradle width (mm)
const t = 4.0;
let plate = box_from_corners([-25.0, -t, 0], [25.0, 0, 80.0]);
plate = plate.fillet(6.0, plate.edges("|Y"));
let arm = box_from_corners([-width / 2.0, -0.01, 40.0], [width / 2.0, reach, 50.0]);
let cradle = box_from_corners([-width / 2.0, reach - 2.0 * saddle_r - 6.0, 40.0], [width / 2.0, reach, 50.0 + saddle_r + 2.0]);
let h = plate + arm + cradle;
h = h - cylinder([-width / 2.0 - 1.0, reach - saddle_r - 3.0, 50.0 + saddle_r + 2.0], "X", saddle_r, width + 2.0);
h - cylinder([0, -t - 1.0, 12.0], "Y", 2.25, t + 2.0) - cylinder([0, -t - 1.0, 70.0], "Y", 2.25, t + 2.0)
