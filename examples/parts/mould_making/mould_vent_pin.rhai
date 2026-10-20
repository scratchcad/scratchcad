// Mould air vent pin: 2 mm pin 40 mm long tapering to 1 mm, on a 8 mm grip head 3 mm, for venting silicone moulds during casting
let length = 40.0; // [20.0, 80.0] Pin length (mm)
let pin = 2.0; // [1.5, 4.0] Pin diameter (mm)
let head = cylinder([0, 0, 0], "Z", 4.0, 3.0);
let head = head.chamfer(0.5, head.edges(">Z"));
let p = cone(pin / 4.0, pin / 2.0, length).rotate_x(180.0).translate([0, 0, 0.01]);
head + p
