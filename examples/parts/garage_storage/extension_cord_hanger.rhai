// Extension cord wrap hanger: 150 x 60 mm H-shaped winder plate 5 mm with a 20 mm wall hook slot
let length = 150.0; // [100.0, 250.0] Length (mm)
let width = 60.0; // [40.0, 100.0] Width (mm)
let t = 5.0; // [3.0, 8.0] Thickness (mm)
let plate = box_centered(length, width, t).translate([0, 0, t / 2.0]);
let p = plate.fillet(6.0, plate.edges("|Z"));
let notches = box_centered(length - 50.0, 20.0, t + 2.0).translate([0, width / 2.0, t / 2.0]) + box_centered(length - 50.0, 20.0, t + 2.0).translate([0, -width / 2.0, t / 2.0]);
let n = notches.fillet(5.0, notches.edges("|Z"));
p - n - cylinder([-length / 2.0 + 12.0, 0, -1], "Z", 6.0, t + 2.0) - box_from_corners([-length / 2.0 - 1.0, -3.0, -1], [-length / 2.0 + 12.0, 3.0, t + 1.0])
