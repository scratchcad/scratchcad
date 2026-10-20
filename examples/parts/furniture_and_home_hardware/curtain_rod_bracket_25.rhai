// Curtain rod bracket for a 25 mm rod: 30 x 60 x 5 mm wall plate with two holes, 70 mm arm, open-top cradle 15 mm wide
let rod_d = 25.0; // [16.0, 35.0] Rod diameter (mm)
let reach = 70.0; // [40.0, 120.0] Projection (mm)
let r = rod_d / 2.0;
let plate = box_from_corners([-15.0, 0, -30.0], [15.0, 5.0, 30.0]).fillet(4.0, "|Y");
for z in [-20.0, 20.0] { plate -= cylinder([0, -1, z], "Y", 2.25, 7.0); }
let arm = box_from_corners([-6.0, 4.0, -5.0], [6.0, reach, 5.0]);
let cradle = (cylinder([-7.5, reach + r, 0], "X", r + 3.5, 15.0) - cylinder([-8.0, reach + r, 0], "X", r + 0.5, 16.0)) - box_from_corners([-10.0, reach - 2.0, 2.0], [10.0, reach + rod_d + 10.0, r + 10.0]).translate([0, 2.0, 0]);
fuse_all([plate, arm, cradle])
