// Bathtub overflow cover plate: 70 mm dome 12 mm tall, 2 mm wall, 30 x 6 mm overflow slot near the bottom, centre screw hole countersunk for M5
let diameter = 70.0; // [55.0, 90.0] Cover diameter (mm)
let height = 12.0; // [8.0, 20.0] Dome height (mm)
let wall = 2.0; // [1.5, 3.0] Wall thickness (mm)
let slot_length = 30.0; // [15.0, 45.0] Slot length (mm)
let slot_width = 6.0; // [3.0, 10.0] Slot width (mm)
let R = diameter / 2.0;
let outer = sketch("XZ").move_to(0, 0).hline_to(R).vline_to(2.0).arc_to(R * 0.75, height * 0.75, 0, height).close().to_face().revolve("Z", 360);
let inner = sketch("XZ").move_to(0, -1.0).hline_to(R - wall).vline_to(1.0).arc_to(R * 0.75 - wall, height * 0.75 - wall, 0, height - wall).close().to_face().revolve("Z", 360);
let cover = outer - inner;
cover += cylinder([0, 0, 0], "Z", 6.0, height - 0.5);
let sl = min(slot_length, diameter - 20.0);
cover -= box_centered(sl, slot_width, 2.0 * height).translate([0, -R * 0.55, height / 2.0]).fillet(slot_width * 0.45, "|Z");
cover -= cylinder([0, 0, -1.0], "Z", 2.7, height + 2.0);
cover - cone(2.7, 5.4, 2.7).translate([0, 0, height - 2.69])
