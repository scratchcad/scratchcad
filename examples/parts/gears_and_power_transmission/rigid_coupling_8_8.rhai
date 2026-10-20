// Rigid clamping coupling 8 mm to 8 mm: 20 mm OD, 30 mm long, two clamp slits, four M3 clamp screws
let outer_d = 20.0; // [12.0, 50.0] Outside diameter (mm)
let length = 30.0; // [21.6, 80.0] Length (mm)
let bore = 8.0; // [3.0, 14.1] Bore (mm)
let body = cylinder(outer_d / 2.0, length) - cylinder([0, 0, -1], "Z", bore / 2.0, length + 2.0);
body = body - box_centered(1.0, outer_d, length + 2.0).translate([0, outer_d / 2.0, length / 2.0]);
body = body - box_centered(outer_d + 2.0, outer_d + 2.0, 1.0).translate([0, outer_d / 2.0 + bore / 2.0, length / 2.0]);
let y = bore / 2.0 + (outer_d - bore) / 4.0;
for z in [length * 0.2, length * 0.8] {
    body -= cylinder([-outer_d, y, z], "X", 1.7, outer_d * 2.0);
    body -= cylinder([-outer_d / 2.0 - 1.0, y, z], "X", 2.9, outer_d / 2.0 - 1.5);
}
body.chamfer(0.5, "%CIRCLE and (>Z or <Z)")
