// Brush-style cable entry frame: 100 x 30 mm opening, 120 x 50 mm frame 3 mm, 2 mm slit comb fingers 1 mm
let w = 100.0; // [50.0, 200.0] Opening width (mm)
let h = 30.0; // [20.0, 60.0] Opening height (mm)
let t = 3.0; // [2.0, 5.0] Frame thickness (mm)
let frame = box_centered(w + 20.0, h + 20.0, t).translate([0, 0, t / 2.0]) - box_centered(w, h, t * 3.0);
let comb = [];
let n = (w / 3.0).floor().to_int();
for i in 0..n { comb.push(box_from_corners([-w / 2.0 + 1.0 + i.to_float() * 3.0, -h / 2.0 - 0.01, 0], [-w / 2.0 + 2.0 + i.to_float() * 3.0, -1.0, 1.0]) + box_from_corners([-w / 2.0 + 1.0 + i.to_float() * 3.0, 1.0, 0], [-w / 2.0 + 2.0 + i.to_float() * 3.0, h / 2.0 + 0.01, 1.0])); }
frame + fuse_all(comb) - cylinder([-w / 2.0 - 5.0, 0, -1], "Z", 2.2, t + 2.0) - cylinder([w / 2.0 + 5.0, 0, -1], "Z", 2.2, t + 2.0)
