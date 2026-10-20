// Wooden track bridge pier: 50 x 60 mm, 64 mm tall with a 40 mm track saddle 3 mm deep and an arch cut-out 30 mm
let height = 64.0; // [32.0, 128.0] Pier height (mm)
let width = 60.0; // [50.0, 80.0] Pier width (mm)
let depth = 50.0; // [40.0, 70.0] Pier depth (mm)
let p = box_from_corners([-width / 2.0, -depth / 2.0, 0], [width / 2.0, depth / 2.0, height]);
let saddle = box_from_corners([-21.0, -depth, height - 3.0], [21.0, depth, height + 1.0]);
let arch = box_from_corners([-15.0, -depth, -1], [15.0, depth, height * 0.4]) + cylinder([0, -depth, height * 0.4], "Y", 15.0, depth * 2.0);
p - saddle - arch
