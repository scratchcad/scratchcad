// Enclosure gland plate: 150 x 60 x 2 mm with 2 x M20 (20.5 mm) and 2 x M25 (25.5 mm) knockouts, 4 M4 slots
let length = 150.0; // [100.0, 250.0] Plate length (mm)
let width = 60.0; // [40.0, 100.0] Plate width (mm)
let t = 2.0; // [1.5, 3.0] Thickness (mm)
let plate = box_centered(length, width, t).translate([0, 0, t / 2.0]);
let p = plate.fillet(3.0, plate.edges("|Z"));
let holes = cylinder([-50.0, 0, -1], "Z", 10.25, t + 2.0) + cylinder([-20.0, 0, -1], "Z", 10.25, t + 2.0) + cylinder([15.0, 0, -1], "Z", 12.75, t + 2.0) + cylinder([50.0, 0, -1], "Z", 12.75, t + 2.0);
let slots = [];
for sx in [-1.0, 1.0] { for sy in [-1.0, 1.0] { slots.push(box_centered(6.0, 4.4, t + 2.0).translate([sx * (length / 2.0 - 6.0), sy * (width / 2.0 - 5.0), t / 2.0])); } }
p - holes - compound(slots)
