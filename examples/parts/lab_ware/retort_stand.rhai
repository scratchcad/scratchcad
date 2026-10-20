// Retort stand: 200 x 130 x 12 mm cast base with rounded corners, M10 threaded boss 20 mm tall, 12 mm rod 600 mm long
let rod = 600.0; // [300.0, 1000.0] Rod length (mm)
let base = box_from_corners([0, 0, 0], [200.0, 130.0, 12.0]).fillet(15.0, "|Z").chamfer(2.0, ">Z");
let boss = cylinder([30.0, 65.0, 11.9], "Z", 12.0, 20.0);
let stand = base + boss - cylinder([30.0, 65.0, 15.0], "Z", 4.25, 20.0);
compound([stand, cylinder([30.0, 65.0, 16.0], "Z", 6.0, rod)])
