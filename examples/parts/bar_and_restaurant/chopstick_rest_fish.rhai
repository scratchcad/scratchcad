// Chopstick rest: 50 x 12 x 12 mm saddle with two 6 mm grooves 8 mm apart, flat base
let length = 50.0; // [35.0, 70.0] Length (mm)
let width = 12.0; // [8.0, 18.0] Width (mm)
let height = 12.0; // [8.0, 16.0] Height (mm)
let body = box_centered(length, width, height).translate([0, 0, height / 2.0]);
let b = body.fillet(width / 2.0 - 0.5, body.edges("|Z"));
let saddle = cylinder([0, -width, height + 25.0 - 4.0], "Y", 25.0, width * 2.0);
let grooves = cylinder([-length / 2.0 - 1.0, -4.0, height - 1.0], "X", 3.0, length + 2.0) + cylinder([-length / 2.0 - 1.0, 4.0, height - 1.0], "X", 3.0, length + 2.0);
b - saddle - grooves
