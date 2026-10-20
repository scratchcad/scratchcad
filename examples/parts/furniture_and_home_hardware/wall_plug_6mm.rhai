// 6 mm nylon wall plug: 30 mm body with eight barb rings, 8 mm collar, two anti-rotation fins, split tip, 3.5 mm screw bore
let len = 30.0; // [20.0, 60.0] Length (mm)
let d = 6.0; // [4.0, 12.0] Drill size (mm)
let r = d / 2.0;
let plug = cylinder(r - 0.3, len) + cylinder([0, 0, -1.0], "Z", r + 1.0, 1.0);
let n = ((len - 4.0) / 3.0).to_int();
for k in 0..n { plug += cone(r - 0.3, r + 0.2, 1.5).translate([0, 0, 2.0 + k.to_float() * 3.0]); }
for a in [0.0, 180.0] { plug += box_from_corners([r - 0.6, -0.4, 0], [r + 0.5, 0.4, 6.0]).rotate("Z", a); }
plug - cylinder([0, 0, -2], "Z", 1.75, len + 3.0) - box_centered(d + 2.0, 1.0, len * 0.6).translate([0, 0, len * 0.7 + 0.01])
