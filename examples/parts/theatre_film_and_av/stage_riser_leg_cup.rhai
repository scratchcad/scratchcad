// Stage riser leg cup: foot cup for a 40 x 40 mm square riser leg, 2.5 mm walls 30 mm tall, 70 mm round non-marking pad 8 mm thick with a 1 mm chamfer, central 6 mm screw hole
let leg = 40.0; // [30.0, 60.0] Leg size (mm)
let wall = 2.5; // [2.0, 4.0] Wall thickness (mm)
let cup_height = 30.0; // [15.0, 50.0] Cup height (mm)
let pad = 70.0; // [55.0, 100.0] Pad diameter (mm)
let pad_t = 8.0; // [5.0, 12.0] Pad thickness (mm)
let base = cylinder(pad / 2.0, pad_t);
let b = base.chamfer(1.0, base.edges("<Z"));
let cup = box_centered(leg + 2.0 * wall, leg + 2.0 * wall, cup_height).translate([0, 0, pad_t + cup_height / 2.0 - 0.01]);
let c = cup.fillet(2.0, cup.edges("|Z"));
let socket = box_centered(leg + 0.4, leg + 0.4, cup_height).translate([0, 0, pad_t + cup_height / 2.0 + 0.5]);
(b + c) - socket - cylinder([0, 0, -1.0], "Z", 3.0, pad_t + 3.0)
