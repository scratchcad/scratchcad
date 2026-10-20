// Keyhole wall hanger plate: 40 x 20 x 2.5 mm, keyhole slot for a 9 mm screw head, two 4 mm fixing holes
let length = 40.0; // [25.0, 80.0] Length (mm)
let width = 20.0; // [12.0, 40.0] Width (mm)
let thickness = 2.5; // [1.5, 5.0] Thickness (mm)
let head_d = 9.0; // [6.0, 14.0] Screw head diameter (mm)
let shank_d = 4.5; // [3.0, 7.0] Screw shank diameter (mm)
let plate = box_centered(width, length, thickness).translate([0, 0, thickness / 2.0]).fillet(width * 0.45, "|Z");
let keyhole = cylinder([0, -4.0, -1], "Z", head_d / 2.0, thickness + 2.0) + box_from_corners([-shank_d / 2.0, -4.0, -1], [shank_d / 2.0, 6.0, thickness + 1]) + cylinder([0, 6.0, -1], "Z", shank_d / 2.0, thickness + 2.0);
plate - keyhole - cylinder([0, length / 2.0 - 5.0, -1], "Z", 2.0, thickness + 2.0) - cylinder([0, -length / 2.0 + 4.0, -1], "Z", 2.0, thickness + 2.0)
