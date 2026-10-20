// Wheelchair push rim clamp: two-piece split clamp joining a 19 mm push rim to a 24 inch wheel tab, 40 mm long, 6 mm wall, M5 clamp bolt; one-piece print with a 1.5 mm slit, 20 x 12 mm tab with 6 mm hole and 5 mm standoff
// # Rim
let rim = 19.0; // [16.0, 22.0] Push rim tube diameter (mm)
let clamp_length = 20.0; // [12.0, 30.0] Clamp width along the rim (mm)
let wall = 4.0; // [3.0, 6.0] Wall thickness (mm)
// # Tab
let standoff = 15.0; // [8.0, 25.0] Standoff from rim to wheel (mm)
let bolt = 5.0; // [4.0, 6.0] Bolt diameter (mm)
let ro = rim / 2.0 + wall;
let ring = cylinder([0, -clamp_length / 2.0, 0], "Y", ro, clamp_length);
let ears = box_from_corners([-ro - 9.0, -clamp_length / 2.0, -4.0], [-ro + 2.0, clamp_length / 2.0, 4.0]);
let arm = box_from_corners([-6.0, -clamp_length / 2.0, 0], [6.0, clamp_length / 2.0, ro + standoff]);
let body = ring + ears + arm.fillet(2.0, "|Y and >Z");
let bore = cylinder([0, -clamp_length / 2.0 - 1.0, 0], "Y", rim / 2.0, clamp_length + 2.0);
let slit = box_from_corners([-ro - 10.0, -clamp_length / 2.0 - 1.0, -0.75], [-rim / 2.0 + 1.0, clamp_length / 2.0 + 1.0, 0.75]);
let bolt_hole = cylinder([-ro - 4.0, 0, -6.0], "Z", bolt / 2.0 + 0.25, 12.0);
let tab_hole = cylinder([0, -clamp_length / 2.0 - 1.0, ro + standoff - 6.0], "Y", 3.0, clamp_length + 2.0);
body - bore - slit - bolt_hole - tab_hole
