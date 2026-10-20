// Cable ID tag: 60 x 25 mm tag 1.5 mm thick with a rounded end, 5 mm tie hole and a 50 x 18 mm write-on panel recessed 0.3 mm
let length = 60.0; // [40.0, 90.0] Tag length (mm)
let width = 25.0; // [15.0, 35.0] Tag width (mm)
let thickness = 1.5; // [1.0, 2.5] Thickness (mm)
let hole = 5.0; // [3.0, 7.0] Tie hole diameter (mm)
let body = box_from_corners([0, -width / 2.0, 0], [length - width / 2.0, width / 2.0, thickness]) + cylinder([length - width / 2.0, 0, 0], "Z", width / 2.0, thickness);
let panel = box_from_corners([3.0, -width / 2.0 + 3.5, thickness - 0.3], [length - width - 2.0, width / 2.0 - 3.5, thickness + 1.0]);
let b = body.fillet(2.0, body.edges("|Z and <X"));
b - panel - cylinder([length - width / 2.0, 0, -1], "Z", hole / 2.0, thickness + 2.0)
