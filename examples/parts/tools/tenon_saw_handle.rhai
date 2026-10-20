// Closed tenon saw handle: 120 x 100 mm, 22 mm thick, 85 x 30 mm hand hole, blade kerf slot 50 mm deep, two 6 mm saw-nut holes
let t = 22.0; // [18.0, 26.0] Thickness (mm)
let outline = polygon([[0, 0], [30, -10], [110, -5], [120, 15], [100, 30], [70, 40], [50, 100], [20, 100], [0, 70]]).to_face().extrude(t).fillet(4.0, "|Z");
let hole = (box_centered(60.0, 30.0, t + 4.0) + cylinder([-30.0, 0, -t], "Z", 15.0, 3.0 * t) + cylinder([30.0, 0, -t], "Z", 15.0, 3.0 * t)).rotate("Z", 60.0).translate([45.0, 45.0, t / 2.0]);
let handle = outline - hole - box_from_corners([-1.0, 8.0, t / 2.0 - 0.4], [50.0, 92.0, t / 2.0 + 0.4]);
for p in [[15.0, 25.0], [20.0, 75.0]] { handle -= cylinder([p[0], p[1], -1], "Z", 3.0, t + 2.0); }
handle
