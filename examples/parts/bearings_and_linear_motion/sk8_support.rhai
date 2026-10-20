// SK8 shaft support: 42 mm wide, 14 mm thick, 32.8 mm tall, 8 mm shaft at 20 mm, clamp slit, two 5.5 mm holes 32 mm apart
let width = 42.0; // [32.0, 60.0] Width (mm)
let thickness = 14.0; // [10.0, 20.0] Thickness (mm)
let height = 32.8; // [24.0, 45.0] Height (mm)
let shaft_h = 20.0; // [15.0, 30.0] Shaft center height (mm)
let shaft_d = 8.0; // [6.0, 16.0] Shaft diameter (mm)
let hole_spacing = 32.0; // [24.0, 48.0] Mounting hole spacing (mm)
let base = box_centered(width, thickness, 6.0).translate([0, 0, 3.0]);
let tower = box_centered(shaft_d + 10.0, thickness, height).translate([0, 0, height / 2.0]);
let part = (base + tower).fillet(3.0, "|Y and >Z");
part = part - cylinder([0, -thickness, shaft_h], "Y", shaft_d / 2.0, thickness * 2.0);
part = part - box_centered(1.0, thickness + 2.0, height - shaft_h).translate([0, 0, shaft_h + (height - shaft_h) / 2.0 + 0.5]);
part = part - cylinder([-thickness, 0, height - 5.0], "X", 1.5, thickness * 3.0);
for s in [-1, 1] { part -= cylinder([s * hole_spacing / 2.0, 0, -1], "Z", 2.75, 8.0); }
part
