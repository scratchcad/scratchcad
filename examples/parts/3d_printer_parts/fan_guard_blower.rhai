// 5015 blower fan housing mockup: 51 x 51 x 15 mm volute with a 20 x 15 mm outlet and two M3 mount ears
let size = 51.0; // [40.0, 75.0] Fan size (mm)
let thickness = 15.0; // [10.0, 20.0] Thickness (mm)
let r = size / 2.0 - 3.0;
let body = cylinder(r, thickness) + box_from_corners([0, -r, 0], [r, r * 0.2, thickness]) + box_from_corners([r - 0.01, -r, 0], [r + 20.0, -r + 15.0, thickness]).translate([-10.0, 0, 0]);
body = body - cylinder([0, 0, thickness - 2.0], "Z", 12.0, 3.0);
let ears = cylinder([-r * 0.85, r * 0.6, 0], "Z", 3.5, thickness) + cylinder([r * 0.65, r * 0.85, 0], "Z", 3.5, thickness);
(body + ears) - cylinder([-r * 0.85, r * 0.6, -1], "Z", 1.6, thickness + 2.0) - cylinder([r * 0.65, r * 0.85, -1], "Z", 1.6, thickness + 2.0)
