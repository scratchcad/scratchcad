// Sanding block: 110 x 65 x 25 mm with finger grip grooves along both sides, two 3 mm paper clamp slots, rounded top edges
let len = 110.0; // [80.0, 150.0] Length (mm)
let w = 65.0; // [40.0, 90.0] Width (mm)
let b = box_centered(len, w, 25.0).translate([0, 0, 12.5]).fillet(5.0, ">Z");
for s in [-1.0, 1.0] { b -= cylinder([-len / 2.0 - 1.0, s * (w / 2.0 + 2.0), 15.0], "X", 5.0, len + 2.0); }
for x in [-len / 2.0 + 8.0, len / 2.0 - 8.0] { b -= box_centered(3.0, w + 2.0, 16.0).translate([x, 0, 25.0]); }
b
