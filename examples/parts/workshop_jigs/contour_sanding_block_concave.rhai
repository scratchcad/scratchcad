// Concave contour sanding block for convex mouldings: 100 x 60 x 30 mm, R40 concave face 8 mm deep along the length, side finger grooves
let length = 100.0; // [70.0, 150.0] Block length (mm)
let width = 60.0; // [40.0, 80.0] Block width (mm)
let height = 30.0; // [20.0, 45.0] Block height (mm)
let radius = 40.0; // [25.0, 80.0] Concave radius (mm)
let depth = 8.0; // [3.0, 12.0] Concave depth (mm)
let blk = box_from_corners([0, -width / 2.0, 0], [length, width / 2.0, height]);
let b = blk.fillet(3.0, blk.edges(">Z"));
let d = min(depth, height - 10.0);
let cut = cylinder([-1, 0, d - radius], "X", radius, length + 2.0);
let grooves = cylinder([10.0, -width / 2.0, height * 0.65], "X", 5.0, length - 20.0) + cylinder([10.0, width / 2.0, height * 0.65], "X", 5.0, length - 20.0);
b - cut - grooves
