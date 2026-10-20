// Printed Z coupler, 5 mm motor shaft to 8 mm lead screw: 20 mm square, 30 mm long, two clamp halves with 4 M3 screws
let size = 20.0; // [16.0, 30.0] Body width (mm)
let length = 30.0; // [20.0, 45.0] Length (mm)
let motor = 5.0; // [3.0, 8.0] Motor shaft (mm)
let screw = 8.0; // [5.0, 12.0] Lead screw (mm)
let body = box_centered(size, size, length).translate([0, 0, length / 2.0]).fillet(3.0, "|Z");
body = body - cylinder([0, 0, -1], "Z", motor / 2.0, length / 2.0 + 1.0) - cylinder([0, 0, length / 2.0], "Z", screw / 2.0, length / 2.0 + 1.0);
body = body - box_centered(size + 2.0, 0.8, length + 2.0).translate([0, 0, length / 2.0]);
for z in [length * 0.2, length * 0.8] { for s in [-1, 1] { body -= cylinder([s * size * 0.32, -size, z], "Y", 1.6, size * 2.0); } }
body
