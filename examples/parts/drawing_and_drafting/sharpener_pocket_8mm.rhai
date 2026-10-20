// Pocket pencil sharpener body: 25 x 15 x 13 mm, 8 mm cone hole at 23 degrees, blade seat 22 x 8 mm with M2 hole
let length = 25.0; // [20.0, 35.0] Length (mm)
let width = 15.0; // [12.0, 20.0] Width (mm)
let height = 13.0; // [10.0, 18.0] Height (mm)
let pencil = 8.0; // [6.0, 12.0] Pencil diameter (mm)
let body = box_centered(length, width, height).translate([0, 0, height / 2.0]);
let b = body.fillet(1.5, body.edges("|Y"));
let cone_l = pencil / 2.0 / (11.5 * PI() / 180.0).tan();
let hole = cone(pencil / 2.0, 0.3, cone_l).rotate_y(90.0).translate([-length / 2.0 - 0.01, 0, height / 2.0 + 0.5]);
let seat = box_from_corners([-length / 2.0 + 2.0, -width / 2.0 + 3.0, height - 1.0], [length / 2.0 - 1.0, width / 2.0 - 3.0, height + 1.0]);
let slot = box_from_corners([-length / 2.0 + 3.0, -1.0, height / 2.0], [length / 2.0 - 3.0, 1.0, height + 1.0]);
b - hole - seat - slot - cylinder([length / 2.0 - 5.0, 0, height / 2.0 - 2.0], "Z", 0.8, height)
