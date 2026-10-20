// Bowden collet clip (horseshoe): 1.5 mm thick, 10 mm outer, 6 mm inner gap, keeps PC4 collets from releasing
let outer = 10.0; // [8.0, 14.0] Outer size (mm)
let inner = 6.0; // [4.5, 8.0] Gap for the tube (mm)
let thickness = 1.5; // [1.0, 2.5] Thickness (mm)
let c = cylinder(outer / 2.0, thickness) - cylinder([0, 0, -1], "Z", inner / 2.0, thickness + 2.0) - box_from_corners([-inner / 2.0 + 0.3, 0, -1], [inner / 2.0 - 0.3, outer, thickness + 1]);
c + box_from_corners([-outer / 2.0, -outer / 2.0 - 4.0, 0], [outer / 2.0, -outer / 2.0 + 0.5, thickness])
