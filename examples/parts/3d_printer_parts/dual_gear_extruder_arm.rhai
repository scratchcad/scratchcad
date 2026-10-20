// Dual-gear extruder tension arm: 45 mm arm, 3 mm pivot, idler gear pocket 12 mm, M3 tension screw slot
let length = 45.0; // [30.0, 60.0] Arm length (mm)
let thickness = 8.0; // [5.0, 12.0] Thickness (mm)
let arm = sketch("XY").move_to(0, -5).line_to(length, -4).line_to(length, 4).line_to(12.0, 8).arc_to(0, 9, -6, 0).close().to_face().extrude(thickness);
arm = arm - cylinder([0, 0, -1], "Z", 1.6, thickness + 2.0) - cylinder([16.0, 9.0, 1.5], "Z", 6.5, thickness);
arm - box_from_corners([length - 8.0, -1.6, -1], [length - 2.0, 1.6, thickness + 1]) - cylinder([16.0, 9.0, -1], "Z", 1.55, thickness + 2.0)
