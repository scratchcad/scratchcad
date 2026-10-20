// Compost thermometer sleeve: protective push-in sleeve for a 500 mm compost thermometer with an 8 mm stem and 50 mm dial, 12 mm OD tube 450 mm long, 1.5 mm wall, pointed 30 mm tip with 4 vent slots, 60 mm dial cup with T-handle
// # Stem
let stem = 8.0; // [5.0, 10.0] Thermometer stem diameter (mm)
let length = 450.0; // [200.0, 600.0] Sleeve length (mm)
let wall = 1.5; // [1.2, 3.0] Wall thickness (mm)
// # Head
let dial = 50.0; // [35.0, 75.0] Dial diameter (mm)
let handle = 100.0; // [70.0, 140.0] T-handle span (mm)
let ro = stem / 2.0 + 0.5 + wall;
let tube = cylinder([0, 0, 0], "Z", ro, length) - cylinder([0, 0, 2.0], "Z", stem / 2.0 + 0.5, length);
let tip = cone(0.8, ro, 30.0).translate([0, 0, -29.99]);
let vents = [];
for i in 0..4 {
    vents.push(box_centered(2.0, ro * 3.0, 20.0).rotate_z(i.to_float() * 45.0).translate([0, 0, 25.0]));
}
let cup_r = dial / 2.0 + 5.0;
let cup = cylinder([0, 0, length - 0.01], "Z", cup_r, 25.0) - cylinder([0, 0, length + 3.0], "Z", dial / 2.0 + 1.0, 25.0);
let bar = box_centered(handle, 14.0, 10.0).translate([0, 0, length + 5.0]).fillet(6.5, "|Z");
let bore_through = cylinder([0, 0, length - 1.0], "Z", stem / 2.0 + 0.5, 10.0);
(tube + tip + cup + bar) - fuse_all(vents) - bore_through
