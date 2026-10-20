// French curve: 200 mm spline template, 2 mm thick, with an inner cut-out
let thickness = 2.0; // [1.5, 3.0] Thickness (mm)
let scale = 1.0; // [0.5, 1.5] Size scale
let pts = [[0, 0, 0], [40, 25, 0], [90, 30, 0], [150, 55, 0], [200, 40, 0], [185, 15, 0], [140, 20, 0], [100, 5, 0], [55, -10, 0], [20, -12, 0]];
let outline = face(wire([spline(pts, true)]));
let blank = outline.extrude([0, 0, thickness]);
let inner_pts = [[50, 5, 0], [90, 15, 0], [130, 30, 0], [150, 35, 0], [125, 15, 0], [85, 3, 0]];
let hole = face(wire([spline(inner_pts, true)])).extrude([0, 0, thickness + 2.0]).translate([0, 0, -1.0]);
(blank - hole).scale(scale)
