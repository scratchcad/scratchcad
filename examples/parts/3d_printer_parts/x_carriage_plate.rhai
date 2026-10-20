// X carriage plate for V-slot: 65 x 65 x 6 mm with 3 wheel holes (two fixed 5 mm, one 7.2 mm eccentric) and a 4-hole hotend pattern
let size = 65.0; // [50.0, 100.0] Plate size (mm)
let thickness = 6.0; // [4.0, 10.0] Thickness (mm)
let wheel_span = 39.6; // [30.0, 60.0] Wheel hole spacing (mm)
let plate = box_centered(size, size, thickness).translate([0, 0, thickness / 2.0]).fillet(5.0, "|Z");
plate = plate - cylinder([-wheel_span / 2.0, size / 2.0 - 8.0, -1], "Z", 2.55, thickness + 2.0) - cylinder([wheel_span / 2.0, size / 2.0 - 8.0, -1], "Z", 2.55, thickness + 2.0);
plate = plate - cylinder([0, -size / 2.0 + 8.0, -1], "Z", 3.6, thickness + 2.0);
for sx in [-1, 1] { for sy in [-1, 1] { plate -= cylinder([sx * 10.0, sy * 10.0, -1], "Z", 1.6, thickness + 2.0); } }
plate - box_centered(20.0, 8.0, thickness + 2.0).translate([0, 0, thickness / 2.0]).fillet(3.9, "|Z")
