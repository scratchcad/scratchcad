// Compass lead holder: 2 mm lead, 25 mm long 5 mm body with clamp slot and M2 clamp screw boss
let lead = 2.0; // [0.5, 3.0] Lead diameter (mm)
let length = 25.0; // [18.0, 35.0] Length (mm)
let body_d = 5.0; // [4.0, 8.0] Body diameter (mm)
let body = cylinder(body_d / 2.0, length) + box_from_corners([-body_d / 2.0 - 2.0, -1.5, length - 8.0], [-body_d / 2.0 + 0.5, 1.5, length]);
let b = body - cylinder([0, 0, -1], "Z", lead / 2.0 + 0.05, length + 2.0) - box_from_corners([-0.3, -body_d, -1], [0.3, body_d, length * 0.4]);
b - cylinder([-body_d / 2.0 - 3.0, 0, length - 4.0], "X", 0.8, body_d)
