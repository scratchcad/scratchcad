// A5 countertop brochure holder: 155 mm wide pocket for 148 x 210 leaflets, 25 mm deep, 15 degree lean, 2.5 mm acrylic-style walls
let width = 155.0; // [110.0, 230.0] Inner width (mm)
let depth = 25.0; // [10.0, 50.0] Pocket depth (mm)
let back_h = 160.0; // [100.0, 300.0] Back height (mm)
let front_h = 90.0; // [40.0, 150.0] Front height (mm)
let t = 2.5; // [2.0, 4.0] Wall (mm)
let shell = polygon([[0, 0], [depth + 2.0 * t + 40.0, 0], [depth + 2.0 * t + 40.0, t], [depth + 2.0 * t, t], [depth + 2.0 * t, front_h], [depth + t, front_h], [depth + t, t], [t, t], [t, back_h], [0, back_h]]).to_face().extrude([0, 0, width + 2.0 * t]).rotate_x(90.0).translate([0, width + 2.0 * t, 0]);
let sides = box_from_corners([0, 0, 0], [depth + 2.0 * t, t, front_h]) + box_from_corners([0, width + t, 0], [depth + 2.0 * t, width + 2.0 * t, front_h]);
(shell + sides).rotate([0, 0, 0], "Y", -15.0) & box_from_corners([-100, -10, 0], [200, width + 20.0, 400])
