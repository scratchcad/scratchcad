// Pool ladder rail bumper: fits 48 mm tube, 60 mm OD 40 mm tall, flat 10 mm pad face
let tube = 48.0; // [38.0, 51.0] Rail OD (mm)
let od = 60.0; // [50.0, 75.0] Bumper OD (mm)
let height = 40.0; // [25.0, 60.0] Height (mm)
let b = cylinder(od / 2.0, height) - cylinder([0, 0, 5.0], "Z", tube / 2.0, height);
let bb = b.fillet(4.0, b.edges("<Z"));
bb - box_from_corners([od / 2.0 - 4.0, -od, -1], [od, od, height + 1.0])
