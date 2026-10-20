// Dreidel: 25 mm square body 25 mm tall with recessed letter panels, pyramid point, 6 mm stem 18 mm tall
let s = 25.0; // [15.0, 40.0] Body size (mm)
let body = box_centered(s, s, s).translate([0, 0, s / 2.0 + s * 0.6]).fillet(1.5, "|Z");
let point = loft([rect(plane([0, 0, 0], "Z"), 1.5, 1.5), rect(plane([0, 0, s * 0.6 + 0.01], "Z"), s, s)], true);
let d = fuse_all([body, point, cylinder([0, 0, s * 1.6 - 0.1], "Z", 3.0, 18.0).fillet(1.0, ">Z")]);
let panels = [];
for k in 0..4 { panels.push(box_centered(1.0, s - 8.0, s - 8.0).translate([s / 2.0, 0, s * 1.1]).rotate("Z", k.to_float() * 90.0)); }
d - fuse_all(panels)
