// Retort ring with clamp: 100 mm ring of 8 mm rod, 80 mm arm, 20 x 20 x 25 mm boss with a 13 mm rod bore and thumb screw
let ring_d = 100.0; // [50.0, 150.0] Ring inner diameter (mm)
let R = ring_d / 2.0 + 4.0;
let ring = torus(R, 4.0).translate([R + 80.0, 0, 0]);
let arm = cylinder([10.0, 0, 0], "X", 4.0, 72.0);
let boss = box_centered(20.0, 20.0, 25.0) - cylinder([0, 0, -13.0], "Z", 6.5, 26.0);
let screw = cylinder([-30.0, 0, 0], "X", 3.0, 25.0) + cylinder([-36.0, 0, 0], "X", 8.0, 6.0);
compound([fuse_all([ring, arm, boss]) - cylinder([-12.0, 0, 0], "X", 3.1, 6.0), screw])
