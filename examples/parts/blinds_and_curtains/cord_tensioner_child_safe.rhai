// Child-safety cord tensioner: 50 x 18 x 15 mm housing, 25 mm pulley slot, wall bracket with 2 holes
let length = 50.0; // [35.0, 70.0] Length (mm)
let width = 18.0; // [12.0, 25.0] Width (mm)
let depth = 15.0; // [10.0, 20.0] Depth (mm)
let body = box_centered(width, depth, length).translate([0, 0, length / 2.0]);
let b = body.fillet(width / 2.0 - 0.5, body.edges("|Y"));
let slot = box_centered(width - 4.0, depth + 2.0, 26.0).translate([0, 0, length * 0.6]);
let axle = cylinder([0, -depth, length * 0.6], "Y", 1.5, depth * 2.0);
let bracket = box_from_corners([-width / 2.0, depth / 2.0 - 0.01, 0], [width / 2.0, depth / 2.0 + 2.5, 15.0]);
b - slot - axle + bracket - cylinder([0, 0, 5.0], "Y", 2.0, depth)
