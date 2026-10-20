// 5.25 in drive bay blank bezel: 148 x 42.3 mm face, 3 mm thick, two snap legs 12 mm, vent slots
let width = 148.0; // [146.0, 150.0] Bezel width (mm)
let height = 42.3; // [41.0, 44.0] Bezel height (mm)
let t = 3.0; // [2.0, 4.0] Face thickness (mm)
let face = box_centered(width, height, t).translate([0, 0, t / 2.0]);
let f = face.fillet(1.0, face.edges("|Z"));
let legs = [];
for s in [-1.0, 1.0] { legs.push(box_from_corners([s * (width / 2.0 - 3.0) - 1.0, -6.0, -12.0], [s * (width / 2.0 - 3.0) + 1.0, 6.0, 0.01]) + box_from_corners([s * (width / 2.0 - 3.0) - 1.0 + s * 1.5, -6.0, -12.0], [s * (width / 2.0 - 3.0) + 1.0 + s * 1.5, 6.0, -10.0])); }
let vents = [];
for k in 0..8 { vents.push(box_centered(80.0, 1.5, 10.0).translate([0, -12.0 + k.to_float() * 3.5, 0])); }
f + fuse_all(legs) - compound(vents)
