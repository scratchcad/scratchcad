// Seed drill coulter bar spacer: 40 x 40 mm square tube clamp 6 mm thick, 50 mm long, 2 M12 bolt holes
let tube = 40.0; // [30.0, 60.0] Square bar size (mm)
let t = 6.0; // [4.0, 10.0] Wall (mm)
let length = 50.0; // [30.0, 80.0] Clamp length (mm)
let c = box_centered(tube + 2.0 * t, length, tube + 2.0 * t) - box_centered(tube + 0.5, length + 2.0, tube + 0.5) - box_centered(4.0, length + 2.0, t * 3.0).translate([0, 0, tube / 2.0 + t / 2.0]);
let ears = box_from_corners([-12.0, -length / 2.0, tube / 2.0 + t - 0.01], [-2.0, length / 2.0, tube / 2.0 + t + 12.0]) + box_from_corners([2.0, -length / 2.0, tube / 2.0 + t - 0.01], [12.0, length / 2.0, tube / 2.0 + t + 12.0]);
c + ears - cylinder([-20.0, -length / 4.0, tube / 2.0 + t + 6.0], "X", 6.5, 40.0) - cylinder([-20.0, length / 4.0, tube / 2.0 + t + 6.0], "X", 6.5, 40.0)
