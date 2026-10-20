// Compensated acoustic bridge saddle: 72 x 3.2 mm, 11 mm tall with a 400 mm top radius and a B-string compensation step
let len = 72.0; // [60.0, 80.0] Length (mm)
let h = 11.0; // [8.0, 14.0] Height (mm)
let saddle = box_centered(len, 3.2, h).translate([0, 0, h / 2.0]) & cylinder([0, -5.0, h - 400.0], "Y", 400.0, 10.0);
// round the two top end corners (the top is a large cylinder, whose seam runs along it)
saddle = saddle.fillet(1.0, saddle.edges("|Y").filter(|e| e.point_at(0.5).z > h / 2.0 && e.point_at(0.5).x.abs() > len / 2.0 - 0.01));
saddle - box_from_corners([len * 0.1, -2.0, h - 1.2], [len * 0.28, 0.2, h + 1.0])
