// Contact sensor magnet housing: 30 x 10 x 10 mm, 20 x 5 x 3 mm magnet pocket, snap lid groove, 2 screw holes (body only)
let length = 30.0; // [20.0, 45.0] Length (mm)
let width = 10.0; // [8.0, 15.0] Width (mm)
let height = 10.0; // [6.0, 15.0] Height (mm)
let body = box_centered(length, width, height).translate([0, 0, height / 2.0]);
let b = body.fillet(2.0, body.edges("|Z"));
let pocket = box_centered(20.4, 5.4, 3.4).translate([0, 0, height - 1.7]);
let groove = box_centered(length - 3.0, width - 3.0, 1.0).translate([0, 0, height - 0.5]);
b - pocket - groove - cylinder([-length / 2.0 + 3.5, 0, -1], "Z", 1.2, height + 2.0) - cylinder([length / 2.0 - 3.5, 0, -1], "Z", 1.2, height + 2.0)
