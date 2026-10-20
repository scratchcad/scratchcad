// EVA yoga block: 230 x 150 x 76 mm with 8 mm rounded edges and finger grooves 20 mm wide on both long sides
let l = 230.0; // [200.0, 240.0] Length (mm)
let w = 150.0; // [100.0, 160.0] Width (mm)
let h = 76.0; // [50.0, 100.0] Height (mm)
let b = box_centered(l, w, h).fillet(8.0);
for s in [-1.0, 1.0] { b -= cylinder([-25.0, s * (w / 2.0 + 6.0), 0], "X", 10.0, 50.0) & box_centered(60.0, 30.0, 20.0).translate([0, s * (w / 2.0), 0]); }
b
