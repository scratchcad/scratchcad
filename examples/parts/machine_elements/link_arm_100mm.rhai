// Straight linkage arm: 100 mm hole centres, two 8 mm pivot holes with 20 mm round ends, 12 mm waist, 5 mm thick, 0.5 mm edge chamfer
let centres = 100.0; // [30.0, 300.0] Hole centre distance (mm)
let hole_diameter = 8.0; // [3.0, 20.0] Pivot hole diameter (mm)
let end_diameter = 20.0; // [8.0, 40.0] End boss diameter (mm)
let waist = 12.0; // [5.0, 30.0] Waist width (mm)
let thickness = 5.0; // [2.0, 15.0] Thickness (mm)
let re = max(end_diameter / 2.0, hole_diameter / 2.0 + 2.0);
let w = min(waist, 2.0 * re - 1.0);
let bar = box_from_corners([0, -w / 2.0, 0], [centres, w / 2.0, thickness]);
let arm = fuse_all([bar, cylinder(re, thickness), cylinder([centres, 0, 0], "Z", re, thickness)]);
arm = arm - cylinder([0, 0, -1], "Z", hole_diameter / 2.0, thickness + 2.0) - cylinder([centres, 0, -1], "Z", hole_diameter / 2.0, thickness + 2.0);
arm.chamfer(min(0.5, thickness * 0.15), ">Z or <Z")
