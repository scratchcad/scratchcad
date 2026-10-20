// Raspberry Pi camera v2 mount: 25 x 24 mm board plate, M2 holes 21 x 12.5 mm, 8 mm lens hole, ball pivot arm
let thickness = 2.5; // [1.5, 4.0] Thickness (mm)
let arm = 30.0; // [15.0, 60.0] Arm length (mm)
let plate = box_centered(25.0, 24.0, thickness).translate([0, 0, thickness / 2.0]).fillet(2.0, "|Z");
for sx in [-1, 1] { for y in [-5.25, 7.25] { plate -= cylinder([sx * 10.5, y, -1], "Z", 1.1, thickness + 2.0); } }
plate = plate - cylinder([0, -2.5, -1], "Z", 4.0, thickness + 2.0);
let stem = box_centered(6.0, thickness, arm).translate([0, 12.0 - thickness / 2.0, -arm / 2.0 + thickness]);
plate + stem + sphere([0, 12.0 - thickness / 2.0, -arm + thickness], 5.0)
